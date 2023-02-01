/*
 * Reading UART commands into a ring buffer
 *
 * also sending UART data
 */
#include "uart_commands.h"
#include "utility.h"

static char* command_buffer[COMMAND_BUFFER_SIZE];
// current command
static char  uart_rx_buf[UART_RX_BUFFER_SIZE];

// keeps track of current position in command_buffer for writing (isr)
static uint8_t command_number = 0;

static int   uart_tx_done = 0;
static char* uart_tx_buf;

//------------------------------------------------------------------------------

void
init_command_buffer () {
    for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
        command_buffer[i] = malloc(MAX_COMMAND_LENGTH*sizeof(char));
        char* command = command_buffer[i];
        for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
            command[n] = 0;
        }
    }
}

//------------------------------------------------------------------------------

int16_t
get_steps_from_command (const char* cmd) {

    char*   endptr;
    int16_t steps;

    if (cmd[1] == '\0') {
        return 0;
    }

    steps = strtol(cmd + 1, &endptr, 10);

    if (endptr == cmd || !(*endptr == '\0' || *endptr == '\n')) {
        return 0;
    }

    return steps;
}

//------------------------------------------------------------------------------

int
uart2_write(char *str) {

    uart_tx_buf = str;
    UART2_DR    = uart_tx_buf[0];
    UART2_CR2  |= TIEN;

    /* //while(!(UART2_SR & TXE)); // blocking forever ?*/

    while(!uart_tx_done)
        __asm__("wfi");

    UART2_CR2 &= ~TIEN;

    uart_tx_done = 0;

    return 0;
}

//------------------------------------------------------------------------------

void
uart2_init () {
    // Setup UART1 (TX=D5) (RX=D6)
    UART2_CR2 |= TEN; // Transmitter enable
    UART2_CR2 |= REN; // Receiver enable

    UART2_CR3 &= ~(STOP_H | STOP_L); // 1 stop bit
    UART2_CR1  = 0;

    // 9600 baud: UART_DIV = 16000000/9600 ~ 1667 = 0x0683
    UART2_BRR2 = 0x03;
    UART2_BRR1 = 0x68;

    UART2_CR2 |= RIEN;

    init_command_buffer();
}

//------------------------------------------------------------------------------

// commands have to be terminated by \n
char*
read_next_command () {

    static uint8_t read_index = 0; // reading position in command_buffer
    char* command;

    while(command_number == read_index)
        __asm__("wfi");

    // something is waiting to be picked up
    command = command_buffer[read_index];

    read_index++;

    if (read_index > (COMMAND_BUFFER_SIZE - 1)) {
        read_index = 0;
    }

    return command;
}

//------------------------------------------------------------------------------

void
uart2_tx_isr(void) __interrupt(IRQ_UART2_TX) {

    static uint8_t i = 1;

    UART2_DR = uart_tx_buf[i];

    if (uart_tx_buf[i] == '\0') {
        uart_tx_done = 1;
        i = 1;
        return;
    }

    i++;
}

//------------------------------------------------------------------------------

void
uart2_rx_isr(void) __interrupt(IRQ_UART2_RX) {

    // keeping track of the current byte in the commandd string
    static uint8_t byte_index = 0;

    char* command;
    command = command_buffer[command_number];

    //uart_rx_buf[i] = UART2_DR;

    command[byte_index] = UART2_DR;

    if (command[byte_index] == '\n') {

        byte_index = 0;

        command_number++;

        if (command_number > (COMMAND_BUFFER_SIZE - 1)) {
            command_number = 0;
        }

        return;
    }

    byte_index++;

    if (byte_index > (MAX_COMMAND_LENGTH - 1))
        byte_index = 0;
}
