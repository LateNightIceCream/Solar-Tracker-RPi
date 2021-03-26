#include <gtk/gtk.h>

struct App_widgets {
    GtkWidget* window_main;
    GtkWidget* window_setup;
    GtkWidget* label_time_sys_value;
};

gboolean sys_time_timer_handler(struct App_widgets* widgets);

int
main (int argc, char *argv[])
{
    GtkBuilder* builder;
    GtkWidget*  window_main;
    GtkWidget*  window_setup;

    struct App_widgets* widgets = g_slice_new(struct App_widgets);

    gtk_init(&argc, &argv);

    builder = gtk_builder_new_from_file("glade/window_main.glade");

    window_main   = GTK_WIDGET(gtk_builder_get_object(builder, "window_main"));
    window_setup  = GTK_WIDGET(gtk_builder_get_object(builder, "window_setup"));

    widgets->window_main   = GTK_WIDGET(gtk_builder_get_object(builder, "window_main"));
    widgets->window_setup  = GTK_WIDGET(gtk_builder_get_object(builder, "window_setup"));

    widgets->label_time_sys_value = GTK_WIDGET(gtk_builder_get_object(builder, "label_time_sys_value"));

    gtk_builder_connect_signals(builder, widgets);

    g_object_unref(builder);

    // 1 second timer for system time update
    g_timeout_add_seconds(1, (GSourceFunc)sys_time_timer_handler, widgets);

    gtk_window_fullscreen(GTK_WINDOW(window_main));
    gtk_window_fullscreen(GTK_WINDOW(window_setup));

    gtk_widget_show(window_main);
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

// called when window is closed
void on_window_main_destroy()
{
    g_print("Goodbye!");
    gtk_main_quit();
}
