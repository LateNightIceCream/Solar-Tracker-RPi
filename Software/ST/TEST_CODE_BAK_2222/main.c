/*
*
* Solar tracking motor control via UART
*
* */

#include <stdint.h>
#include <stdlib.h>
#include "stm8s_header.h"
#include "stm8_105.h" // change compile option -DMSTM8105 then can be removed
#include "utility.h"
#include "portconfig.h"
#include "stepper.h"
#include "uart_commands.h"

//------------------------------------------------------------------------------

void main() {
    __asm__("rim");
    //opt_write(); // AFR5

    hsi_configure(); // hse currently doesnt work
    port_init();
    stepper_init();
    uart2_init();

    char* command;
    while (1) {

        command = read_next_command();

        int16_t steps;
        steps = 0;

        switch (command[0]) {

            case 'a': // azimuth

                steps = get_steps_from_command(command);

                if (steps == 0)
                    break;

                turn_steps_azm(steps);

                break;

            case 'e': // elevation

                steps = get_steps_from_command(command);

                if (steps == 0)
                    break;

                turn_steps_elv(steps);

                break;

            case 'p': // ping
                uart2_write("e\n");
                break;

            case 'h':
                if (command[1] == '\n' || command[1] == '\0') {
                    break;
                }

                if (command[1] == 'a') {
                    home_azm();
                }
                else if ( command[1] == 'e'){

                }

                break;

            default:
                break;
        }
        uart2_write(command);
    }
}

/* void port_init () { */

/*     PC_DDR |= (BIT3); */
/*     PC_CR1 |= (BIT3); */
/*     PC_CR2 &= ~(BIT3); */
/*     PC_ODR |= BIT3; // HIGH Output reset and sleep */

/*     PB_DDR &= ~BIT2; // has to be set as input bc of a short to ground on the board */

/*     STEPPER_AZM_STP_DDR |= STEPPER_AZM_STP_BIT; */
/*     STEPPER_AZM_STP_CR1 |= STEPPER_AZM_STP_BIT; */
/*     STEPPER_AZM_STP_CR2 &=~STEPPER_AZM_STP_BIT; */

/*     STEPPER_ELV_STP_DDR |= STEPPER_ELV_STP_BIT; */
/*     STEPPER_ELV_STP_CR1 |= STEPPER_ELV_STP_BIT; */
/*     STEPPER_ELV_STP_CR2 &=~STEPPER_ELV_STP_BIT; */

/*     STEPPER_AZM_DIR_DDR |= STEPPER_AZM_DIR_BIT; */
/*     STEPPER_AZM_DIR_CR1 |= STEPPER_AZM_DIR_BIT; */
/*     STEPPER_AZM_DIR_CR2 &=~STEPPER_AZM_DIR_BIT; */

/*     STEPPER_ELV_DIR_DDR |= STEPPER_ELV_DIR_BIT; */
/*     STEPPER_ELV_DIR_CR1 |= STEPPER_ELV_DIR_BIT; */
/*     STEPPER_ELV_DIR_CR2 &=~STEPPER_ELV_DIR_BIT; */

/*     //------------------------------------------- */
/*     // Limit switches, floating with interrupt */
/*     STEPPER_AZM_LIMIT_DDR &=~STEPPER_AZM_LIMIT_BIT; */
/*     STEPPER_AZM_LIMIT_CR1 &=~STEPPER_AZM_LIMIT_BIT; */
/*     STEPPER_AZM_LIMIT_CR2 |= STEPPER_AZM_LIMIT_BIT; */

/*     __asm__("sim"); */
/*     EXTI_CR1 |= PCIS_L; // 01 into PCIS bits --> rising edge interrupt */
/*     EXTI_CR1 &=~PCIS_H; */
/*     __asm__("rim"); */
/* } */

/* // can only do one axis at a time because they share a timer unit */
/* static uint16_t target_steps  = 0; */
/* static uint8_t  stepping_done = 0; */
/* static uint16_t current_pos_azm = ZERO_POSITION_AZM; */

/* //------------------------------------------------------------------------------ */

/* void */
/* stepper_init () { */
/*     timer_init(); */
/*     home_azm(); */
/* } */

/* //------------------------------------------------------------------------------ */

/* void home_azm () { */
/*     // cheap way of doing it */
/*     turn_steps_azm(-6400); */
/* } */

/* void _home_elv () { */
/*     turn_steps_elv(-6400); */
/* } */

/* //------------------------------------------------------------------------------ */

/* void */
/* turn_steps_azm (int16_t steps) { */

/*     if (steps < 0) { */

/*         if (AZM_LIMIT_PUSHED) { */
/*             return; */
/*         } */

/*         AZM_SET_DIR_HOME; */
/*         steps = -steps; */
/*     } */
/*     else { */
/*         AZM_SET_DIR_SPA; */
/*     } */

/*     ELV_STEP_DISABLE; */
/*     AZM_STEP_ENABLE; */

