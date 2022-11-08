#include <stepper_serial.h>

static struct motor_s azm_struct;
static struct motor_s elv_struct;

//------------------------------------------------------------------------------

static void
log_motor_msg (char* format, ...) {
    va_list args;
    va_start(args, format);
    fprintf(stderr, "MOTOR: ");
    vfprintf(stderr, format, args);
    fprintf(stderr, "\n");
}

static void
init_motor_s (struct motor_s* m,
              int   fd,
              int   home_pos,
              int   max_pos,
              char* command_template,
              char* home_command,
              char* name)
{
    if (fd < 0) {
        log_motor_msg("Bad file descriptor");
        return;
    }

    m->fd          = fd;
    m->current_pos = 0;
    m->home_pos    = home_pos;
    m->max_pos     = max_pos;
    strcpy(m->command_buffer, command_template);
    strcpy(m->home_command,   home_command);
    strcpy(m->name,           name);
}

void
init_azm (int fd) {
    init_motor_s(&azm_struct, fd, AZM_HOME_POS, MAX_STEPS_AZM, "\na+0000\n", "\nha\n", "AZM");
}

void
init_elv (int fd) {
    init_motor_s(&elv_struct, fd, ELV_HOME_POS, MAX_STEPS_ELV, "\ne+0000\n", "\nhe\n", "ELV");
}

void
_init_azm(int fd) {

    if (fd < 0) {
        fprintf(stderr, "elv_struct.fd < 0");
        return;
    }

    azm_struct.fd = fd;
    strcpy(azm_struct.command_buffer, "\na+0000\n");
    azm_struct.current_pos = 0;
}

void
_init_elv(int fd) {

    if (fd < 0) {
        fprintf(stderr, "elv_struct.fd < 0");
        return;
    }

    elv_struct.fd = fd;
    strcpy(elv_struct.command_buffer, "\ne+0000\n");
    elv_struct.current_pos = 0;
}

//------------------------------------------------------------------------------

static void
await_response (struct motor_s m) {
    int n = 0;
    char buffer[512]; // 1024

    do {
        n = read(m.fd, buffer, sizeof(buffer));
        log_motor_msg("%s: Waiting for response", m.name);
        usleep(100); // change to non depr function
    } while (n == 0);

    log_motor_msg("%s: Response received", m.name);

}

void
await_response_azm () {
    await_response (azm_struct);
}

void
await_response_elv () {
    await_response (elv_struct);
}

void
_await_response_azm () {

    int n = 0;
    char buffer[1024];

    do {
        n = read(azm_struct.fd, buffer, sizeof(buffer));
        printf("waiting for azm response\n");
        usleep(100);
    } while (n == 0);

}

void
_await_response_elv () {

    int n = 0;
    char buffer[1024];

    do {
        n = read(elv_struct.fd, buffer, sizeof(buffer));
        printf("waiting for elv response\n");
        usleep(100);
    } while (n == 0);

}

//------------------------------------------------------------------------------

static void
home (struct motor_s* m) {

    int n;

    if (m->fd < 0) {
        log_motor_msg("Bad file descriptor");
        return;
    }

    n = write(m->fd, m->home_command, sizeof(m->home_command));

    if (n != sizeof(m->home_command)) {
        log_motor_msg("%s: Write error on home", m->name);
    }

    m->current_pos = m->home_pos;
}

void
home_azm () {
    home(&azm_struct);
}

void
home_elv () {
    home(&elv_struct);
}

void
_home_azm () {

    if (azm_struct.fd < 0) {
        fprintf(stderr, "azm_struct.fd < 0");
        return;
    }

    write(azm_struct.fd, "\nha\n", sizeof("\nha\n"));
    azm_struct.current_pos = AZM_HOME_POS;
}

void
_home_elv () {

    if (elv_struct.fd < 0) {
        fprintf(stderr, "elv_struct.fd < 0");
        return;
    }

    write(elv_struct.fd, "\nhe\n", sizeof("\nhe\n"));
    elv_struct.current_pos = ELV_HOME_POS;
}

//------------------------------------------------------------------------------

static void
turn_steps (struct motor_s* m, int steps) {

    int n;
    int prev_pos;
    int k;

    if (steps == 0) {
        return;
    }

    if (steps > STEPS_PER_REVOLUTION || steps < -STEPS_PER_REVOLUTION) {
        return;
    }

    if (steps + m->current_pos > m->max_pos) {
        return;
    }

    m->current_pos += steps;

    if (steps < 0) {
        m->command_buffer[2] = '-';
        steps = -steps;
    } else {
        m->command_buffer[2] = '+';
    }

    n = itoa(steps, &m->command_buffer[3]);

    m->command_buffer[n + 3] = '\n';
    m->command_buffer[n + 4] = '\0';

    prev_pos = m->current_pos - steps;

    log_motor_msg("%s:\n\tturning:\t%d steps (%f°)\n\tprev pos:\t%d steps (%f°)\n\tnew pos:\t%d steps (%f°)\n\tdelta:\t%d steps (%f°)\n",
            m->name,
            steps,
            steps_to_deg(steps),
            prev_pos,
            steps_to_deg(prev_pos),
            m->current_pos,
            steps_to_deg(m->current_pos),
            m->current_pos - prev_pos,
            steps_to_deg(m->current_pos - prev_pos)
    );

    log_motor_msg("%s: writing %s\n", m->name, m->command_buffer);

    k = write(m->fd, m->command_buffer, 4 + n);
    // error checking
}

