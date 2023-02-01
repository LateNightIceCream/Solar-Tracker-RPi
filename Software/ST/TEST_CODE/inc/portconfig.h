/*
 * Port / Pin defintions
 */


#ifndef __PORTCONFIG_H_
#define __PORTCONFIG_H_

#include "utility.h"

//------------------------------------------------------------------------------
// S T E P P E R    M O T O R S
//------------------------------------------------------------------------------
// AZM limit switch, PC4
#define STEPPER_AZM_LIMIT_BIT BIT4
#define STEPPER_AZM_LIMIT_IDR PC_IDR
#define STEPPER_AZM_LIMIT_DDR PC_DDR
#define STEPPER_AZM_LIMIT_CR1 PC_CR1
#define STEPPER_AZM_LIMIT_CR2 PC_CR2

//------------------------------------------------------------------------------
// ELV limit switch PC5
#define STEPPER_ELV_LIMIT_BIT BIT5
#define STEPPER_ELV_LIMIT_IDR PC_IDR
#define STEPPER_ELV_LIMIT_DDR PC_DDR
#define STEPPER_ELV_LIMIT_CR1 PC_CR1
#define STEPPER_ELV_LIMIT_CR2 PC_CR2

//------------------------------------------------------------------------------
// AZM Step Pin
#define STEPPER_AZM_STP_BIT BIT0
#define STEPPER_AZM_STP_CR1 PB_CR1
#define STEPPER_AZM_STP_CR2 PB_CR2
#define STEPPER_AZM_STP_DDR PB_DDR
#define STEPPER_AZM_STP_ODR PB_ODR

//------------------------------------------------------------------------------
// ELV Step Pin
#define STEPPER_ELV_STP_BIT BIT4
#define STEPPER_ELV_STP_CR1 PB_CR1
#define STEPPER_ELV_STP_CR2 PB_CR2
#define STEPPER_ELV_STP_DDR PB_DDR
#define STEPPER_ELV_STP_ODR PB_ODR

//------------------------------------------------------------------------------
// AZM Direction Pin
#define STEPPER_AZM_DIR_BIT BIT1
#define STEPPER_AZM_DIR_CR1 PC_CR1
#define STEPPER_AZM_DIR_CR2 PC_CR2
#define STEPPER_AZM_DIR_DDR PC_DDR
#define STEPPER_AZM_DIR_ODR PC_ODR

//------------------------------------------------------------------------------
// ELV Direction Pin
#define STEPPER_ELV_DIR_BIT BIT2
#define STEPPER_ELV_DIR_CR1 PC_CR1
#define STEPPER_ELV_DIR_CR2 PC_CR2
#define STEPPER_ELV_DIR_DDR PC_DDR
#define STEPPER_ELV_DIR_ODR PC_ODR

void port_init();

#endif // __PORTCONFIG_H_
