#include <stepper_serial.h>
#include <spa.h>
#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <gtk/gtk.h>

#include <common.h>
#include <timers.h>

int update_spa (spa_data* spa);

void
update_mode(enum Mode mode, struct App_widgets* widgets);

void
manual_controls_set_sensitive(struct App_widgets* widgets, gboolean bool);

// 0: auto
// 1: manual
// 2: day
static enum Mode current_mode = 0;
static int serial_port = -1; // holds fd for serial port
static int serial_port_connected = 0;

unsigned int current_pos_azm = 0;
unsigned int current_pos_elv = 0;

static double target_deg_azm  = 0;
static double target_deg_elv  = 0;
static double current_deg_azm = 0;
static double current_deg_elv = 0;

spa_data spa;

int
main (int argc, char *argv[])
{
    GtkBuilder* builder;
    struct App_widgets* widgets;

    widgets = g_slice_new(struct App_widgets);

    //--------------------------------------------------------------------------

    gtk_init(&argc, &argv);

    builder = gtk_builder_new_from_file("../glade/window_main.glade");
    gtk_build_it(builder, widgets);
    g_object_unref(builder);

    // init auto mode
    gtk_toggle_button_set_active (GTK_TOGGLE_BUTTON(widgets->button_mode_auto),
                                  TRUE);

    // 1 second timer for system time update
    g_timeout_add_seconds( 1,
                           (GSourceFunc)sys_time_timer_handler,
                           widgets);

    // timer for stepper motor / solar positioning update
    g_timeout_add_seconds( AUTO_UPDATE_TIMER_INTERVAL,
                           (GSourceFunc) auto_update_timer_handler,
                           widgets);

    // timer for checking the serial connection / connecting
    g_timeout_add_seconds( CHECK_SERIAL_PORT_INTERVAL,
                           (GSourceFunc)check_serial_port_timer_handler,
                           widgets);

    // spa calculation timeout
    g_timeout_add_seconds( SPA_CALCULATION_INTERVAL,
                           (GSourceFunc)spa_calculation_timer_handler,
                           widgets);

    gtk_window_fullscreen(GTK_WINDOW(widgets->window_main));
    gtk_window_fullscreen(GTK_WINDOW(widgets->window_setup));


    gtk_widget_show(widgets->window_main);
    gtk_main();
    g_slice_free(struct App_widgets, widgets);

    return 0;
}

gboolean
sys_time_timer_handler (struct App_widgets* widgets) {

    GDateTime* date_time;
    gchar*     date_time_string;

    date_time = g_date_time_new_now_local();
    date_time_string = g_date_time_format(date_time, "%H:%M:%S");

    gtk_label_set_text(GTK_LABEL(widgets->label_time_sys_value), date_time_string);
    g_free(date_time_string);

    return TRUE;
}

double get_delta_t_1 (int year) {
    int t = year - 2000;
    return 62.92 + 0.32217 * t + 0.005589 * t * t;
}

int
update_spa (spa_data* spa) {

    int result;
    time_t t;
    struct tm tstruct;

    time(&t);
    tstruct = *gmtime(&t);

    spa->year          = tstruct.tm_year+1900;
    spa->month         = tstruct.tm_mon+1;
    spa->day           = tstruct.tm_mday;
    spa->hour          = tstruct.tm_hour+2;
    spa->minute        = tstruct.tm_min;
    spa->second        = tstruct.tm_sec;
    spa->timezone      = 2.0;
    spa->delta_ut1     = 0;
    spa->delta_t       = get_delta_t_1 (spa->year);
    spa->longitude     = 11.470459;
    spa->latitude      = 53.899963;
    spa->elevation     = 8;
    spa->pressure      = 500; // was 820
    spa->temperature   = 10;
    spa->slope         = 0;
    spa->azm_rotation  = 0;
    spa->atmos_refract = 0.5667;
    spa->function      = SPA_ALL;

    result = spa_calculate(spa);

    return result;
}

// calculate spa
gboolean
spa_calculation_timer_handler(struct App_widgets* widgets) {

    int result;

    // maybe outsource to other timer for display update
    char target_azm_label[64];
    char target_elv_label[64];

    result = update_spa(&spa);

    if (result != 0) {
        printf("Spa result returned: %d\n", result);
        return TRUE;
    }

    target_deg_azm  = spa.azimuth;
    target_deg_elv  = 90.0 - spa.zenith;

    // display stuff
    sprintf(target_azm_label, "%.6f°", target_deg_azm);
    sprintf(target_elv_label, "%.6f°", target_deg_elv);
    gtk_label_set_text(GTK_LABEL(widgets->label_azm_target), target_azm_label);
    gtk_label_set_text(GTK_LABEL(widgets->label_elv_target), target_elv_label);

    return TRUE;
}