/*     stepping_done = 0; */

/*     target_steps = steps; */
/*     TIM1_CR1 |= CEN; */

/*     while(!stepping_done) */
/*         __asm__("wfi"); */

/*     AZM_STEP_DISABLE; */
/* } */

/* void */
/* turn_steps_elv (int16_t steps) { */

/*     if (steps < 0) { */
/*         ELV_SET_DIR_HOME; */
/*         steps = -steps; */
/*     } */
/*     else { */
/*         ELV_SET_DIR_SPA; */
/*     } */

/*     AZM_STEP_DISABLE; */
/*     ELV_STEP_ENABLE; */

/*     stepping_done = 0; */

/*     target_steps = steps; */
/*     TIM1_CR1 |= CEN; */

/*     while(!stepping_done) */
/*         __asm__("wfi"); */

/*     ELV_STEP_DISABLE; */
/* } */

/* //------------------------------------------------------------------------------ */

/* static void */
/* timer_init () { */
/*     TIM1_CR1 &= ~CEN; // disable timer */
/*     TIM1_IER &= ~UIE; */

/*     TIM1_PSCRH = 0x00; */
/*     TIM1_PSCRL = 0x5F; */

/* 	TIM1_CR1 |= ARPE; */
/* 	TIM1_ARRH = 0x00; */
/* 	TIM1_ARRL = 0xff; */

/* 	TIM1_CCR1H  = 0x00; // CCRx determines duty cycle */
/* 	TIM1_CCR1L  = 0x80; */

/* 	TIM1_CCR2H  = 0x00; // CCRx determines duty cycle */
/* 	TIM1_CCR2L  = 0x80; */

/*     TIM1_CCMR1 &= ~(CC1S_H | CC1S_L); // Output mode */
/*     TIM1_CCMR2 &= ~(CC1S_H | CC1S_L); // Output mode */

/* 	TIM1_CCMR1 |= OCM1_PWM2; /\* PWM mode 2 *\/ */
/*     TIM1_CCMR2 |= OCM1_PWM2; */
/* 	//TIM1_CCER1 |= CC1NE | CC2NE | OC1NP | OC2NP; /\* output enable, inv  polarity *\/ */
/* 	TIM1_CCER1 |= CC1NE | CC2NE; /\* output enable *\/ */

/*     TIM1_BKR  = MOE; // automatic output enable */
/*     TIM1_IER |= UIE; */
/* } */

/* //------------------------------------------------------------------------------ */

/* void */
/* timer_isr(void) __interrupt(IRQ_TIM1) { */

/*     if (target_steps == 0) { */
/*         TIM1_CR1 &= ~CEN; */
/*         stepping_done = 1; */
/*     } */

/*     target_steps--; */

/*     TIM1_SR1 &= ~UIF; */
/* } */

/* // for limit switches */
/* void */
/* port_c_isr(void) __interrupt(IRQ_EXTI2) { */
/*     if (AZM_LIMIT_PUSHED) { */
/*         current_pos_azm  = ZERO_POSITION_AZM; */
/*         target_steps = 0; */
/*         stepping_done = 1; */
/*         TIM1_CR1 &= ~CEN; */
/*     } */
/* } */


/* static char* command_buffer[COMMAND_BUFFER_SIZE]; */
/* // current command */
/* static char  uart_rx_buf[UART_RX_BUFFER_SIZE]; */

/* // keeps track of current position in command_buffer for writing (isr) */
/* static uint8_t command_number = 0; */

/* static int   uart_tx_done = 0; */
/* static char* uart_tx_buf; */

/* //------------------------------------------------------------------------------ */

/* void */
/* init_command_buffer () { */
/*     for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){ */
/*         command_buffer[i] = malloc(MAX_COMMAND_LENGTH*sizeof(char)); */
/*         char* command = command_buffer[i]; */
/*         for (int n = 0; n < MAX_COMMAND_LENGTH; n++) { */
/*             command[n] = 0; */
/*         } */
/*     } */
/* } */

/* //------------------------------------------------------------------------------ */

/* int16_t */
/* get_steps_from_command (const char* cmd) { */

/*     char*   endptr; */
/*     int16_t steps; */

/*     if (cmd[1] == '\0') { */
/*         return 0; */
/*     } */

/*     steps = strtol(cmd + 1, &endptr, 10); */

/*     if (endptr == cmd || !(*endptr == '\0' || *endptr == '\n')) { */
/*         return 0; */
/*     } */

/*     return steps; */
/* } */

/* //------------------------------------------------------------------------------ */

/* int */
/* uart2_write(char *str) { */

/*     uart_tx_buf = str; */
/*     UART2_DR    = uart_tx_buf[0]; */
/*     UART2_CR2  |= TIEN; */

/*     /\* //while(!(UART2_SR & TXE)); // blocking forever ?*\/ */

/*     while(!uart_tx_done) */
/*         __asm__("wfi"); */

/*     UART2_CR2 &= ~TIEN; */

