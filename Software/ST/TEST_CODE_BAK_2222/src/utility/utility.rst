                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.1.0 #12072 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module utility
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _hsi_configure
                                     12 	.globl _clk_out_enable
                                     13 	.globl _opt_write
                                     14 ;--------------------------------------------------------
                                     15 ; ram data
                                     16 ;--------------------------------------------------------
                                     17 	.area DATA
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area INITIALIZED
                                     22 ;--------------------------------------------------------
                                     23 ; absolute external ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area DABS (ABS)
                                     26 
                                     27 ; default segment ordering for linker
                                     28 	.area HOME
                                     29 	.area GSINIT
                                     30 	.area GSFINAL
                                     31 	.area CONST
                                     32 	.area INITIALIZER
                                     33 	.area CODE
                                     34 
                                     35 ;--------------------------------------------------------
                                     36 ; global & static initialisations
                                     37 ;--------------------------------------------------------
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area GSINIT
                                     42 ;--------------------------------------------------------
                                     43 ; Home
                                     44 ;--------------------------------------------------------
                                     45 	.area HOME
                                     46 	.area HOME
                                     47 ;--------------------------------------------------------
                                     48 ; code
                                     49 ;--------------------------------------------------------
                                     50 	.area CODE
                                     51 ;	src/utility/utility.c: 3: void hsi_configure () {
                                     52 ;	-----------------------------------------
                                     53 ;	 function hsi_configure
                                     54 ;	-----------------------------------------
      0083AA                         55 _hsi_configure:
                                     56 ;	src/utility/utility.c: 4: while ((CLK_ICKR & BIT1) == 0); // HSRDY
      0083AA                         57 00101$:
      0083AA C6 50 C0         [ 1]   58 	ld	a, 0x50c0
      0083AD A5 02            [ 1]   59 	bcp	a, #0x02
      0083AF 27 F9            [ 1]   60 	jreq	00101$
                                     61 ;	src/utility/utility.c: 6: while((CLK_SWCR & BIT0));
      0083B1                         62 00104$:
      0083B1 C6 50 C5         [ 1]   63 	ld	a, 0x50c5
      0083B4 44               [ 1]   64 	srl	a
      0083B5 25 FA            [ 1]   65 	jrc	00104$
                                     66 ;	src/utility/utility.c: 7: CLK_SWR    = 0xE1; // select HSI for Master CLK
      0083B7 35 E1 50 C4      [ 1]   67 	mov	0x50c4+0, #0xe1
                                     68 ;	src/utility/utility.c: 8: CLK_CKDIVR = 0;
      0083BB 35 00 50 C6      [ 1]   69 	mov	0x50c6+0, #0x00
                                     70 ;	src/utility/utility.c: 10: while((CLK_SWCR & BIT0));
      0083BF                         71 00107$:
      0083BF C6 50 C5         [ 1]   72 	ld	a, 0x50c5
      0083C2 44               [ 1]   73 	srl	a
      0083C3 25 FA            [ 1]   74 	jrc	00107$
                                     75 ;	src/utility/utility.c: 11: CLK_SWCR |= BIT1;
      0083C5 72 12 50 C5      [ 1]   76 	bset	20677, #1
                                     77 ;	src/utility/utility.c: 12: while((CLK_SWCR & BIT0));
      0083C9                         78 00110$:
      0083C9 C6 50 C5         [ 1]   79 	ld	a, 0x50c5
      0083CC 44               [ 1]   80 	srl	a
      0083CD 25 FA            [ 1]   81 	jrc	00110$
                                     82 ;	src/utility/utility.c: 13: CLK_SWCR &= ~BIT1;
      0083CF 72 13 50 C5      [ 1]   83 	bres	20677, #1
                                     84 ;	src/utility/utility.c: 14: }
      0083D3 81               [ 4]   85 	ret
                                     86 ;	src/utility/utility.c: 16: void clk_out_enable() {
                                     87 ;	-----------------------------------------
                                     88 ;	 function clk_out_enable
                                     89 ;	-----------------------------------------
      0083D4                         90 _clk_out_enable:
                                     91 ;	src/utility/utility.c: 18: PD_DDR |= BIT0;
      0083D4 72 10 50 11      [ 1]   92 	bset	20497, #0
                                     93 ;	src/utility/utility.c: 20: PD_CR1 |= BIT0;
      0083D8 72 10 50 12      [ 1]   94 	bset	20498, #0
                                     95 ;	src/utility/utility.c: 21: PD_CR2 |= BIT0;
      0083DC 72 10 50 13      [ 1]   96 	bset	20499, #0
                                     97 ;	src/utility/utility.c: 23: CLK_CCOR |= (BIT0 | (0b1011 << 1));
      0083E0 C6 50 C9         [ 1]   98 	ld	a, 0x50c9
      0083E3 AA 17            [ 1]   99 	or	a, #0x17
      0083E5 C7 50 C9         [ 1]  100 	ld	0x50c9, a
                                    101 ;	src/utility/utility.c: 24: }
      0083E8 81               [ 4]  102 	ret
                                    103 ;	src/utility/utility.c: 27: void opt_write() {
                                    104 ;	-----------------------------------------
                                    105 ;	 function opt_write
                                    106 ;	-----------------------------------------
      0083E9                        107 _opt_write:
                                    108 ;	src/utility/utility.c: 35: FLASH_DUKR = FLASH_DUKR_KEY1;
      0083E9 35 AE 50 64      [ 1]  109 	mov	0x5064+0, #0xae
                                    110 ;	src/utility/utility.c: 36: FLASH_DUKR = FLASH_DUKR_KEY2;
      0083ED 35 56 50 64      [ 1]  111 	mov	0x5064+0, #0x56
                                    112 ;	src/utility/utility.c: 37: while (!(FLASH_IAPSR & BIT3));
      0083F1                        113 00101$:
      0083F1 C6 50 5F         [ 1]  114 	ld	a, 0x505f
      0083F4 A5 08            [ 1]  115 	bcp	a, #0x08
      0083F6 27 F9            [ 1]  116 	jreq	00101$
                                    117 ;	src/utility/utility.c: 39: FLASH_CR2 |= BIT7;
      0083F8 72 1E 50 5B      [ 1]  118 	bset	20571, #7
                                    119 ;	src/utility/utility.c: 40: FLASH_NCR2 &= ~BIT7;
      0083FC 72 1F 50 5C      [ 1]  120 	bres	20572, #7
                                    121 ;	src/utility/utility.c: 43: *((uint8_t*) 0x4803) = opt0;
      008400 35 24 48 03      [ 1]  122 	mov	0x4803+0, #0x24
                                    123 ;	src/utility/utility.c: 44: *((uint8_t*) 0x4804) = ~opt0;
      008404 35 DB 48 04      [ 1]  124 	mov	0x4804+0, #0xdb
                                    125 ;	src/utility/utility.c: 47: while (!(FLASH_IAPSR & BIT2));
      008408                        126 00104$:
      008408 C6 50 5F         [ 1]  127 	ld	a, 0x505f
      00840B A5 04            [ 1]  128 	bcp	a, #0x04
      00840D 27 F9            [ 1]  129 	jreq	00104$
                                    130 ;	src/utility/utility.c: 49: FLASH_IAPSR &= ~BIT3;
      00840F 72 17 50 5F      [ 1]  131 	bres	20575, #3
                                    132 ;	src/utility/utility.c: 50: }
      008413 81               [ 4]  133 	ret
                                    134 	.area CODE
                                    135 	.area CONST
                                    136 	.area INITIALIZER
                                    137 	.area CABS (ABS)
