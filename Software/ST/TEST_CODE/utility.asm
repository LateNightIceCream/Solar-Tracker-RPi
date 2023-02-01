;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module utility
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _hsi_configure
	.globl _clk_out_enable
	.globl _opt_write
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
;	src/utility/utility.c: 3: void hsi_configure () {
;	-----------------------------------------
;	 function hsi_configure
;	-----------------------------------------
_hsi_configure:
;	src/utility/utility.c: 4: while ((CLK_ICKR & BIT1) == 0); // HSRDY
00101$:
	ld	a, 0x50c0
	bcp	a, #0x02
	jreq	00101$
;	src/utility/utility.c: 6: while((CLK_SWCR & BIT0));
00104$:
	ld	a, 0x50c5
	srl	a
	jrc	00104$
;	src/utility/utility.c: 7: CLK_SWR    = 0xE1; // select HSI for Master CLK
	mov	0x50c4+0, #0xe1
;	src/utility/utility.c: 8: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	src/utility/utility.c: 10: while((CLK_SWCR & BIT0));
00107$:
	ld	a, 0x50c5
	srl	a
	jrc	00107$
;	src/utility/utility.c: 11: CLK_SWCR |= BIT1;
	bset	20677, #1
;	src/utility/utility.c: 12: while((CLK_SWCR & BIT0));
00110$:
	ld	a, 0x50c5
	srl	a
	jrc	00110$
;	src/utility/utility.c: 13: CLK_SWCR &= ~BIT1;
	bres	20677, #1
;	src/utility/utility.c: 14: }
	ret
;	src/utility/utility.c: 16: void clk_out_enable() {
;	-----------------------------------------
;	 function clk_out_enable
;	-----------------------------------------
_clk_out_enable:
;	src/utility/utility.c: 18: PD_DDR |= BIT0;
	bset	20497, #0
;	src/utility/utility.c: 20: PD_CR1 |= BIT0;
	bset	20498, #0
;	src/utility/utility.c: 21: PD_CR2 |= BIT0;
	bset	20499, #0
;	src/utility/utility.c: 23: CLK_CCOR |= (BIT0 | (0b1011 << 1));
	ld	a, 0x50c9
	or	a, #0x17
	ld	0x50c9, a
;	src/utility/utility.c: 24: }
	ret
;	src/utility/utility.c: 27: void opt_write() {
;	-----------------------------------------
;	 function opt_write
;	-----------------------------------------
_opt_write:
;	src/utility/utility.c: 35: FLASH_DUKR = FLASH_DUKR_KEY1;
	mov	0x5064+0, #0xae
;	src/utility/utility.c: 36: FLASH_DUKR = FLASH_DUKR_KEY2;
	mov	0x5064+0, #0x56
;	src/utility/utility.c: 37: while (!(FLASH_IAPSR & BIT3));
00101$:
	ld	a, 0x505f
	bcp	a, #0x08
	jreq	00101$
;	src/utility/utility.c: 39: FLASH_CR2 |= BIT7;
	bset	20571, #7
;	src/utility/utility.c: 40: FLASH_NCR2 &= ~BIT7;
	bres	20572, #7
;	src/utility/utility.c: 43: *((uint8_t*) 0x4803) = opt0;
	mov	0x4803+0, #0x24
;	src/utility/utility.c: 44: *((uint8_t*) 0x4804) = ~opt0;
	mov	0x4804+0, #0xdb
;	src/utility/utility.c: 47: while (!(FLASH_IAPSR & BIT2));
00104$:
	ld	a, 0x505f
	bcp	a, #0x04
	jreq	00104$
;	src/utility/utility.c: 49: FLASH_IAPSR &= ~BIT3;
	bres	20575, #3
;	src/utility/utility.c: 50: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
