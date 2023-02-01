;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module stepper
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _port_c_isr
	.globl _timer_isr
	.globl __home_elv
	.globl _stepper_init
	.globl _home_azm
	.globl _turn_steps_azm
	.globl _turn_steps_elv
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_target_steps:
	.ds 2
_stepping_done:
	.ds 1
_current_pos_azm:
	.ds 2
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/stepper/stepper.c: 11: stepper_init () {
;	-----------------------------------------
;	 function stepper_init
;	-----------------------------------------
_stepper_init:
;	src/stepper/stepper.c: 12: timer_init();
	call	_timer_init
;	src/stepper/stepper.c: 13: home_azm();
;	src/stepper/stepper.c: 14: }
	jp	_home_azm
;	src/stepper/stepper.c: 18: void home_azm () {
;	-----------------------------------------
;	 function home_azm
;	-----------------------------------------
_home_azm:
;	src/stepper/stepper.c: 20: turn_steps_azm(-6400);
	push	#0x00
	push	#0xe7
	call	_turn_steps_azm
	addw	sp, #2
;	src/stepper/stepper.c: 21: }
	ret
;	src/stepper/stepper.c: 23: void _home_elv () {
;	-----------------------------------------
;	 function _home_elv
;	-----------------------------------------
__home_elv:
;	src/stepper/stepper.c: 24: turn_steps_elv(-6400);
	push	#0x00
	push	#0xe7
	call	_turn_steps_elv
	addw	sp, #2
;	src/stepper/stepper.c: 25: }
	ret
