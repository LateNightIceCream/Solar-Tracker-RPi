#ifndef __UART_COMMANDS_H_
#define __UART_COMMANDS_H_

#include <stdint.h>
#include <stdlib.h>
#include "stm8s_header.h"
#include "stm8_105.h"

#define UART_RX_BUFFER_SIZE  127
#define MAX_COMMAND_LENGTH   (16 + 2) // + \n + \0 (perhaps)
#define COMMAND_BUFFER_SIZE  16

void    uart2_init();
int     uart2_write(const char *str);
void    init_command_buffer();
char*   read_next_command();
int16_t get_steps_from_command (const char* cmd);


#endif // __UART_COMMANDS_H_
