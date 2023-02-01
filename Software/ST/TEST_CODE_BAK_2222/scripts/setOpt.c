#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>

// Usage: setOpt 1 0x04 < INPUT_FILE
//

uint8_t format_opt_value (char* value_str);
void write_option_byte (int input_fd, int ouput_fd, uint8_t byte_num, uint8_t value);

int
main(int argc, char *argv[]) {

    uint8_t opt_number;
    uint8_t opt_value;
    char*   value_str;

    if (argc != 5) {
        fprintf(stderr, "usage: %s opt_number hex_value input_file output_file\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    opt_number = atoi(argv[1]);
    value_str  = argv[2];

    opt_value = format_opt_value(value_str);


    int input_fd  = open(argv[3], O_RDONLY, S_IRUSR | S_IWUSR);
    int output_fd = open(argv[4], O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR);

    if (errno) {
        perror ("File open error");
        exit(EXIT_FAILURE);
    }

    write_option_byte(input_fd, output_fd, opt_number, opt_value);

    close(input_fd);
    close(output_fd);

    return EXIT_SUCCESS;
}

void
write_option_byte (int input_fd, int output_fd, uint8_t byte_num, uint8_t value) {

    const int reserved_num = 5; // dont write (negate) after this

    // copy file contents
    char currentChar = 0;
    int i = 0;
    while(read(input_fd, &currentChar, 1)) {

        // very not right but dont got the
        // time to think of smth better :D

        if (i == byte_num) {
            currentChar = value;
        }

        write(output_fd, &currentChar, 1);

        if (i > 0 && i < reserved_num) { // dont change reserved space
            currentChar = ~currentChar;
            write(output_fd, &currentChar, 1);

            i++;
            lseek(input_fd, 1, SEEK_CUR);
        }

        if (errno) {
            perror("copy error");
            exit(EXIT_FAILURE);
        }

        i++;

        printf("i: %d\n", i);
    }

    //lseek(output_fd, byte_num, SEEK_SET);

}

uint8_t
format_opt_value (char* value_str) {

    char* endptr;
    uint8_t conv_value;

    if (value_str[0] == '-') {
        fprintf(stderr, "Error: No negative values allowed\n");
        exit(EXIT_FAILURE);
    }

    conv_value = (uint8_t) strtol(value_str, &endptr, 16);

    if (errno != 0) {
        perror("strtol");
        exit(EXIT_FAILURE);
    }

    if (endptr == value_str) {
        fprintf(stderr, "Error: Wrong value format!\n");
        exit(EXIT_FAILURE);
    }

    return conv_value;
}
