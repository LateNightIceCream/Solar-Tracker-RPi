#include <stdio.h>
#include <string.h>

#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <stdlib.h>

#include <string.h>
#include <termios.h>

#define PORT_FILE "/dev/ttyUSB0"

#define STEPS_PER_REVOLUTION 6400
#define MAX_STEPS_AZM        STEPS_PER_REVOLUTION - 400

void
serial_port_config (int fd);

void
turn_steps_azm (int steps);

double
deg_to_steps (double deg);

void
turn_deg_azm (double deg);

void
home_azm();

int
itoa(int value, char* result);


struct motor_s {
    int  fd;
    char command_buffer[9];
    int  current_pos;
};

void
init_azm(int fd);

static struct motor_s azm_struct;

int
main(int argc, char *argv[]) {

    int serial_port;

    serial_port = open(PORT_FILE, O_RDWR);

    if (errno) {
        fprintf(stderr, "error opening %s: ", PORT_FILE);
        perror("");
        exit(EXIT_FAILURE);
    }

    init_azm(serial_port);

    serial_port_config(serial_port);

    home_azm();

    turn_deg_azm(45);

    close(serial_port);
    return EXIT_SUCCESS;
}

void
init_azm(int fd) {
    azm_struct.fd = fd;
    strcpy(azm_struct.command_buffer, "\na+0000\n");
    azm_struct.current_pos = 0;
}

void
home_azm () {

    write(azm_struct.fd, "\nha\n", sizeof("\nha\n"));
    azm_struct.current_pos = 0;

}

void
turn_steps_azm (int steps) {

    int n;

    if (steps > 6400 || steps < -6400) {
        return;
    }

    if (steps + azm_struct.current_pos > MAX_STEPS_AZM) {
        return;
    }

    azm_struct.current_pos += steps;

    if (steps < 0) {
        azm_struct.command_buffer[2] = '-';
        steps = -steps;
    } else {
        azm_struct.command_buffer[2] = '+';
    }

    n = itoa(steps, &azm_struct.command_buffer[3]);

    azm_struct.command_buffer[n + 3] = '\n';
    azm_struct.command_buffer[n + 4] = '\0';

    printf("curpos:%d\n", azm_struct.current_pos);
    write(azm_struct.fd, azm_struct.command_buffer, 4 + n);
}

void
turn_deg_azm (double deg) {

    int steps = deg_to_steps(deg);
    turn_steps_azm(steps);

}

double
deg_to_steps (double deg) {
    return (int)((deg * STEPS_PER_REVOLUTION) / 360.0);
}

void
serial_port_config (int fd) {

    struct termios tty;

    tcgetattr(fd, &tty);

    if (errno) {
        fprintf(stderr, "error from tcgetattr: ");
        perror("");
    }

    tty.c_cflag &= ~PARENB; // no parity
    tty.c_cflag &= ~CSTOPB; // one stop bit
    tty.c_cflag &= ~CSIZE;
    tty.c_cflag |= CS8;     // 8 bit data
    tty.c_cflag &= ~CRTSCTS;
    tty.c_cflag |= CREAD | CLOCAL;

    tty.c_lflag &= ~ICANON; // maybe enable
    tty.c_lflag &= ~ECHO; // Disable echo
    tty.c_lflag &= ~ECHOE; // Disable erasure
    tty.c_lflag &= ~ECHONL; // Disable new-line echo
    tty.c_lflag &= ~ISIG;

    tty.c_iflag &= ~(IXON | IXOFF | IXANY);
    tty.c_iflag &= ~(IGNBRK|BRKINT|PARMRK|ISTRIP|INLCR|IGNCR|ICRNL);

    tty.c_oflag &= ~OPOST; // Prevent special interpretation of output bytes (e.g. newline chars)
    tty.c_oflag &= ~ONLCR;

    tty.c_cc[VTIME] = 10;
    tty.c_cc[VMIN]  = 0;

    cfsetispeed(&tty, B9600);
    cfsetospeed(&tty, B9600);

    tcsetattr(fd, TCSANOW, &tty);

    if (errno) {
        fprintf(stderr, "error from tcsetattr: ");
        perror("");
    }
}



int
itoa(int value, char* result) {

    char* ptr  = result;
    char* ptr1 = result;
    char  tmp_char;
    int   tmp_value;
    int   n = 0;

    int base = 10;

    do {
        tmp_value = value;
        value /= base;
        *ptr = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz" [35 + (tmp_value - value * base)];
        ptr++;
        n++;
    } while ( value );

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
    *ptr = '\0';
    ptr--;
    while(ptr1 < ptr) {
        tmp_char = *ptr;
        *ptr = *ptr1;
        ptr--;
        *ptr1++ = tmp_char;
    }
    return n;
}
