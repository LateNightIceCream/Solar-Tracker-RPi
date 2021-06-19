#include <stdio.h>
#include <string.h>

#include <fcntl.h>
#include <errno.h>
#include <termios.h>
#include <unistd.h>
#include <stdlib.h>

#include <string.h>
#include <termios.h>


unsigned long
hash(unsigned char *str)
{
    unsigned long hash = 5381;
    int c;

    while ((c = *str++))
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */

    return hash;
}

int main(int argc, char *argv[]) {

    if (argc < 2) {
        printf("usage: %s string\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    printf("your hash is: %lu\n", hash(argv[1]));



    return EXIT_SUCCESS;
}
