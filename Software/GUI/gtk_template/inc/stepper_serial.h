#include <stdio.h>
#include <string.h>

#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <stdlib.h>

#include <string.h>
#include <termios.h>

#include <common.h>

#define PORT_FILE "/dev/ttyUSB0"

#define STEPS_PER_REVOLUTION 6400
#define AZM_HOME_POS         0
#define MAX_STEPS_AZM        STEPS_PER_REVOLUTION - 400
#define ELV_HOME_POS         -61
#define MAX_STEPS_ELV        STEPS_PER_REVOLUTION / 2 - ELV_HOME_POS // *2?
#define DEG_PER_STEP         0.05625 // 1.8/32

void
serial_port_config (int fd);

//double
int
deg_to_steps (double deg);

double
steps_to_deg (int steps);

void
turn_steps_azm (int steps);

void
turn_deg_azm (double deg);

void
seek_steps_azm (unsigned int target_steps);

void
seek_deg_azm (double deg);

void
home_azm();

void
await_response_azm ();

void
turn_steps_elv (int steps);

void
turn_deg_elv (double deg);

void
seek_steps_elv (unsigned int target_steps);

void
seek_deg_elv (double deg);

void
await_response_elv ();

void
home_elv ();

int
itoa(int value, char* result);

void
init_azm(int fd);

void
init_elv(int fd);

struct motor_s {
    int  fd;
    char command_buffer[9];
    char home_command[6];    // e.g. "\nhe\n"
    int  current_pos;
    int  home_pos;
    int  max_pos;
    char name[8];
};