void
turn_steps_azm (int steps) {
    turn_steps (&azm_struct, steps);
}

void
turn_steps_elv (int steps) {
    turn_steps (&elv_struct, steps);
}



//------------------------------------------------------------------------------

static void
turn_deg (struct motor_s* m, double deg) {
    int steps = deg_to_steps(deg);
    turn_steps(m, steps);
}

void
turn_deg_azm (double deg) {
    turn_deg (&azm_struct, deg);
}

void
turn_deg_elv (double deg) {
    turn_deg (&azm_struct, deg);
}

void
_turn_deg_azm (double deg) {
    int steps = deg_to_steps(deg);
    turn_steps_azm(steps);
}

void
_turn_deg_elv (double deg) {

    int steps = deg_to_steps(deg);
    turn_steps_elv(steps);

}

//------------------------------------------------------------------------------

static void
seek_steps (struct motor_s* m, unsigned int target_steps) {

    if (target_steps > m->max_pos) {
        return;
    }

    int steps = target_steps - m->current_pos;
    turn_steps(m, steps);
}

void
seek_steps_azm (unsigned int target_steps) {
    seek_steps(&azm_struct, target_steps);
}

void
seek_steps_elv (unsigned int target_steps) {
    seek_steps(&elv_struct, target_steps);
}

void
_seek_steps_azm (unsigned int target_steps) {

    if (target_steps > MAX_STEPS_AZM) {
        return;
    }

    int steps = target_steps - azm_struct.current_pos;

    turn_steps_azm(steps);

}

void
_seek_steps_elv (unsigned int target_steps) {

    if (target_steps > MAX_STEPS_ELV) {
        return;
    }

    int steps = target_steps - elv_struct.current_pos;

    turn_steps_elv(steps);

}

//------------------------------------------------------------------------------

static void
seek_deg (struct motor_s* m, double deg) {
    int steps = deg_to_steps(deg);
    seek_steps(m, steps);
}

void
seek_deg_azm (double deg) {
    seek_deg(&azm_struct, deg);
}

void
seek_deg_elv (double deg) {
    seek_deg(&elv_struct, deg);
}

void
_seek_deg_azm (double deg) {

    int steps = deg_to_steps(deg);
    seek_steps_azm(steps);

}

void
_seek_deg_elv (double deg) {

    int steps = deg_to_steps(deg);
    seek_steps_elv(steps);

}

//------------------------------------------------------------------------------

// elevation stuff, make more general later w/ struct as argument
//------------------------------------------------------------------------------

void
_turn_steps_elv (int steps) {

    int n;
    int prev_pos;

    if (steps == 0) {
        return;
    }

    if (steps > 6400 || steps < -6400) {
        return;
    }

    if (steps + elv_struct.current_pos > MAX_STEPS_ELV) {
        return;
    }

    prev_pos = elv_struct.current_pos;
    elv_struct.current_pos += steps;

    if (steps < 0) {
        elv_struct.command_buffer[2] = '-';
        steps = -steps;
    } else {
        elv_struct.command_buffer[2] = '+';
    }

    n = itoa(steps, &elv_struct.command_buffer[3]);

    elv_struct.command_buffer[n + 3] = '\n';
    elv_struct.command_buffer[n + 4] = '\0';

    write(elv_struct.fd, elv_struct.command_buffer, 4 + n);

    log_msg("ELV:\n\tturning: %d steps (%f°)\n\tnew pos: %d steps (%f°)\n\tdelta:%d steps (%f°)\n",
            steps,
            steps_to_deg(steps),
            elv_struct.current_pos,
            steps_to_deg(elv_struct.current_pos),
            elv_struct.current_pos - prev_pos,
            steps_to_deg(elv_struct.current_pos - prev_pos)
    );

}

void
_turn_steps_azm (int steps) {

    int n;
    int prev_pos;

    if (steps == 0) {
        return;
    }

    if (steps > 6400 || steps < -6400) {
        return;
    }

    if (steps + azm_struct.current_pos > MAX_STEPS_AZM) {
        return;
    }

    prev_pos = azm_struct.current_pos;
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

    log_msg("AZM:\n\tturning: %d steps (%f°)\n\tnew pos: %d steps (%f°)\n\tdelta:%d steps (%f°)\n",
            steps,
            steps_to_deg(steps),
            azm_struct.current_pos,
            steps_to_deg(azm_struct.current_pos),
            azm_struct.current_pos - prev_pos,
            steps_to_deg(azm_struct.current_pos - prev_pos)
    );

    write(azm_struct.fd, azm_struct.command_buffer, 4 + n);
}

//------------------------------------------------------------------------------


int
deg_to_steps (double deg) {
    return (int)((deg * STEPS_PER_REVOLUTION) / 360.0);
}

double
steps_to_deg (int steps) {
    return DEG_PER_STEP * (double)steps;
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