;	src/stepper/stepper.c: 30: turn_steps_azm (int16_t steps) {
;	-----------------------------------------
;	 function turn_steps_azm
;	-----------------------------------------
_turn_steps_azm:
;	src/stepper/stepper.c: 32: if (steps < 0) {
	ldw	x, (0x03, sp)
	jrpl	00104$
;	src/stepper/stepper.c: 34: if (AZM_LIMIT_PUSHED) {
	ld	a, 0x500b
	bcp	a, #0x10
	jreq	00102$
;	src/stepper/stepper.c: 35: return;
	ret
00102$:
;	src/stepper/stepper.c: 38: AZM_SET_DIR_HOME;
	bres	20490, #1
;	src/stepper/stepper.c: 39: steps = -steps;
	ldw	x, (0x03, sp)
	negw	x
	ldw	(0x03, sp), x
	jra	00105$
00104$:
;	src/stepper/stepper.c: 42: AZM_SET_DIR_SPA;
	bset	20490, #1
00105$:
;	src/stepper/stepper.c: 45: ELV_STEP_DISABLE;
	bres	21084, #6
;	src/stepper/stepper.c: 46: AZM_STEP_ENABLE;
	bset	21084, #2
;	src/stepper/stepper.c: 48: stepping_done = 0;
	clr	_stepping_done+0
;	src/stepper/stepper.c: 50: target_steps = steps;
	ldw	x, (0x03, sp)
	ldw	_target_steps+0, x
;	src/stepper/stepper.c: 51: TIM1_CR1 |= CEN;
	ld	a, 0x5250
	or	a, #0x01
	ld	0x5250, a
;	src/stepper/stepper.c: 53: while(!stepping_done)
00106$:
	tnz	_stepping_done+0
	jrne	00108$
;	src/stepper/stepper.c: 54: __asm__("wfi");
	wfi
	jra	00106$
00108$:
;	src/stepper/stepper.c: 56: AZM_STEP_DISABLE;
	bres	21084, #2
;	src/stepper/stepper.c: 57: }
	ret
;	src/stepper/stepper.c: 60: turn_steps_elv (int16_t steps) {
;	-----------------------------------------
;	 function turn_steps_elv
;	-----------------------------------------
_turn_steps_elv:
;	src/stepper/stepper.c: 62: if (steps < 0) {
	ldw	x, (0x03, sp)
;	src/stepper/stepper.c: 63: ELV_SET_DIR_HOME;
	ld	a, 0x500a
;	src/stepper/stepper.c: 62: if (steps < 0) {
	tnzw	x
	jrpl	00102$
;	src/stepper/stepper.c: 63: ELV_SET_DIR_HOME;
	and	a, #0xfb
	ld	0x500a, a
;	src/stepper/stepper.c: 64: steps = -steps;
	ldw	x, (0x03, sp)
	negw	x
	ldw	(0x03, sp), x
	jra	00103$
00102$:
;	src/stepper/stepper.c: 67: ELV_SET_DIR_SPA;
	or	a, #0x04
	ld	0x500a, a
00103$:
;	src/stepper/stepper.c: 70: AZM_STEP_DISABLE;
	bres	21084, #2
;	src/stepper/stepper.c: 71: ELV_STEP_ENABLE;
	bset	21084, #6
;	src/stepper/stepper.c: 73: stepping_done = 0;
	clr	_stepping_done+0
;	src/stepper/stepper.c: 75: target_steps = steps;
	ldw	x, (0x03, sp)
	ldw	_target_steps+0, x
;	src/stepper/stepper.c: 76: TIM1_CR1 |= CEN;
	ld	a, 0x5250
	or	a, #0x01
	ld	0x5250, a
;	src/stepper/stepper.c: 78: while(!stepping_done)
00104$:
	tnz	_stepping_done+0
	jrne	00106$
;	src/stepper/stepper.c: 79: __asm__("wfi");
	wfi
	jra	00104$
00106$:
;	src/stepper/stepper.c: 81: ELV_STEP_DISABLE;
	bres	21084, #6
;	src/stepper/stepper.c: 82: }
	ret
;	src/stepper/stepper.c: 87: timer_init () {
;	-----------------------------------------
;	 function timer_init
;	-----------------------------------------
_timer_init:
;	src/stepper/stepper.c: 88: TIM1_CR1 &= ~CEN; // disable timer
	bres	21072, #0
;	src/stepper/stepper.c: 89: TIM1_IER &= ~UIE;
	bres	21076, #0
;	src/stepper/stepper.c: 91: TIM1_PSCRH = 0x00;
	mov	0x5260+0, #0x00
;	src/stepper/stepper.c: 92: TIM1_PSCRL = 0x5F;
	mov	0x5261+0, #0x5f
;	src/stepper/stepper.c: 94: TIM1_CR1 |= ARPE;
	bset	21072, #7
;	src/stepper/stepper.c: 95: TIM1_ARRH = 0x00;
	mov	0x5262+0, #0x00
;	src/stepper/stepper.c: 96: TIM1_ARRL = 0xff;
	mov	0x5263+0, #0xff
;	src/stepper/stepper.c: 98: TIM1_CCR1H  = 0x00; // CCRx determines duty cycle
	mov	0x5265+0, #0x00
;	src/stepper/stepper.c: 99: TIM1_CCR1L  = 0x80;
	mov	0x5266+0, #0x80
;	src/stepper/stepper.c: 101: TIM1_CCR2H  = 0x00; // CCRx determines duty cycle
	mov	0x5267+0, #0x00
;	src/stepper/stepper.c: 102: TIM1_CCR2L  = 0x80;
	mov	0x5268+0, #0x80
;	src/stepper/stepper.c: 104: TIM1_CCMR1 &= ~(CC1S_H | CC1S_L); // Output mode
	ld	a, 0x5258
	and	a, #0xfc
	ld	0x5258, a
;	src/stepper/stepper.c: 105: TIM1_CCMR2 &= ~(CC1S_H | CC1S_L); // Output mode
	ld	a, 0x5259
	and	a, #0xfc
	ld	0x5259, a
;	src/stepper/stepper.c: 107: TIM1_CCMR1 |= OCM1_PWM2; /* PWM mode 2 */
	ld	a, 0x5258
	or	a, #0x70
	ld	0x5258, a
;	src/stepper/stepper.c: 108: TIM1_CCMR2 |= OCM1_PWM2;
	ld	a, 0x5259
	or	a, #0x70
	ld	0x5259, a
;	src/stepper/stepper.c: 110: TIM1_CCER1 |= CC1NE | CC2NE; /* output enable */
	ld	a, 0x525c
	or	a, #0x44
	ld	0x525c, a
;	src/stepper/stepper.c: 112: TIM1_BKR  = MOE; // automatic output enable
	mov	0x526d+0, #0x80
;	src/stepper/stepper.c: 113: TIM1_IER |= UIE;
	bset	21076, #0
;	src/stepper/stepper.c: 114: }
	ret
;	src/stepper/stepper.c: 119: timer_isr(void) __interrupt(IRQ_TIM1) {
;	-----------------------------------------
;	 function timer_isr
;	-----------------------------------------
_timer_isr:
;	src/stepper/stepper.c: 121: if (target_steps == 0) {
	ldw	x, _target_steps+0
	jrne	00102$
;	src/stepper/stepper.c: 122: TIM1_CR1 &= ~CEN;
	bres	21072, #0
;	src/stepper/stepper.c: 123: stepping_done = 1;
	mov	_stepping_done+0, #0x01
00102$:
;	src/stepper/stepper.c: 126: target_steps--;
	ldw	x, _target_steps+0
	decw	x
	ldw	_target_steps+0, x
;	src/stepper/stepper.c: 128: TIM1_SR1 &= ~UIF;
	bres	21077, #0
;	src/stepper/stepper.c: 129: }
	iret
;	src/stepper/stepper.c: 133: port_c_isr(void) __interrupt(IRQ_EXTI2) {
;	-----------------------------------------
;	 function port_c_isr
;	-----------------------------------------
_port_c_isr:
;	src/stepper/stepper.c: 134: if (AZM_LIMIT_PUSHED) {
	ld	a, 0x500b
	bcp	a, #0x10
	jreq	00103$
;	src/stepper/stepper.c: 135: current_pos_azm  = ZERO_POSITION_AZM;
	clrw	x
	ldw	_current_pos_azm+0, x
;	src/stepper/stepper.c: 136: target_steps = 0;
	clrw	x
	ldw	_target_steps+0, x
;	src/stepper/stepper.c: 137: stepping_done = 1;
	mov	_stepping_done+0, #0x01
;	src/stepper/stepper.c: 138: TIM1_CR1 &= ~CEN;
	bres	21072, #0
00103$:
;	src/stepper/stepper.c: 140: }
	iret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__target_steps:
	.dw #0x0000
__xinit__stepping_done:
	.db #0x00	; 0
__xinit__current_pos_azm:
	.dw #0x0000
	.area CABS (ABS)
