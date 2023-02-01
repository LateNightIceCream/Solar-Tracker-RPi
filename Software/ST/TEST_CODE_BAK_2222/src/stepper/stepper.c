#include "stepper.h"

// can only do one axis at a time because they share a timer unit
static uint16_t target_steps  = 0;
static uint8_t  stepping_done = 0;
static uint16_t current_pos_azm = ZERO_POSITION_AZM;

//------------------------------------------------------------------------------

void
stepper_init () {
    timer_init();
    home_azm();
}

//------------------------------------------------------------------------------

void home_azm () {
    // cheap way of doing it
    turn_steps_azm(-6400);
}

void _home_elv () {
    turn_steps_elv(-6400);
}

//------------------------------------------------------------------------------

void
turn_steps_azm (int16_t steps) {

    if (steps < 0) {

        if (AZM_LIMIT_PUSHED) {
            return;
        }

        AZM_SET_DIR_HOME;
        steps = -steps;
    }
    else {
        AZM_SET_DIR_SPA;
    }

    ELV_STEP_DISABLE;
    AZM_STEP_ENABLE;

    stepping_done = 0;

    target_steps = steps;
    TIM1_CR1 |= CEN;

    while(!stepping_done)
        __asm__("wfi");

    AZM_STEP_DISABLE;
}

void
turn_steps_elv (int16_t steps) {

    if (steps < 0) {
        ELV_SET_DIR_HOME;
        steps = -steps;
    }
    else {
        ELV_SET_DIR_SPA;
    }

    AZM_STEP_DISABLE;
    ELV_STEP_ENABLE;

    stepping_done = 0;

    target_steps = steps;
    TIM1_CR1 |= CEN;

    while(!stepping_done)
        __asm__("wfi");

    ELV_STEP_DISABLE;
}

//------------------------------------------------------------------------------

static void
timer_init () {
    TIM1_CR1 &= ~CEN; // disable timer
    TIM1_IER &= ~UIE;

    TIM1_PSCRH = 0x00;
    TIM1_PSCRL = 0x5F;

	TIM1_CR1 |= ARPE;
	TIM1_ARRH = 0x00;
	TIM1_ARRL = 0xff;

	TIM1_CCR1H  = 0x00; // CCRx determines duty cycle
	TIM1_CCR1L  = 0x80;

	TIM1_CCR2H  = 0x00; // CCRx determines duty cycle
	TIM1_CCR2L  = 0x80;

    TIM1_CCMR1 &= ~(CC1S_H | CC1S_L); // Output mode
    TIM1_CCMR2 &= ~(CC1S_H | CC1S_L); // Output mode

	TIM1_CCMR1 |= OCM1_PWM2; /* PWM mode 2 */
    TIM1_CCMR2 |= OCM1_PWM2;
	//TIM1_CCER1 |= CC1NE | CC2NE | OC1NP | OC2NP; /* output enable, inv  polarity */
	TIM1_CCER1 |= CC1NE | CC2NE; /* output enable */

    TIM1_BKR  = MOE; // automatic output enable
    TIM1_IER |= UIE;
}

//------------------------------------------------------------------------------

void
timer_isr(void) __interrupt(IRQ_TIM1) {

    if (target_steps == 0) {
        TIM1_CR1 &= ~CEN;
        stepping_done = 1;
    }

    target_steps--;

    TIM1_SR1 &= ~UIF;
}

// for limit switches
void
port_c_isr(void) __interrupt(IRQ_EXTI2) {
    if (AZM_LIMIT_PUSHED) {
        current_pos_azm  = ZERO_POSITION_AZM;
        target_steps = 0;
        stepping_done = 1;
        TIM1_CR1 &= ~CEN;
    }
}
