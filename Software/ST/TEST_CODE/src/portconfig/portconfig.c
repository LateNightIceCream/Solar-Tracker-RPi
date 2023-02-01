#include "portconfig.h"

void port_init () {

    PC_DDR |= (BIT3);
    PC_CR1 |= (BIT3);
    PC_CR2 &= ~(BIT3);
    PC_ODR |= BIT3; // HIGH Output reset and sleep

    PB_DDR &= ~BIT2; // has to be set as input bc of a short to ground on the board

    STEPPER_AZM_STP_DDR |= STEPPER_AZM_STP_BIT;
    STEPPER_AZM_STP_CR1 |= STEPPER_AZM_STP_BIT;
    STEPPER_AZM_STP_CR2 &=~STEPPER_AZM_STP_BIT;

    STEPPER_ELV_STP_DDR |= STEPPER_ELV_STP_BIT;
    STEPPER_ELV_STP_CR1 |= STEPPER_ELV_STP_BIT;
    STEPPER_ELV_STP_CR2 &=~STEPPER_ELV_STP_BIT;

    STEPPER_AZM_DIR_DDR |= STEPPER_AZM_DIR_BIT;
    STEPPER_AZM_DIR_CR1 |= STEPPER_AZM_DIR_BIT;
    STEPPER_AZM_DIR_CR2 &=~STEPPER_AZM_DIR_BIT;

    STEPPER_ELV_DIR_DDR |= STEPPER_ELV_DIR_BIT;
    STEPPER_ELV_DIR_CR1 |= STEPPER_ELV_DIR_BIT;
    STEPPER_ELV_DIR_CR2 &=~STEPPER_ELV_DIR_BIT;

    //-------------------------------------------
    // Limit switches, floating with interrupt
    STEPPER_AZM_LIMIT_DDR &=~STEPPER_AZM_LIMIT_BIT;
    STEPPER_AZM_LIMIT_CR1 &=~STEPPER_AZM_LIMIT_BIT;
    STEPPER_AZM_LIMIT_CR2 |= STEPPER_AZM_LIMIT_BIT;

    __asm__("sim");
    EXTI_CR1 |= PCIS_L; // 01 into PCIS bits --> rising edge interrupt
    EXTI_CR1 &=~PCIS_H;
    __asm__("rim");
}
