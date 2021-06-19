#include "common.h"

void
log_msg (char* format, ...) {
    va_list args;
    va_start(args, format);
    fprintf(stderr, "LOG: ");
    vfprintf(stderr, format, args);
}
