                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.1.0 #12072 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module portconfig
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _port_init
                                     12 ;--------------------------------------------------------
                                     13 ; ram data
                                     14 ;--------------------------------------------------------
                                     15 	.area DATA
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area INITIALIZED
                                     20 ;--------------------------------------------------------
                                     21 ; absolute external ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DABS (ABS)
                                     24 
                                     25 ; default segment ordering for linker
                                     26 	.area HOME
                                     27 	.area GSINIT
                                     28 	.area GSFINAL
                                     29 	.area CONST
                                     30 	.area INITIALIZER
                                     31 	.area CODE
                                     32 
                                     33 ;--------------------------------------------------------
                                     34 ; global & static initialisations
                                     35 ;--------------------------------------------------------
                                     36 	.area HOME
                                     37 	.area GSINIT
                                     38 	.area GSFINAL
                                     39 	.area GSINIT
                                     40 ;--------------------------------------------------------
                                     41 ; Home
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
                                     44 	.area HOME
                                     45 ;--------------------------------------------------------
                                     46 ; code
                                     47 ;--------------------------------------------------------
                                     48 	.area CODE
                                     49 ;	src/portconfig/portconfig.c: 3: void port_init () {
                                     50 ;	-----------------------------------------
                                     51 ;	 function port_init
                                     52 ;	-----------------------------------------
      0080BB                         53 _port_init:
                                     54 ;	src/portconfig/portconfig.c: 5: PC_DDR |= (BIT3);
      0080BB 72 16 50 0C      [ 1]   55 	bset	20492, #3
                                     56 ;	src/portconfig/portconfig.c: 6: PC_CR1 |= (BIT3);
      0080BF 72 16 50 0D      [ 1]   57 	bset	20493, #3
                                     58 ;	src/portconfig/portconfig.c: 7: PC_CR2 &= ~(BIT3);
      0080C3 72 17 50 0E      [ 1]   59 	bres	20494, #3
                                     60 ;	src/portconfig/portconfig.c: 8: PC_ODR |= BIT3; // HIGH Output reset and sleep
      0080C7 72 16 50 0A      [ 1]   61 	bset	20490, #3
                                     62 ;	src/portconfig/portconfig.c: 10: PB_DDR &= ~BIT2; // has to be set as input bc of a short to ground on the board
      0080CB 72 15 50 07      [ 1]   63 	bres	20487, #2
                                     64 ;	src/portconfig/portconfig.c: 12: STEPPER_AZM_STP_DDR |= STEPPER_AZM_STP_BIT;
      0080CF 72 10 50 07      [ 1]   65 	bset	20487, #0
                                     66 ;	src/portconfig/portconfig.c: 13: STEPPER_AZM_STP_CR1 |= STEPPER_AZM_STP_BIT;
      0080D3 72 10 50 08      [ 1]   67 	bset	20488, #0
                                     68 ;	src/portconfig/portconfig.c: 14: STEPPER_AZM_STP_CR2 &=~STEPPER_AZM_STP_BIT;
      0080D7 72 11 50 09      [ 1]   69 	bres	20489, #0
                                     70 ;	src/portconfig/portconfig.c: 16: STEPPER_ELV_STP_DDR |= STEPPER_ELV_STP_BIT;
      0080DB 72 18 50 07      [ 1]   71 	bset	20487, #4
                                     72 ;	src/portconfig/portconfig.c: 17: STEPPER_ELV_STP_CR1 |= STEPPER_ELV_STP_BIT;
      0080DF 72 18 50 08      [ 1]   73 	bset	20488, #4
                                     74 ;	src/portconfig/portconfig.c: 18: STEPPER_ELV_STP_CR2 &=~STEPPER_ELV_STP_BIT;
      0080E3 72 19 50 09      [ 1]   75 	bres	20489, #4
                                     76 ;	src/portconfig/portconfig.c: 20: STEPPER_AZM_DIR_DDR |= STEPPER_AZM_DIR_BIT;
      0080E7 72 12 50 0C      [ 1]   77 	bset	20492, #1
                                     78 ;	src/portconfig/portconfig.c: 21: STEPPER_AZM_DIR_CR1 |= STEPPER_AZM_DIR_BIT;
      0080EB 72 12 50 0D      [ 1]   79 	bset	20493, #1
                                     80 ;	src/portconfig/portconfig.c: 22: STEPPER_AZM_DIR_CR2 &=~STEPPER_AZM_DIR_BIT;
      0080EF 72 13 50 0E      [ 1]   81 	bres	20494, #1
                                     82 ;	src/portconfig/portconfig.c: 24: STEPPER_ELV_DIR_DDR |= STEPPER_ELV_DIR_BIT;
      0080F3 72 14 50 0C      [ 1]   83 	bset	20492, #2
                                     84 ;	src/portconfig/portconfig.c: 25: STEPPER_ELV_DIR_CR1 |= STEPPER_ELV_DIR_BIT;
      0080F7 72 14 50 0D      [ 1]   85 	bset	20493, #2
                                     86 ;	src/portconfig/portconfig.c: 26: STEPPER_ELV_DIR_CR2 &=~STEPPER_ELV_DIR_BIT;
      0080FB 72 15 50 0E      [ 1]   87 	bres	20494, #2
                                     88 ;	src/portconfig/portconfig.c: 30: STEPPER_AZM_LIMIT_DDR &=~STEPPER_AZM_LIMIT_BIT;
      0080FF 72 19 50 0C      [ 1]   89 	bres	20492, #4
                                     90 ;	src/portconfig/portconfig.c: 31: STEPPER_AZM_LIMIT_CR1 &=~STEPPER_AZM_LIMIT_BIT;
      008103 72 19 50 0D      [ 1]   91 	bres	20493, #4
                                     92 ;	src/portconfig/portconfig.c: 32: STEPPER_AZM_LIMIT_CR2 |= STEPPER_AZM_LIMIT_BIT;
      008107 C6 50 0E         [ 1]   93 	ld	a, 0x500e
      00810A AA 10            [ 1]   94 	or	a, #0x10
      00810C C7 50 0E         [ 1]   95 	ld	0x500e, a
                                     96 ;	src/portconfig/portconfig.c: 34: __asm__("sim");
      00810F 9B               [ 1]   97 	sim
                                     98 ;	src/portconfig/portconfig.c: 35: EXTI_CR1 |= PCIS_L; // 01 into PCIS bits --> rising edge interrupt
      008110 C6 50 A0         [ 1]   99 	ld	a, 0x50a0
      008113 AA 10            [ 1]  100 	or	a, #0x10
      008115 C7 50 A0         [ 1]  101 	ld	0x50a0, a
                                    102 ;	src/portconfig/portconfig.c: 36: EXTI_CR1 &=~PCIS_H;
      008118 C6 50 A0         [ 1]  103 	ld	a, 0x50a0
      00811B A4 DF            [ 1]  104 	and	a, #0xdf
      00811D C7 50 A0         [ 1]  105 	ld	0x50a0, a
                                    106 ;	src/portconfig/portconfig.c: 37: __asm__("rim");
      008120 9A               [ 1]  107 	rim
                                    108 ;	src/portconfig/portconfig.c: 38: }
      008121 81               [ 4]  109 	ret
                                    110 	.area CODE
                                    111 	.area CONST
                                    112 	.area INITIALIZER
                                    113 	.area CABS (ABS)
