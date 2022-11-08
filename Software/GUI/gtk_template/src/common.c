#include "common.h"

void
log_msg (char* format, ...) {
    va_list args;
    va_start(args, format);
    fprintf(stderr, "LOG: ");
    vfprintf(stderr, format, args);
}

//------------------------------------------------------------------------------

void
gtk_build_it (GtkBuilder* builder, struct App_widgets* widgets) {

    widgets->window_main   = GTK_WIDGET(gtk_builder_get_object( builder, "window_main"));
    widgets->window_setup  = GTK_WIDGET(gtk_builder_get_object(builder, "window_setup"));

    widgets->window_main   = GTK_WIDGET(gtk_builder_get_object(builder, "window_main"));
    widgets->window_setup  = GTK_WIDGET(gtk_builder_get_object(builder, "window_setup"));

    widgets->label_time_sys_value     = GTK_WIDGET(gtk_builder_get_object(builder, "label_time_sys_value"));
    widgets->label_serial_port_status = GTK_WIDGET(gtk_builder_get_object(builder, "label_serial_port_status"));
    widgets->label_azm_target         = GTK_WIDGET(gtk_builder_get_object(builder, "label_azm_target"));
    widgets->label_azm_actual         = GTK_WIDGET(gtk_builder_get_object(builder, "label_azm_actual"));
    widgets->label_elv_target         = GTK_WIDGET(gtk_builder_get_object(builder, "label_elv_target"));
    widgets->label_elv_actual         = GTK_WIDGET(gtk_builder_get_object(builder, "label_elv_actual"));
    widgets->label_mode               = GTK_WIDGET(gtk_builder_get_object(builder, "label_mode"));
    widgets->button_mode_auto         = GTK_WIDGET(gtk_builder_get_object(builder, "button_mode_auto"));
    widgets->button_mode_manual       = GTK_WIDGET(gtk_builder_get_object(builder, "button_mode_manual"));
    widgets->button_mode_day          = GTK_WIDGET(gtk_builder_get_object(builder, "button_mode_day"));
    widgets->button_control_home_azm  = GTK_WIDGET(gtk_builder_get_object(builder, "button_control_home_azm"));
    widgets->button_control_home_elv  = GTK_WIDGET(gtk_builder_get_object(builder, "button_control_home_elv"));

    gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(widgets->button_mode_auto),   FALSE); // display radio like normal button
    gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(widgets->button_mode_manual), FALSE);
    gtk_toggle_button_set_mode(GTK_TOGGLE_BUTTON(widgets->button_mode_day),    FALSE);


    gtk_builder_connect_signals(builder, widgets);
}

//------------------------------------------------------------------------------
