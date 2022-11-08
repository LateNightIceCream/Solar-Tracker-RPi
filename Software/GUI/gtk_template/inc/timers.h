#ifndef __TIMERS_H_
#define __TIMERS_H_

#include <common.h>

gboolean sys_time_timer_handler(struct App_widgets* widgets);
gboolean auto_update_timer_handler(struct App_widgets* widgets);
gboolean spa_calculation_timer_handler(struct App_widgets* widgets);
gboolean check_serial_port_timer_handler(struct App_widgets* widgets);

#define AUTO_UPDATE_TIMER_INTERVAL 25
#define CHECK_SERIAL_PORT_INTERVAL 1
#define SPA_CALCULATION_INTERVAL   1

#endif // __TIMERS_H_
