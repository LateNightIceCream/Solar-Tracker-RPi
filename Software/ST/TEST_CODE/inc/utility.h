/*
 * utility.h
 *
 * Description: Just some definitions to make life easier, clean up later ;)
 * Author: Richard Grünert, 2021
 */

#ifndef UTILITY_H
#define UTILITY_H

#include <stdint.h>
#include "stm8s_header.h"
#include "stm8_105.h"

#define BIT0 (uint8_t) 0b00000001
#define BIT1 (uint8_t) 0b00000010
#define BIT2 (uint8_t) 0b00000100
#define BIT3 (uint8_t) 0b00001000
#define BIT4 (uint8_t) 0b00010000
#define BIT5 (uint8_t) 0b00100000
#define BIT6 (uint8_t) 0b01000000
#define BIT7 (uint8_t) 0b10000000

// just wanna go msp430 style
// kind of a mess, clean up later
#define ARPE   BIT7
#define CEN    BIT0
#define UIE    BIT0
#define OCM1_PWM1 (BIT6 | BIT5)
#define OCM1_PWM2 (BIT6 | BIT5 | BIT4)
#define CC1E   BIT0
#define CC1P   BIT1
#define CC1NE  BIT2
#define CC2NE  BIT6
#define CC1S_H BIT1
#define CC1S_L BIT0
#define AOE    BIT6
#define MOE    BIT7
#define UG     BIT0
#define LOCK_H BIT1
#define LOCK_L BIT0
#define OC1PE  BIT3
#define OC1NP  BIT3
#define OC2NP  BIT7
#define OC2NP  BIT7
#define UIF    BIT0
#define TEN    BIT3
#define REN    BIT2
#define STOP_H BIT5
#define STOP_L BIT4
#define TXE    BIT7
#define TIEN   BIT7
#define RIEN   BIT5
#define PCIS_H BIT5
#define PCIS_L BIT4

void clk_out_enable();
void opt_write();
void hsi_configure();

#endif
