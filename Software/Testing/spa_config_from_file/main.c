#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <stdlib.h>

#include <string.h>
#include <termios.h>

#define FILENAME "_config.conf"

#define H_LAT       8246580368017208678UL
#define H_LONG      8246599893721431989UL
#define H_PORT      210724489898UL
#define H_ATM_REFR  249881707569074261UL
#define H_PRESSURE  8246789394168586238UL
#define H_ELEVATION 8246270432556926252UL
#define H_DELTA_T   8246214471933763874UL
#define H_DELTA_UT1 8246214471933891848UL
#define H_TIMEZONE  8246962705562310608UL
#define H_TEMP      8246957090515233947UL
#define H_SLOPE     8246920611828387752UL

#define PORT_STRING_SIZE 64

struct config {
    double latitude;
    double longitude;
    char   serial_port[PORT_STRING_SIZE];
    double timezone;
    double delta_t;
    double delta_ut1;
    double elevation;
    double pressure;
    double temperature;
    double slope;
    double azm_rotation;
    double atm_refr;
};

unsigned long
hash(unsigned char *str)
{
    unsigned long hash = 5381;
    int c;

    while ((c = *str++))
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */

    return hash;
}

int
read_parse_config(const char* filename, struct config* conf);

void
_print_config(struct config* conf);

int
main(int argc, char *argv[]) {

    struct config conf;
    read_parse_config(FILENAME, &conf);

    _print_config(&conf);

    return EXIT_SUCCESS;
}

void
default_config_init (struct config* config) {
    config->latitude    = 0;
    config->longitude   = 0;
    strcpy(config->serial_port, "/dev/ttyUSB0");
}

void
_print_config (struct config* config) {

    printf("latitude: %f\n",     config->latitude);
    printf("longitude: %f\n",    config->longitude);
    printf("serial_port: %s\n",  config->serial_port);
    printf("timezone: %f\n",     config->timezone);
    printf("delta_t: %f\n",      config->delta_t);
    printf("delta_ut1: %f\n",    config->delta_ut1);
    printf("elevation: %f\n",    config->elevation);
    printf("pressure: %f\n",     config->pressure);
    printf("temperature: %f\n",  config->temperature);
    printf("slope: %f\n",        config->slope);
    printf("azm_rotation: %f\n", config->azm_rotation);
    printf("azm_refr: %f\n",     config->atm_refr);

}

void
_print_config_error (unsigned int line, char* format, ...) {
    va_list args;
    va_start(args, format);

    fprintf(stderr, "Error in config file line %u\n\t", line);
    vfprintf(stderr, format, args);
}

void remove_spaces (char* restrict str_trimmed, const char* restrict str_untrimmed)
{
  while (*str_untrimmed != '\0')
  {
    if(!isspace(*str_untrimmed))
    {
      *str_trimmed = *str_untrimmed;
      str_trimmed++;
    }
    str_untrimmed++;
  }
  *str_trimmed = '\0';
}


int
_assign_double_from_str (double* target, char* source_str) {

    char*  endptr;
    double d_value;

    d_value = strtod(source_str, &endptr);

    if (*endptr == '\0' || *endptr == '\n') {
        *target = d_value;
        return 0;
    } else {
        return 1;
    }
}

int
_path_from_string (char* str) {

    return 0;
}

int
read_parse_config(const char* filename, struct config* conf) {

    FILE*   fp;
    char *  line = NULL;
    size_t  len  = 0;
    ssize_t read;
    unsigned int linecount = 0;

    default_config_init(conf);

    fp = fopen(filename, "r");

    if (fp == NULL) {
        perror("file open error:");
        return 1;
    }

    while ((read = getline(&line, &len, fp)) != -1) {

        linecount++;

        if (line[0] == '#' || line[0] == ' ' || line[0] == '\n') {
            continue;
        }

        char* token = strtok(line, "=");
        char* value = strtok(NULL, "=");

        /* printf("token: %s\n", token); */
        /* printf("value: %s\n", value); */
        /* printf("hash: %lu\n", hash(token)); */

        int err = 0;

        switch(hash(token)) {
            case H_LAT:
                err = _assign_double_from_str(&(conf->latitude), value);
                break;

            case H_LONG:
                err = _assign_double_from_str(&(conf->longitude), value);
                break;

            case H_ATM_REFR:
                err = _assign_double_from_str(&(conf->atm_refr), value);
                break;

            case H_PRESSURE:
                err = _assign_double_from_str(&(conf->pressure), value);
                break;

            case H_ELEVATION:
                err = _assign_double_from_str(&(conf->pressure), value);
                break;

            case H_DELTA_T:
                err = _assign_double_from_str(&(conf->delta_t), value);
                break;

            case H_DELTA_UT1:
                err = _assign_double_from_str(&(conf->delta_ut1), value);
                break;

            case H_TIMEZONE:
                err = _assign_double_from_str(&(conf->timezone), value);
                break;

            case H_TEMP:
                err = _assign_double_from_str(&(conf->temperature), value);
                break;

            case H_SLOPE:
                err = _assign_double_from_str(&(conf->slope), value);
                break;

            case H_PORT:
                if (strnlen(value, PORT_STRING_SIZE - 1) == PORT_STRING_SIZE-1) {
                    err = 1;
                    break;
                }
                value[strcspn(value, "\n")] = '\0';
                strcpy(conf->serial_port, value);
                break;
        }

        if (err) {
            _print_config_error(linecount, "%s=%s\n", token, value);
        }

    }

    fclose(fp);
    if (line)
        free(line);

    return 0;
}
