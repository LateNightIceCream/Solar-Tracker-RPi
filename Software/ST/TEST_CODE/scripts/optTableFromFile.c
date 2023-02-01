/*
 *
 */
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

#define BYTE_TO_BINARY_PATTERN "%-4c%-4c%-4c%-4c%-4c%-4c%-4c%-4c"
#define BYTE_TO_BINARY(byte)  \
  (byte & 0x80 ? '1' : '0'), \
  (byte & 0x40 ? '1' : '0'), \
  (byte & 0x20 ? '1' : '0'), \
  (byte & 0x10 ? '1' : '0'), \
  (byte & 0x08 ? '1' : '0'), \
  (byte & 0x04 ? '1' : '0'), \
  (byte & 0x02 ? '1' : '0'), \
  (byte & 0x01 ? '1' : '0')

char* descriptions[] = {
"Read Out Protection (ROP)",
"User boot code (UBC)"
};

struct option {
    char* name;
    uint16_t address;
    int n_bytes;
    char* opt_num;
};

struct option rop = {
    .name = "Read-out Protection (ROP)",
    .address = 0x4800,
    .n_bytes = 1,
    .opt_num = "OPT1"
};

struct option ubc = {
    .name = "User boot code (UBC)",
    .address = 0x4801,
    .n_bytes = 2
};

struct option afr = {
    .name = "Alternate Function Remapping (AFR)",
    .address = 0x4803,
    .n_bytes = 2
};

struct option mopt = {
    .name = "Misc. option",
    .address = 0x4805,
    .n_bytes = 2
};

struct option copt = {
    .name = "Clock Option",
    .address = 0x4807,
    .n_bytes = 2
};

struct option hseCSU = {
    .name = "HSE clock startup",
    .address = 0x4809,
    .n_bytes = 2
};

struct option reserved1 = {
    .name = "Reserved",
    .address = 0x480B,
    .n_bytes = 2
};

struct option reserved2 = {
    .name = "Reserved",
    .address = 0x480D,
    .n_bytes = 2
};

struct option reserved3 = {
    .name = "Reserved",
    .address = 0x480F,
    .n_bytes = 238
};

struct option bootloader = {
    .name = "Bootloader",
    .address = 0x480E,
    .n_bytes = 2
};

void print_option(struct option);
void print_big_sep ();
void print_lil_sep ();

int
main(int argc, char *argv[]) {

    unsigned char current_char = 0;

    struct option options[] = {
        rop,
        ubc,
        afr,
        mopt,
        copt,
        hseCSU,
        reserved1,
        reserved2,
        reserved3,
        bootloader
    };
    int n_opts = 10;

    if (argc != 1) {
        fprintf(stderr, "usage: %s < input_file\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    printf("\n");
    printf("%-30s%-30s\t%-4s%-4s%-4s%-4s%-4s%-4s%-4s%-4s\n", "Option", "Address", "b7", "b6", "b5", "b4", "b3", "b2", "b1", "b0");
    print_big_sep();

    int n = 0;
    for (int i = 0; i < n_opts - 2; i++) {


        if (errno != 0) {
            perror("file read error");
        }

        for (int k = 0; k < options[i].n_bytes; k++) {

            read(STDIN_FILENO, &current_char, 1);

            printf("%d:%-30s\t%#04x\t", k, options[i].name, options[i].address + k);
            printf(BYTE_TO_BINARY_PATTERN"%#x\n", BYTE_TO_BINARY(current_char), current_char);

            if (k < options[i].n_bytes-1) {
                print_lil_sep();
            }
        }

        print_big_sep();

        n++;
    }

    return EXIT_SUCCESS;
}

void print_big_sep () {
    printf("=============================================================================\n");
}

void print_lil_sep () {
    //printf("-----------------------------------------------------------------------------\n");
    printf("\n");
}