/*     uart_tx_done = 0; */

/*     return 0; */
/* } */

/* //------------------------------------------------------------------------------ */

/* void */
/* uart2_init () { */
/*     // Setup UART1 (TX=D5) (RX=D6) */
/*     UART2_CR2 |= TEN; // Transmitter enable */
/*     UART2_CR2 |= REN; // Receiver enable */

/*     UART2_CR3 &= ~(STOP_H | STOP_L); // 1 stop bit */
/*     UART2_CR1  = 0; */

/*     // 9600 baud: UART_DIV = 16000000/9600 ~ 1667 = 0x0683 */
/*     UART2_BRR2 = 0x03; */
/*     UART2_BRR1 = 0x68; */

/*     UART2_CR2 |= RIEN; */

/*     init_command_buffer(); */
/* } */

/* //------------------------------------------------------------------------------ */

/* // commands have to be terminated by \n */
/* char* */
/* read_next_command () { */

/*     static uint8_t read_index = 0; // reading position in command_buffer */
/*     char* command; */

/*     while(command_number == read_index) */
/*         __asm__("wfi"); */

/*     // something is waiting to be picked up */
/*     command = command_buffer[read_index]; */

/*     read_index++; */

/*     if (read_index > (COMMAND_BUFFER_SIZE - 1)) { */
/*         read_index = 0; */
/*     } */

/*     return command; */
/* } */

/* //------------------------------------------------------------------------------ */

/* void */
/* uart2_tx_isr(void) __interrupt(IRQ_UART2_TX) { */

/*     static uint8_t i = 1; */

/*     UART2_DR = uart_tx_buf[i]; */

/*     if (uart_tx_buf[i] == '\0') { */
/*         uart_tx_done = 1; */
/*         i = 1; */
/*         return; */
/*     } */

/*     i++; */
/* } */

/* //------------------------------------------------------------------------------ */

/* void */
/* uart2_rx_isr(void) __interrupt(IRQ_UART2_RX) { */

/*     // keeping track of the current byte in the commandd string */
/*     static uint8_t byte_index = 0; */

/*     char* command; */
/*     command = command_buffer[command_number]; */

/*     //uart_rx_buf[i] = UART2_DR; */

/*     command[byte_index] = UART2_DR; */

/*     if (command[byte_index] == '\n') { */

/*         byte_index = 0; */

/*         command_number++; */

/*         if (command_number > (COMMAND_BUFFER_SIZE - 1)) { */
/*             command_number = 0; */
/*         } */

/*         return; */
/*     } */

/*     byte_index++; */

/*     if (byte_index > (MAX_COMMAND_LENGTH - 1)) */
/*         byte_index = 0; */
/* } */


/* void hsi_configure () { */
/*     while ((CLK_ICKR & BIT1) == 0); // HSRDY */

/*     while((CLK_SWCR & BIT0)); */
/*     CLK_SWR    = 0xE1; // select HSI for Master CLK */
/*     CLK_CKDIVR = 0; */

/*     while((CLK_SWCR & BIT0)); */
/*     CLK_SWCR |= BIT1; */
/*     while((CLK_SWCR & BIT0)); */
/*     CLK_SWCR &= ~BIT1; */
/* } */

/* void clk_out_enable() { */
/*     /\* Configure PD0 as output *\/ */
/*     PD_DDR |= BIT0; */
/*     /\* Push-pull mode, 10MHz output speed *\/ */
/*     PD_CR1 |= BIT0; */
/*     PD_CR2 |= BIT0; */
/*     /\* Clock output on PD0 *\/ */
/*     CLK_CCOR |= (BIT0 | (0b1011 << 1)); */
/* } */

/* // a mess */
/* void opt_write() { */
/*     /\* new value for OPT5 (default is 0x00) *\/ */
/*     uint8_t opt0 = BIT2 | BIT5; */
/*     /\* unlock EEPROM *\/ */

/*     #define FLASH_DUKR_KEY1 0xAE */
/*     #define FLASH_DUKR_KEY2 0x56 */

/*     FLASH_DUKR = FLASH_DUKR_KEY1; */
/*     FLASH_DUKR = FLASH_DUKR_KEY2; */
/*     while (!(FLASH_IAPSR & BIT3)); */
/*     /\* unlock option bytes *\/ */
/*     FLASH_CR2 |= BIT7; */
/*     FLASH_NCR2 &= ~BIT7; */
/*     /\* write option byte and it's complement *\/ */
/*     //\*((uint8_t*) 0x4800) = opt0; */
/*     *((uint8_t*) 0x4803) = opt0; */
/*     *((uint8_t*) 0x4804) = ~opt0; */
/*     //NOPT5 = ~opt5; */
/*     /\* wait until programming is finished *\/ */
/*     while (!(FLASH_IAPSR & BIT2)); */
/*     /\* lock EEPROM *\/ */
/*     FLASH_IAPSR &= ~BIT3; */
/* } */
