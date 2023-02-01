;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module portconfig
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _port_init
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
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
;	src/portconfig/portconfig.c: 3: void port_init () {
;	-----------------------------------------
;	 function port_init
;	-----------------------------------------
_port_init:
;	src/portconfig/portconfig.c: 5: PC_DDR |= (BIT3);
	bset	20492, #3
;	src/portconfig/portconfig.c: 6: PC_CR1 |= (BIT3);
	bset	20493, #3
;	src/portconfig/portconfig.c: 7: PC_CR2 &= ~(BIT3);
	bres	20494, #3
;	src/portconfig/portconfig.c: 8: PC_ODR |= BIT3; // HIGH Output reset and sleep
	bset	20490, #3
;	src/portconfig/portconfig.c: 10: PB_DDR &= ~BIT2; // has to be set as input bc of a short to ground on the board
	bres	20487, #2
;	src/portconfig/portconfig.c: 12: STEPPER_AZM_STP_DDR |= STEPPER_AZM_STP_BIT;
	bset	20487, #0
;	src/portconfig/portconfig.c: 13: STEPPER_AZM_STP_CR1 |= STEPPER_AZM_STP_BIT;
	bset	20488, #0
;	src/portconfig/portconfig.c: 14: STEPPER_AZM_STP_CR2 &=~STEPPER_AZM_STP_BIT;
	bres	20489, #0
;	src/portconfig/portconfig.c: 16: STEPPER_ELV_STP_DDR |= STEPPER_ELV_STP_BIT;
	bset	20487, #4
;	src/portconfig/portconfig.c: 17: STEPPER_ELV_STP_CR1 |= STEPPER_ELV_STP_BIT;
	bset	20488, #4
;	src/portconfig/portconfig.c: 18: STEPPER_ELV_STP_CR2 &=~STEPPER_ELV_STP_BIT;
	bres	20489, #4
;	src/portconfig/portconfig.c: 20: STEPPER_AZM_DIR_DDR |= STEPPER_AZM_DIR_BIT;
	bset	20492, #1
;	src/portconfig/portconfig.c: 21: STEPPER_AZM_DIR_CR1 |= STEPPER_AZM_DIR_BIT;
	bset	20493, #1
;	src/portconfig/portconfig.c: 22: STEPPER_AZM_DIR_CR2 &=~STEPPER_AZM_DIR_BIT;
	bres	20494, #1
;	src/portconfig/portconfig.c: 24: STEPPER_ELV_DIR_DDR |= STEPPER_ELV_DIR_BIT;
	bset	20492, #2
;	src/portconfig/portconfig.c: 25: STEPPER_ELV_DIR_CR1 |= STEPPER_ELV_DIR_BIT;
	bset	20493, #2
;	src/portconfig/portconfig.c: 26: STEPPER_ELV_DIR_CR2 &=~STEPPER_ELV_DIR_BIT;
	bres	20494, #2
;	src/portconfig/portconfig.c: 30: STEPPER_AZM_LIMIT_DDR &=~STEPPER_AZM_LIMIT_BIT;
	bres	20492, #4
;	src/portconfig/portconfig.c: 31: STEPPER_AZM_LIMIT_CR1 &=~STEPPER_AZM_LIMIT_BIT;
	bres	20493, #4
;	src/portconfig/portconfig.c: 32: STEPPER_AZM_LIMIT_CR2 |= STEPPER_AZM_LIMIT_BIT;
	ld	a, 0x500e
	or	a, #0x10
	ld	0x500e, a
;	src/portconfig/portconfig.c: 34: __asm__("sim");
	sim
;	src/portconfig/portconfig.c: 35: EXTI_CR1 |= PCIS_L; // 01 into PCIS bits --> rising edge interrupt
	ld	a, 0x50a0
	or	a, #0x10
	ld	0x50a0, a
;	src/portconfig/portconfig.c: 36: EXTI_CR1 &=~PCIS_H;
	ld	a, 0x50a0
	and	a, #0xdf
	ld	0x50a0, a
;	src/portconfig/portconfig.c: 37: __asm__("rim");
	rim
;	src/portconfig/portconfig.c: 38: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
