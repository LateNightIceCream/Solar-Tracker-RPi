#ifndef __COMMON_H_
#define __COMMON_H_

#include <stdarg.h>
#include <stdio.h>
#include <gtk/gtk.h>

enum Mode {
    AUTO, MANUAL, DAY
};

void
log_msg(char* format, ...);

// maybe there is a better way :D
struct App_widgets {
    GtkWidget* window_main;
    GtkWidget* window_setup;
    GtkWidget* label_time_sys_value;
    GtkWidget* label_current_azm;
    GtkWidget* label_current_elv;
    GtkWidget* label_serial_port_status;
    GtkWidget* label_azm_target;
    GtkWidget* label_azm_actual;
    GtkWidget* label_elv_target;
    GtkWidget* label_elv_actual;
    GtkWidget* label_mode;
    GtkWidget* button_mode_auto;
    GtkWidget* button_mode_manual;
    GtkWidget* button_mode_day;
    GtkWidget* button_control_home_azm;
    GtkWidget* button_control_home_elv;
};

void
gtk_build_it (GtkBuilder* builder, struct App_widgets* widgets);

#endif // __COMMON_H_