// drive the spa angles
gboolean
auto_update_timer_handler(struct App_widgets* widgets) {

    char actual_azm_label[64];
    char actual_elv_label[64];

    if (current_mode != AUTO) {
        return TRUE;
    }

    if (!serial_port_connected) {
        return TRUE;
    }

    log_msg("setting position (deg):\n\tazm:%f\n\telv:%f\n", target_deg_azm, target_deg_elv);
    log_msg("setting position (steps):\n\ts_azm:%d\n\ts_elv:%d\n", deg_to_steps(target_deg_azm), deg_to_steps(target_deg_elv));

    seek_deg_azm(target_deg_azm);
    seek_deg_elv(target_deg_elv);

    current_deg_azm = steps_to_deg(deg_to_steps(target_deg_azm));
    current_deg_elv = steps_to_deg(deg_to_steps(target_deg_elv));

    // display stuff
    sprintf(actual_azm_label, "%.6f°", current_deg_azm);
    sprintf(actual_elv_label, "%.6f°", current_deg_elv);
    gtk_label_set_text(GTK_LABEL(widgets->label_azm_actual), actual_azm_label);
    gtk_label_set_text(GTK_LABEL(widgets->label_elv_actual), actual_elv_label);

    return TRUE;
}

gboolean
check_serial_port_timer_handler(struct App_widgets* widgets) {

    static char markup[256];

    if (access(PORT_FILE, O_RDWR) == 0) {
        if (serial_port_connected) {
            return TRUE;
        }
    } else {
        serial_port_connected = 0;

        //fprintf(stderr, "error accessing %s: ", PORT_FILE);
        //perror("");

        if (close(serial_port) == -1) { // is expected to fail e.g. when file not opened
            //log_msg("Serial Port: error accessing %s: ", PORT_FILE);
            //perror("");
        }

        sprintf(markup, "<span foreground='red'>Error accessing %s</span>", PORT_FILE);
        gtk_label_set_markup(GTK_LABEL(widgets->label_serial_port_status), markup);

        return TRUE;
    }

    serial_port = open(PORT_FILE, O_RDWR);

    if (serial_port == -1) {
        fprintf(stderr, "error opening %s: ", PORT_FILE);
        perror("");

        sprintf(markup, "<span foreground='red'>Error opening %s</span>", PORT_FILE);

        gtk_label_set_markup(GTK_LABEL(widgets->label_serial_port_status), markup);

        serial_port_connected = 0;
        return TRUE;
    }

    serial_port_connected = 1;

    sprintf(markup, "<span foreground='green'>%s connected</span>", PORT_FILE);

    printf("%s\n", markup);

    gtk_label_set_markup(GTK_LABEL(widgets->label_serial_port_status), markup);

    init_azm(serial_port);
    init_elv(serial_port);
    serial_port_config(serial_port);

    log_msg("Homing azm\n");
    home_azm();
    log_msg("Homing elv\n");
    home_elv();

    return TRUE;
}

void
on_button_setup_clicked (GtkButton* button_setup, struct App_widgets* widgets) {
    g_print("SETUP Button clicked");
    gtk_widget_hide(widgets->window_main);
    gtk_widget_show(widgets->window_setup);
}

void
on_button_setup_close_clicked (GtkButton* button, struct App_widgets* widgets) {
    g_print("SETUP CLOSE Button clicked");
    gtk_widget_hide(widgets->window_setup);
    gtk_widget_show(widgets->window_main);
}

void
on_control_home_button_azm_clicked (GtkButton* button, struct App_widgets* widgets) {
    home_azm();
}

void
on_control_home_button_elv_clicked (GtkButton* button, struct App_widgets* widgets) {
    home_elv();
}

// toggle buttons
void
on_button_mode_auto_clicked (GtkWidget* button, struct App_widgets* widgets) {
    update_mode(AUTO, widgets);
}

void
on_button_mode_manual_clicked (GtkButton* button, struct App_widgets* widgets) {
    update_mode(MANUAL, widgets);
}

void
on_button_mode_day_clicked (GtkWidget* button, struct App_widgets* widgets) {
    update_mode(DAY, widgets);
}

// ---------------------

// called when window is closed
void
on_window_main_destroy()
{
    g_print("Goodbye!\n");
    gtk_main_quit();
}

void
update_mode(enum Mode mode, struct App_widgets* widgets) {

    current_mode = mode;

    switch (mode) {
        case AUTO:
            gtk_label_set_text(GTK_LABEL(widgets->label_mode),
                               "Auto");
            log_msg("Setting mode to AUTO\n");

            manual_controls_set_sensitive(widgets, FALSE);

            break;
        case MANUAL:
            gtk_label_set_text(GTK_LABEL(widgets->label_mode),
                               "Manual");
            log_msg("Setting mode to MANUAL\n");

            manual_controls_set_sensitive(widgets, TRUE);

            break;
        case DAY:
            gtk_label_set_text(GTK_LABEL(widgets->label_mode),
                               "Day");
            log_msg("Setting mode to DAY\n");

            manual_controls_set_sensitive(widgets, FALSE);
            break;
    }
}

void
manual_controls_set_sensitive(struct App_widgets* widgets, gboolean bool) {
    gtk_widget_set_sensitive (widgets->button_control_home_azm, bool);
    gtk_widget_set_sensitive (widgets->button_control_home_elv, bool);
}
