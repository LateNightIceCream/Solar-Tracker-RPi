#ifndef __STEPPER_H_
#define __STEPPER_H_

#include "stm8_105.h"
#include "utility.h"
#include "portconfig.h"

//------------------------------------------------------------------------------

#define ZERO_POSITION_AZM 0 // position at north
#define ZERO_POSITION_ELV -61

//------------------------------------------------------------------------------

#define AZM_STEP_ENABLE  TIM1_CCER1 |= CC1NE
#define AZM_STEP_DISABLE TIM1_CCER1 &=~CC1NE

#define ELV_STEP_ENABLE  TIM1_CCER1 |= CC2NE
#define ELV_STEP_DISABLE TIM1_CCER1 &=~CC2NE

//------------------------------------------------------------------------------

#define AZM_SET_DIR_SPA  STEPPER_AZM_DIR_ODR |= STEPPER_AZM_DIR_BIT
#define AZM_SET_DIR_HOME STEPPER_AZM_DIR_ODR &=~STEPPER_AZM_DIR_BIT

#define ELV_SET_DIR_SPA  STEPPER_ELV_DIR_ODR |= STEPPER_ELV_DIR_BIT
#define ELV_SET_DIR_HOME STEPPER_ELV_DIR_ODR &=~STEPPER_ELV_DIR_BIT

//------------------------------------------------------------------------------

#define AZM_LIMIT_PUSHED (STEPPER_AZM_LIMIT_IDR & STEPPER_AZM_LIMIT_BIT)
#define ELV_LIMIT_PUSHED (STEPPER_ELV_LIMIT_IDR & STEPPER_ELV_LIMIT_BIT)

//------------------------------------------------------------------------------
void turn_steps_azm (int16_t steps);
void turn_steps_elv (int16_t steps);

void        home_azm ();
void        home_elv ();
void        stepper_init();
static void timer_init();

#endif // __STEPPER_H_
