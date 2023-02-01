                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.1.0 #12072 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _uart2_rx_isr
                                     12 	.globl _uart2_tx_isr
                                     13 	.globl _port_c_isr
                                     14 	.globl _timer_isr
                                     15 	.globl _main
                                     16 	.globl _malloc
                                     17 	.globl _strtol
                                     18 	.globl _port_init
                                     19 	.globl _stepper_init
                                     20 	.globl _home_azm
                                     21 	.globl _home_elv
                                     22 	.globl _turn_steps_azm
                                     23 	.globl _turn_steps_elv
                                     24 	.globl _init_command_buffer
                                     25 	.globl _get_steps_from_command
                                     26 	.globl _uart2_write
                                     27 	.globl _uart2_init
                                     28 	.globl _read_next_command
                                     29 	.globl _hsi_configure
                                     30 	.globl _clk_out_enable
                                     31 	.globl _opt_write
                                     32 ;--------------------------------------------------------
                                     33 ; ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DATA
      000001                         36 _command_buffer:
      000001                         37 	.ds 32
      000021                         38 _uart_rx_buf:
      000021                         39 	.ds 127
      0000A0                         40 _uart_tx_buf:
      0000A0                         41 	.ds 2
      0000A2                         42 _read_next_command_read_index_65536_79:
      0000A2                         43 	.ds 1
      0000A3                         44 _uart2_tx_isr_i_65536_82:
      0000A3                         45 	.ds 1
      0000A4                         46 _uart2_rx_isr_byte_index_65536_85:
      0000A4                         47 	.ds 1
                                     48 ;--------------------------------------------------------
                                     49 ; ram data
                                     50 ;--------------------------------------------------------
                                     51 	.area INITIALIZED
      0004A9                         52 _target_steps:
      0004A9                         53 	.ds 2
      0004AB                         54 _stepping_done:
      0004AB                         55 	.ds 1
      0004AC                         56 _current_pos_azm:
      0004AC                         57 	.ds 2
      0004AE                         58 _current_pos_elv:
      0004AE                         59 	.ds 2
      0004B0                         60 _command_number:
      0004B0                         61 	.ds 1
      0004B1                         62 _uart_tx_done:
      0004B1                         63 	.ds 2
                                     64 ;--------------------------------------------------------
                                     65 ; Stack segment in internal ram 
                                     66 ;--------------------------------------------------------
                                     67 	.area	SSEG
      0004B3                         68 __start__stack:
      0004B3                         69 	.ds	1
                                     70 
                                     71 ;--------------------------------------------------------
                                     72 ; absolute external ram data
                                     73 ;--------------------------------------------------------
                                     74 	.area DABS (ABS)
                                     75 
                                     76 ; default segment ordering for linker
                                     77 	.area HOME
                                     78 	.area GSINIT
                                     79 	.area GSFINAL
                                     80 	.area CONST
                                     81 	.area INITIALIZER
                                     82 	.area CODE
                                     83 
                                     84 ;--------------------------------------------------------
                                     85 ; interrupt vector 
                                     86 ;--------------------------------------------------------
                                     87 	.area HOME
      008000                         88 __interrupt_vect:
      008000 82 00 80 63             89 	int s_GSINIT ; reset
      008004 82 00 00 00             90 	int 0x000000 ; trap
      008008 82 00 00 00             91 	int 0x000000 ; int0
      00800C 82 00 00 00             92 	int 0x000000 ; int1
      008010 82 00 00 00             93 	int 0x000000 ; int2
      008014 82 00 00 00             94 	int 0x000000 ; int3
      008018 82 00 00 00             95 	int 0x000000 ; int4
      00801C 82 00 82 B0             96 	int _port_c_isr ; int5
      008020 82 00 00 00             97 	int 0x000000 ; int6
      008024 82 00 00 00             98 	int 0x000000 ; int7
      008028 82 00 00 00             99 	int 0x000000 ; int8
      00802C 82 00 00 00            100 	int 0x000000 ; int9
      008030 82 00 00 00            101 	int 0x000000 ; int10
      008034 82 00 82 9A            102 	int _timer_isr ; int11
      008038 82 00 00 00            103 	int 0x000000 ; int12
      00803C 82 00 00 00            104 	int 0x000000 ; int13
      008040 82 00 00 00            105 	int 0x000000 ; int14
      008044 82 00 00 00            106 	int 0x000000 ; int15
      008048 82 00 00 00            107 	int 0x000000 ; int16
      00804C 82 00 00 00            108 	int 0x000000 ; int17
      008050 82 00 00 00            109 	int 0x000000 ; int18
      008054 82 00 00 00            110 	int 0x000000 ; int19
      008058 82 00 83 C0            111 	int _uart2_tx_isr ; int20
      00805C 82 00 83 F2            112 	int _uart2_rx_isr ; int21
                                    113 ;--------------------------------------------------------
                                    114 ; global & static initialisations
                                    115 ;--------------------------------------------------------
                                    116 	.area HOME
                                    117 	.area GSINIT
                                    118 	.area GSFINAL
                                    119 	.area GSINIT
      008063                        120 __sdcc_init_data:
                                    121 ; stm8_genXINIT() start
      008063 AE 04 A8         [ 2]  122 	ldw x, #l_DATA
      008066 27 07            [ 1]  123 	jreq	00002$
      008068                        124 00001$:
      008068 72 4F 00 00      [ 1]  125 	clr (s_DATA - 1, x)
      00806C 5A               [ 2]  126 	decw x
      00806D 26 F9            [ 1]  127 	jrne	00001$
      00806F                        128 00002$:
      00806F AE 00 0A         [ 2]  129 	ldw	x, #l_INITIALIZER
      008072 27 09            [ 1]  130 	jreq	00004$
      008074                        131 00003$:
      008074 D6 80 97         [ 1]  132 	ld	a, (s_INITIALIZER - 1, x)
      008077 D7 04 A8         [ 1]  133 	ld	(s_INITIALIZED - 1, x), a
      00807A 5A               [ 2]  134 	decw	x
      00807B 26 F7            [ 1]  135 	jrne	00003$
      00807D                        136 00004$:
                                    137 ; stm8_genXINIT() end
                                    138 ;	main.c: 379: static uint8_t read_index = 0; // reading position in command_buffer
      00807D 72 5F 00 A2      [ 1]  139 	clr	_read_next_command_read_index_65536_79+0
                                    140 ;	main.c: 402: static uint8_t i = 1;
      008081 35 01 00 A3      [ 1]  141 	mov	_uart2_tx_isr_i_65536_82+0, #0x01
                                    142 ;	main.c: 421: static uint8_t byte_index = 0;
      008085 72 5F 00 A4      [ 1]  143 	clr	_uart2_rx_isr_byte_index_65536_85+0
                                    144 	.area GSFINAL
      00808C CC 80 60         [ 2]  145 	jp	__sdcc_program_startup
                                    146 ;--------------------------------------------------------
                                    147 ; Home
                                    148 ;--------------------------------------------------------
                                    149 	.area HOME
                                    150 	.area HOME
      008060                        151 __sdcc_program_startup:
      008060 CC 80 A2         [ 2]  152 	jp	_main
                                    153 ;	return from main will return to caller
                                    154 ;--------------------------------------------------------
                                    155 ; code
                                    156 ;--------------------------------------------------------
                                    157 	.area CODE
                                    158 ;	main.c: 18: void main() {
                                    159 ;	-----------------------------------------
                                    160 ;	 function main
                                    161 ;	-----------------------------------------
      0080A2                        162 _main:
      0080A2 52 02            [ 2]  163 	sub	sp, #2
                                    164 ;	main.c: 19: __asm__("rim");
      0080A4 9A               [ 1]  165 	rim
                                    166 ;	main.c: 22: hsi_configure(); // hse currently doesnt work
      0080A5 CD 84 3F         [ 4]  167 	call	_hsi_configure
                                    168 ;	main.c: 23: port_init();
      0080A8 CD 81 1F         [ 4]  169 	call	_port_init
                                    170 ;	main.c: 24: stepper_init();
      0080AB CD 81 92         [ 4]  171 	call	_stepper_init
                                    172 ;	main.c: 25: uart2_init();
      0080AE CD 83 74         [ 4]  173 	call	_uart2_init
                                    174 ;	main.c: 28: while (1) {
      0080B1                        175 00120$:
                                    176 ;	main.c: 30: command = read_next_command();
      0080B1 CD 83 9B         [ 4]  177 	call	_read_next_command
                                    178 ;	main.c: 35: switch (command[0]) {
      0080B4 1F 01            [ 2]  179 	ldw	(0x01, sp), x
      0080B6 F6               [ 1]  180 	ld	a, (x)
      0080B7 A1 61            [ 1]  181 	cp	a, #0x61
      0080B9 27 0E            [ 1]  182 	jreq	00101$
      0080BB A1 65            [ 1]  183 	cp	a, #0x65
      0080BD 27 1D            [ 1]  184 	jreq	00104$
      0080BF A1 68            [ 1]  185 	cp	a, #0x68
      0080C1 27 37            [ 1]  186 	jreq	00108$
      0080C3 A1 70            [ 1]  187 	cp	a, #0x70
      0080C5 27 28            [ 1]  188 	jreq	00107$
      0080C7 20 4C            [ 2]  189 	jra	00118$
                                    190 ;	main.c: 37: case 'a': // azimuth
      0080C9                        191 00101$:
                                    192 ;	main.c: 39: steps = get_steps_from_command(command);
      0080C9 1E 01            [ 2]  193 	ldw	x, (0x01, sp)
      0080CB 89               [ 2]  194 	pushw	x
      0080CC CD 83 1E         [ 4]  195 	call	_get_steps_from_command
      0080CF 5B 02            [ 2]  196 	addw	sp, #2
                                    197 ;	main.c: 41: if (steps == 0)
      0080D1 5D               [ 2]  198 	tnzw	x
      0080D2 27 41            [ 1]  199 	jreq	00118$
                                    200 ;	main.c: 44: turn_steps_azm(steps);
      0080D4 89               [ 2]  201 	pushw	x
      0080D5 CD 81 AF         [ 4]  202 	call	_turn_steps_azm
      0080D8 5B 02            [ 2]  203 	addw	sp, #2
                                    204 ;	main.c: 46: break;
      0080DA 20 39            [ 2]  205 	jra	00118$
                                    206 ;	main.c: 48: case 'e': // elevation
      0080DC                        207 00104$:
                                    208 ;	main.c: 50: steps = get_steps_from_command(command);
      0080DC 1E 01            [ 2]  209 	ldw	x, (0x01, sp)
      0080DE 89               [ 2]  210 	pushw	x
      0080DF CD 83 1E         [ 4]  211 	call	_get_steps_from_command
      0080E2 5B 02            [ 2]  212 	addw	sp, #2
                                    213 ;	main.c: 52: if (steps == 0)
      0080E4 5D               [ 2]  214 	tnzw	x
      0080E5 27 2E            [ 1]  215 	jreq	00118$
                                    216 ;	main.c: 55: turn_steps_elv(steps);
      0080E7 89               [ 2]  217 	pushw	x
      0080E8 CD 81 F6         [ 4]  218 	call	_turn_steps_elv
      0080EB 5B 02            [ 2]  219 	addw	sp, #2
                                    220 ;	main.c: 57: break;
      0080ED 20 26            [ 2]  221 	jra	00118$
                                    222 ;	main.c: 59: case 'p': // ping
      0080EF                        223 00107$:
                                    224 ;	main.c: 60: uart2_write("e\n");
      0080EF 4B 8F            [ 1]  225 	push	#<(___str_0+0)
      0080F1 4B 80            [ 1]  226 	push	#((___str_0+0) >> 8)
      0080F3 CD 83 51         [ 4]  227 	call	_uart2_write
      0080F6 5B 02            [ 2]  228 	addw	sp, #2
                                    229 ;	main.c: 61: break;
      0080F8 20 1B            [ 2]  230 	jra	00118$
                                    231 ;	main.c: 63: case 'h':
      0080FA                        232 00108$:
                                    233 ;	main.c: 64: if (command[1] == '\n' || command[1] == '\0') {
      0080FA 1E 01            [ 2]  234 	ldw	x, (0x01, sp)
      0080FC E6 01            [ 1]  235 	ld	a, (0x1, x)
      0080FE A1 0A            [ 1]  236 	cp	a, #0x0a
      008100 27 13            [ 1]  237 	jreq	00118$
      008102 4D               [ 1]  238 	tnz	a
      008103 27 10            [ 1]  239 	jreq	00118$
                                    240 ;	main.c: 68: if (command[1] == 'a') {
      008105 A1 61            [ 1]  241 	cp	a, #0x61
      008107 26 05            [ 1]  242 	jrne	00115$
                                    243 ;	main.c: 69: home_azm();
      008109 CD 81 9B         [ 4]  244 	call	_home_azm
      00810C 20 07            [ 2]  245 	jra	00118$
      00810E                        246 00115$:
                                    247 ;	main.c: 71: else if ( command[1] == 'e'){
      00810E A1 65            [ 1]  248 	cp	a, #0x65
      008110 26 03            [ 1]  249 	jrne	00118$
                                    250 ;	main.c: 72: home_elv();
      008112 CD 81 A5         [ 4]  251 	call	_home_elv
                                    252 ;	main.c: 79: }
      008115                        253 00118$:
                                    254 ;	main.c: 80: uart2_write(command);
      008115 1E 01            [ 2]  255 	ldw	x, (0x01, sp)
      008117 89               [ 2]  256 	pushw	x
      008118 CD 83 51         [ 4]  257 	call	_uart2_write
      00811B 5B 02            [ 2]  258 	addw	sp, #2
                                    259 ;	main.c: 82: }
      00811D 20 92            [ 2]  260 	jra	00120$
                                    261 ;	main.c: 84: void port_init () {
                                    262 ;	-----------------------------------------
                                    263 ;	 function port_init
                                    264 ;	-----------------------------------------
      00811F                        265 _port_init:
                                    266 ;	main.c: 86: PC_DDR |= (BIT3);
      00811F 72 16 50 0C      [ 1]  267 	bset	20492, #3
                                    268 ;	main.c: 87: PC_CR1 |= (BIT3);
      008123 72 16 50 0D      [ 1]  269 	bset	20493, #3
                                    270 ;	main.c: 88: PC_CR2 &= ~(BIT3);
      008127 72 17 50 0E      [ 1]  271 	bres	20494, #3
                                    272 ;	main.c: 89: PC_ODR |= BIT3; // HIGH Output reset and sleep
      00812B 72 16 50 0A      [ 1]  273 	bset	20490, #3
                                    274 ;	main.c: 91: PB_DDR &= ~BIT2; // has to be set as input bc of a short to ground on the board
      00812F 72 15 50 07      [ 1]  275 	bres	20487, #2
                                    276 ;	main.c: 93: STEPPER_AZM_STP_DDR |= STEPPER_AZM_STP_BIT;
      008133 72 10 50 07      [ 1]  277 	bset	20487, #0
                                    278 ;	main.c: 94: STEPPER_AZM_STP_CR1 |= STEPPER_AZM_STP_BIT;
      008137 72 10 50 08      [ 1]  279 	bset	20488, #0
                                    280 ;	main.c: 95: STEPPER_AZM_STP_CR2 &=~STEPPER_AZM_STP_BIT;
      00813B 72 11 50 09      [ 1]  281 	bres	20489, #0
                                    282 ;	main.c: 97: STEPPER_ELV_STP_DDR |= STEPPER_ELV_STP_BIT;
      00813F 72 18 50 07      [ 1]  283 	bset	20487, #4
                                    284 ;	main.c: 98: STEPPER_ELV_STP_CR1 |= STEPPER_ELV_STP_BIT;
      008143 72 18 50 08      [ 1]  285 	bset	20488, #4
                                    286 ;	main.c: 99: STEPPER_ELV_STP_CR2 &=~STEPPER_ELV_STP_BIT;
      008147 72 19 50 09      [ 1]  287 	bres	20489, #4
                                    288 ;	main.c: 101: STEPPER_AZM_DIR_DDR |= STEPPER_AZM_DIR_BIT;
      00814B 72 12 50 0C      [ 1]  289 	bset	20492, #1
                                    290 ;	main.c: 102: STEPPER_AZM_DIR_CR1 |= STEPPER_AZM_DIR_BIT;
      00814F 72 12 50 0D      [ 1]  291 	bset	20493, #1
                                    292 ;	main.c: 103: STEPPER_AZM_DIR_CR2 &=~STEPPER_AZM_DIR_BIT;
      008153 72 13 50 0E      [ 1]  293 	bres	20494, #1
                                    294 ;	main.c: 105: STEPPER_ELV_DIR_DDR |= STEPPER_ELV_DIR_BIT;
      008157 72 14 50 0C      [ 1]  295 	bset	20492, #2
                                    296 ;	main.c: 106: STEPPER_ELV_DIR_CR1 |= STEPPER_ELV_DIR_BIT;
      00815B 72 14 50 0D      [ 1]  297 	bset	20493, #2
                                    298 ;	main.c: 107: STEPPER_ELV_DIR_CR2 &=~STEPPER_ELV_DIR_BIT;
      00815F C6 50 0E         [ 1]  299 	ld	a, 0x500e
      008162 A4 FB            [ 1]  300 	and	a, #0xfb
      008164 C7 50 0E         [ 1]  301 	ld	0x500e, a
                                    302 ;	main.c: 109: __asm__("sim");
      008167 9B               [ 1]  303 	sim
                                    304 ;	main.c: 110: EXTI_CR1 |= PCIS_L; // 01 into PCIS bits --> rising edge interrupt
      008168 C6 50 A0         [ 1]  305 	ld	a, 0x50a0
      00816B AA 10            [ 1]  306 	or	a, #0x10
      00816D C7 50 A0         [ 1]  307 	ld	0x50a0, a
                                    308 ;	main.c: 111: EXTI_CR1 &=~PCIS_H;
      008170 C6 50 A0         [ 1]  309 	ld	a, 0x50a0
      008173 A4 DF            [ 1]  310 	and	a, #0xdf
      008175 C7 50 A0         [ 1]  311 	ld	0x50a0, a
                                    312 ;	main.c: 112: __asm__("rim");
      008178 9A               [ 1]  313 	rim
                                    314 ;	main.c: 116: STEPPER_AZM_LIMIT_DDR &=~STEPPER_AZM_LIMIT_BIT;
      008179 72 19 50 0C      [ 1]  315 	bres	20492, #4
                                    316 ;	main.c: 117: STEPPER_AZM_LIMIT_CR1 &=~STEPPER_AZM_LIMIT_BIT;
      00817D 72 19 50 0D      [ 1]  317 	bres	20493, #4
                                    318 ;	main.c: 118: STEPPER_AZM_LIMIT_CR2 |= STEPPER_AZM_LIMIT_BIT;
      008181 72 18 50 0E      [ 1]  319 	bset	20494, #4
                                    320 ;	main.c: 120: STEPPER_ELV_LIMIT_DDR &=~STEPPER_ELV_LIMIT_BIT;
      008185 72 1B 50 0C      [ 1]  321 	bres	20492, #5
                                    322 ;	main.c: 121: STEPPER_ELV_LIMIT_CR1 &=~STEPPER_ELV_LIMIT_BIT;
      008189 72 1B 50 0D      [ 1]  323 	bres	20493, #5
                                    324 ;	main.c: 122: STEPPER_ELV_LIMIT_CR2 |= STEPPER_ELV_LIMIT_BIT;
      00818D 72 1A 50 0E      [ 1]  325 	bset	20494, #5
                                    326 ;	main.c: 124: }
      008191 81               [ 4]  327 	ret
                                    328 ;	main.c: 135: stepper_init () {
                                    329 ;	-----------------------------------------
                                    330 ;	 function stepper_init
                                    331 ;	-----------------------------------------
      008192                        332 _stepper_init:
                                    333 ;	main.c: 136: timer_init();
      008192 CD 82 3D         [ 4]  334 	call	_timer_init
                                    335 ;	main.c: 137: home_azm();
      008195 CD 81 9B         [ 4]  336 	call	_home_azm
                                    337 ;	main.c: 138: home_elv();
                                    338 ;	main.c: 139: }
      008198 CC 81 A5         [ 2]  339 	jp	_home_elv
                                    340 ;	main.c: 144: home_azm () {
                                    341 ;	-----------------------------------------
                                    342 ;	 function home_azm
                                    343 ;	-----------------------------------------
      00819B                        344 _home_azm:
                                    345 ;	main.c: 146: turn_steps_azm(-6400);
      00819B 4B 00            [ 1]  346 	push	#0x00
      00819D 4B E7            [ 1]  347 	push	#0xe7
      00819F CD 81 AF         [ 4]  348 	call	_turn_steps_azm
      0081A2 5B 02            [ 2]  349 	addw	sp, #2
                                    350 ;	main.c: 147: }
      0081A4 81               [ 4]  351 	ret
                                    352 ;	main.c: 150: home_elv () {
                                    353 ;	-----------------------------------------
                                    354 ;	 function home_elv
                                    355 ;	-----------------------------------------
      0081A5                        356 _home_elv:
                                    357 ;	main.c: 151: turn_steps_elv(-6400);
      0081A5 4B 00            [ 1]  358 	push	#0x00
      0081A7 4B E7            [ 1]  359 	push	#0xe7
      0081A9 CD 81 F6         [ 4]  360 	call	_turn_steps_elv
      0081AC 5B 02            [ 2]  361 	addw	sp, #2
                                    362 ;	main.c: 152: }
      0081AE 81               [ 4]  363 	ret
                                    364 ;	main.c: 157: turn_steps_azm (int16_t steps) {
                                    365 ;	-----------------------------------------
                                    366 ;	 function turn_steps_azm
                                    367 ;	-----------------------------------------
      0081AF                        368 _turn_steps_azm:
                                    369 ;	main.c: 159: if (steps == 0) {
      0081AF 1E 03            [ 2]  370 	ldw	x, (0x03, sp)
      0081B1 26 01            [ 1]  371 	jrne	00107$
                                    372 ;	main.c: 160: return;
      0081B3 81               [ 4]  373 	ret
      0081B4                        374 00107$:
                                    375 ;	main.c: 162: else if (steps < 0) {
      0081B4 1E 03            [ 2]  376 	ldw	x, (0x03, sp)
      0081B6 2A 13            [ 1]  377 	jrpl	00104$
                                    378 ;	main.c: 164: if (AZM_LIMIT_PUSHED) {
      0081B8 C6 50 0B         [ 1]  379 	ld	a, 0x500b
      0081BB A5 10            [ 1]  380 	bcp	a, #0x10
      0081BD 27 01            [ 1]  381 	jreq	00102$
                                    382 ;	main.c: 165: return;
      0081BF 81               [ 4]  383 	ret
      0081C0                        384 00102$:
                                    385 ;	main.c: 168: AZM_SET_DIR_HOME;
      0081C0 72 13 50 0A      [ 1]  386 	bres	20490, #1
                                    387 ;	main.c: 169: steps = -steps;
      0081C4 1E 03            [ 2]  388 	ldw	x, (0x03, sp)
      0081C6 50               [ 2]  389 	negw	x
      0081C7 1F 03            [ 2]  390 	ldw	(0x03, sp), x
      0081C9 20 04            [ 2]  391 	jra	00108$
      0081CB                        392 00104$:
                                    393 ;	main.c: 172: AZM_SET_DIR_SPA;
      0081CB 72 12 50 0A      [ 1]  394 	bset	20490, #1
      0081CF                        395 00108$:
                                    396 ;	main.c: 175: ELV_STEP_DISABLE;
      0081CF 72 1D 52 5C      [ 1]  397 	bres	21084, #6
                                    398 ;	main.c: 176: AZM_STEP_ENABLE;
      0081D3 72 14 52 5C      [ 1]  399 	bset	21084, #2
                                    400 ;	main.c: 178: stepping_done = 0;
      0081D7 72 5F 04 AB      [ 1]  401 	clr	_stepping_done+0
                                    402 ;	main.c: 180: target_steps = steps;
      0081DB 1E 03            [ 2]  403 	ldw	x, (0x03, sp)
      0081DD CF 04 A9         [ 2]  404 	ldw	_target_steps+0, x
                                    405 ;	main.c: 181: TIM1_CR1 |= CEN;
      0081E0 C6 52 50         [ 1]  406 	ld	a, 0x5250
      0081E3 AA 01            [ 1]  407 	or	a, #0x01
      0081E5 C7 52 50         [ 1]  408 	ld	0x5250, a
                                    409 ;	main.c: 183: while(!stepping_done)
      0081E8                        410 00109$:
      0081E8 72 5D 04 AB      [ 1]  411 	tnz	_stepping_done+0
      0081EC 26 03            [ 1]  412 	jrne	00111$
                                    413 ;	main.c: 184: __asm__("wfi");
      0081EE 8F               [10]  414 	wfi
      0081EF 20 F7            [ 2]  415 	jra	00109$
      0081F1                        416 00111$:
                                    417 ;	main.c: 186: AZM_STEP_DISABLE;
      0081F1 72 15 52 5C      [ 1]  418 	bres	21084, #2
                                    419 ;	main.c: 187: }
      0081F5 81               [ 4]  420 	ret
                                    421 ;	main.c: 190: turn_steps_elv (int16_t steps) {
                                    422 ;	-----------------------------------------
                                    423 ;	 function turn_steps_elv
                                    424 ;	-----------------------------------------
      0081F6                        425 _turn_steps_elv:
                                    426 ;	main.c: 192: if (steps == 0) {
      0081F6 1E 03            [ 2]  427 	ldw	x, (0x03, sp)
      0081F8 26 01            [ 1]  428 	jrne	00107$
                                    429 ;	main.c: 193: return;
      0081FA 81               [ 4]  430 	ret
      0081FB                        431 00107$:
                                    432 ;	main.c: 195: else if (steps < 0) {
      0081FB 1E 03            [ 2]  433 	ldw	x, (0x03, sp)
      0081FD 2A 13            [ 1]  434 	jrpl	00104$
                                    435 ;	main.c: 197: if (ELV_LIMIT_PUSHED) {
      0081FF C6 50 0B         [ 1]  436 	ld	a, 0x500b
      008202 A5 20            [ 1]  437 	bcp	a, #0x20
      008204 27 01            [ 1]  438 	jreq	00102$
                                    439 ;	main.c: 198: return;
      008206 81               [ 4]  440 	ret
      008207                        441 00102$:
                                    442 ;	main.c: 201: ELV_SET_DIR_HOME;
      008207 72 15 50 0A      [ 1]  443 	bres	20490, #2
                                    444 ;	main.c: 202: steps = -steps;
      00820B 1E 03            [ 2]  445 	ldw	x, (0x03, sp)
      00820D 50               [ 2]  446 	negw	x
      00820E 1F 03            [ 2]  447 	ldw	(0x03, sp), x
      008210 20 04            [ 2]  448 	jra	00108$
      008212                        449 00104$:
                                    450 ;	main.c: 205: ELV_SET_DIR_SPA;
      008212 72 14 50 0A      [ 1]  451 	bset	20490, #2
      008216                        452 00108$:
                                    453 ;	main.c: 208: AZM_STEP_DISABLE;
      008216 72 15 52 5C      [ 1]  454 	bres	21084, #2
                                    455 ;	main.c: 209: ELV_STEP_ENABLE;
      00821A 72 1C 52 5C      [ 1]  456 	bset	21084, #6
                                    457 ;	main.c: 211: stepping_done = 0;
      00821E 72 5F 04 AB      [ 1]  458 	clr	_stepping_done+0
                                    459 ;	main.c: 213: target_steps = steps;
      008222 1E 03            [ 2]  460 	ldw	x, (0x03, sp)
      008224 CF 04 A9         [ 2]  461 	ldw	_target_steps+0, x
                                    462 ;	main.c: 214: TIM1_CR1 |= CEN;
      008227 C6 52 50         [ 1]  463 	ld	a, 0x5250
      00822A AA 01            [ 1]  464 	or	a, #0x01
      00822C C7 52 50         [ 1]  465 	ld	0x5250, a
                                    466 ;	main.c: 216: while(!stepping_done)
      00822F                        467 00109$:
      00822F 72 5D 04 AB      [ 1]  468 	tnz	_stepping_done+0
      008233 26 03            [ 1]  469 	jrne	00111$
                                    470 ;	main.c: 217: __asm__("wfi");
      008235 8F               [10]  471 	wfi
      008236 20 F7            [ 2]  472 	jra	00109$
      008238                        473 00111$:
                                    474 ;	main.c: 219: ELV_STEP_DISABLE;
      008238 72 1D 52 5C      [ 1]  475 	bres	21084, #6
                                    476 ;	main.c: 220: }
      00823C 81               [ 4]  477 	ret
                                    478 ;	main.c: 225: timer_init () {
                                    479 ;	-----------------------------------------
                                    480 ;	 function timer_init
                                    481 ;	-----------------------------------------
      00823D                        482 _timer_init:
                                    483 ;	main.c: 226: TIM1_CR1 &= ~CEN; // disable timer
      00823D 72 11 52 50      [ 1]  484 	bres	21072, #0
                                    485 ;	main.c: 227: TIM1_IER &= ~UIE;
      008241 72 11 52 54      [ 1]  486 	bres	21076, #0
                                    487 ;	main.c: 229: TIM1_PSCRH = 0x00;
      008245 35 00 52 60      [ 1]  488 	mov	0x5260+0, #0x00
                                    489 ;	main.c: 230: TIM1_PSCRL = 0x5F;
      008249 35 5F 52 61      [ 1]  490 	mov	0x5261+0, #0x5f
                                    491 ;	main.c: 232: TIM1_CR1 |= ARPE;
      00824D 72 1E 52 50      [ 1]  492 	bset	21072, #7
                                    493 ;	main.c: 233: TIM1_ARRH = 0x00;
      008251 35 00 52 62      [ 1]  494 	mov	0x5262+0, #0x00
                                    495 ;	main.c: 234: TIM1_ARRL = 0xff;
      008255 35 FF 52 63      [ 1]  496 	mov	0x5263+0, #0xff
                                    497 ;	main.c: 236: TIM1_CCR1H  = 0x00; // CCRx determines duty cycle
      008259 35 00 52 65      [ 1]  498 	mov	0x5265+0, #0x00
                                    499 ;	main.c: 237: TIM1_CCR1L  = 0x80;
      00825D 35 80 52 66      [ 1]  500 	mov	0x5266+0, #0x80
                                    501 ;	main.c: 239: TIM1_CCR2H  = 0x00; // CCRx determines duty cycle
      008261 35 00 52 67      [ 1]  502 	mov	0x5267+0, #0x00
                                    503 ;	main.c: 240: TIM1_CCR2L  = 0x80;
      008265 35 80 52 68      [ 1]  504 	mov	0x5268+0, #0x80
                                    505 ;	main.c: 242: TIM1_CCMR1 &= ~(CC1S_H | CC1S_L); // Output mode
      008269 C6 52 58         [ 1]  506 	ld	a, 0x5258
      00826C A4 FC            [ 1]  507 	and	a, #0xfc
      00826E C7 52 58         [ 1]  508 	ld	0x5258, a
                                    509 ;	main.c: 243: TIM1_CCMR2 &= ~(CC1S_H | CC1S_L); // Output mode
      008271 C6 52 59         [ 1]  510 	ld	a, 0x5259
      008274 A4 FC            [ 1]  511 	and	a, #0xfc
      008276 C7 52 59         [ 1]  512 	ld	0x5259, a
                                    513 ;	main.c: 245: TIM1_CCMR1 |= OCM1_PWM2; /* PWM mode 2 */
      008279 C6 52 58         [ 1]  514 	ld	a, 0x5258
      00827C AA 70            [ 1]  515 	or	a, #0x70
      00827E C7 52 58         [ 1]  516 	ld	0x5258, a
                                    517 ;	main.c: 246: TIM1_CCMR2 |= OCM1_PWM2;
      008281 C6 52 59         [ 1]  518 	ld	a, 0x5259
      008284 AA 70            [ 1]  519 	or	a, #0x70
      008286 C7 52 59         [ 1]  520 	ld	0x5259, a
                                    521 ;	main.c: 248: TIM1_CCER1 |= CC1NE | CC2NE; /* output enable */
      008289 C6 52 5C         [ 1]  522 	ld	a, 0x525c
      00828C AA 44            [ 1]  523 	or	a, #0x44
      00828E C7 52 5C         [ 1]  524 	ld	0x525c, a
                                    525 ;	main.c: 250: TIM1_BKR  = MOE; // automatic output enable
      008291 35 80 52 6D      [ 1]  526 	mov	0x526d+0, #0x80
                                    527 ;	main.c: 251: TIM1_IER |= UIE;
      008295 72 10 52 54      [ 1]  528 	bset	21076, #0
                                    529 ;	main.c: 252: }
      008299 81               [ 4]  530 	ret
                                    531 ;	main.c: 257: timer_isr(void) __interrupt(IRQ_TIM1) {
                                    532 ;	-----------------------------------------
                                    533 ;	 function timer_isr
                                    534 ;	-----------------------------------------
      00829A                        535 _timer_isr:
                                    536 ;	main.c: 259: target_steps--;
      00829A CE 04 A9         [ 2]  537 	ldw	x, _target_steps+0
      00829D 5A               [ 2]  538 	decw	x
                                    539 ;	main.c: 261: if (target_steps == 0) {
      00829E CF 04 A9         [ 2]  540 	ldw	_target_steps+0, x
      0082A1 26 08            [ 1]  541 	jrne	00102$
                                    542 ;	main.c: 262: TIM1_CR1 &= ~CEN;
      0082A3 72 11 52 50      [ 1]  543 	bres	21072, #0
                                    544 ;	main.c: 263: stepping_done = 1;
      0082A7 35 01 04 AB      [ 1]  545 	mov	_stepping_done+0, #0x01
      0082AB                        546 00102$:
                                    547 ;	main.c: 266: TIM1_SR1 &= ~UIF;
      0082AB 72 11 52 55      [ 1]  548 	bres	21077, #0
                                    549 ;	main.c: 267: }
      0082AF 80               [11]  550 	iret
                                    551 ;	main.c: 271: port_c_isr(void) __interrupt(IRQ_EXTI2) {
                                    552 ;	-----------------------------------------
                                    553 ;	 function port_c_isr
                                    554 ;	-----------------------------------------
      0082B0                        555 _port_c_isr:
                                    556 ;	main.c: 272: if (AZM_LIMIT_PUSHED) {
      0082B0 C6 50 0B         [ 1]  557 	ld	a, 0x500b
      0082B3 A5 10            [ 1]  558 	bcp	a, #0x10
      0082B5 27 10            [ 1]  559 	jreq	00102$
                                    560 ;	main.c: 273: current_pos_azm  = ZERO_POSITION_AZM;
      0082B7 5F               [ 1]  561 	clrw	x
      0082B8 CF 04 AC         [ 2]  562 	ldw	_current_pos_azm+0, x
                                    563 ;	main.c: 274: target_steps = 0;
      0082BB 5F               [ 1]  564 	clrw	x
      0082BC CF 04 A9         [ 2]  565 	ldw	_target_steps+0, x
                                    566 ;	main.c: 275: stepping_done = 1;
      0082BF 35 01 04 AB      [ 1]  567 	mov	_stepping_done+0, #0x01
                                    568 ;	main.c: 276: TIM1_CR1 &= ~CEN;
      0082C3 72 11 52 50      [ 1]  569 	bres	21072, #0
      0082C7                        570 00102$:
                                    571 ;	main.c: 279: if (ELV_LIMIT_PUSHED) {
      0082C7 C6 50 0B         [ 1]  572 	ld	a, 0x500b
      0082CA A5 20            [ 1]  573 	bcp	a, #0x20
      0082CC 27 12            [ 1]  574 	jreq	00105$
                                    575 ;	main.c: 280: current_pos_elv  = ZERO_POSITION_ELV;
      0082CE AE FF C3         [ 2]  576 	ldw	x, #0xffc3
      0082D1 CF 04 AE         [ 2]  577 	ldw	_current_pos_elv+0, x
                                    578 ;	main.c: 281: target_steps = 0;
      0082D4 5F               [ 1]  579 	clrw	x
      0082D5 CF 04 A9         [ 2]  580 	ldw	_target_steps+0, x
                                    581 ;	main.c: 282: stepping_done = 1; // ?
      0082D8 35 01 04 AB      [ 1]  582 	mov	_stepping_done+0, #0x01
                                    583 ;	main.c: 283: TIM1_CR1 &= ~CEN;
      0082DC 72 11 52 50      [ 1]  584 	bres	21072, #0
      0082E0                        585 00105$:
                                    586 ;	main.c: 285: }
      0082E0 80               [11]  587 	iret
                                    588 ;	main.c: 301: init_command_buffer () {
                                    589 ;	-----------------------------------------
                                    590 ;	 function init_command_buffer
                                    591 ;	-----------------------------------------
      0082E1                        592 _init_command_buffer:
      0082E1 52 04            [ 2]  593 	sub	sp, #4
                                    594 ;	main.c: 302: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
      0082E3 5F               [ 1]  595 	clrw	x
      0082E4 1F 03            [ 2]  596 	ldw	(0x03, sp), x
      0082E6                        597 00107$:
      0082E6 1E 03            [ 2]  598 	ldw	x, (0x03, sp)
      0082E8 A3 00 10         [ 2]  599 	cpw	x, #0x0010
      0082EB 2E 2E            [ 1]  600 	jrsge	00109$
                                    601 ;	main.c: 303: command_buffer[i] = malloc(MAX_COMMAND_LENGTH*sizeof(char));
      0082ED 1E 03            [ 2]  602 	ldw	x, (0x03, sp)
      0082EF 58               [ 2]  603 	sllw	x
      0082F0 1C 00 01         [ 2]  604 	addw	x, #(_command_buffer+0)
      0082F3 1F 01            [ 2]  605 	ldw	(0x01, sp), x
      0082F5 4B 12            [ 1]  606 	push	#0x12
      0082F7 4B 00            [ 1]  607 	push	#0x00
      0082F9 CD 85 99         [ 4]  608 	call	_malloc
      0082FC 5B 02            [ 2]  609 	addw	sp, #2
      0082FE 16 01            [ 2]  610 	ldw	y, (0x01, sp)
      008300 90 FF            [ 2]  611 	ldw	(y), x
                                    612 ;	main.c: 304: char* command = command_buffer[i];
      008302 1F 01            [ 2]  613 	ldw	(0x01, sp), x
                                    614 ;	main.c: 305: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
      008304 5F               [ 1]  615 	clrw	x
      008305                        616 00104$:
      008305 A3 00 12         [ 2]  617 	cpw	x, #0x0012
      008308 2E 0A            [ 1]  618 	jrsge	00108$
                                    619 ;	main.c: 306: command[n] = 0;
      00830A 90 93            [ 1]  620 	ldw	y, x
      00830C 72 F9 01         [ 2]  621 	addw	y, (0x01, sp)
      00830F 90 7F            [ 1]  622 	clr	(y)
                                    623 ;	main.c: 305: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
      008311 5C               [ 1]  624 	incw	x
      008312 20 F1            [ 2]  625 	jra	00104$
      008314                        626 00108$:
                                    627 ;	main.c: 302: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
      008314 1E 03            [ 2]  628 	ldw	x, (0x03, sp)
      008316 5C               [ 1]  629 	incw	x
      008317 1F 03            [ 2]  630 	ldw	(0x03, sp), x
      008319 20 CB            [ 2]  631 	jra	00107$
      00831B                        632 00109$:
                                    633 ;	main.c: 309: }
      00831B 5B 04            [ 2]  634 	addw	sp, #4
      00831D 81               [ 4]  635 	ret
                                    636 ;	main.c: 314: get_steps_from_command (const char* cmd) {
                                    637 ;	-----------------------------------------
                                    638 ;	 function get_steps_from_command
                                    639 ;	-----------------------------------------
      00831E                        640 _get_steps_from_command:
      00831E 52 02            [ 2]  641 	sub	sp, #2
                                    642 ;	main.c: 319: if (cmd[1] == '\0') {
      008320 1E 05            [ 2]  643 	ldw	x, (0x05, sp)
      008322 5C               [ 1]  644 	incw	x
      008323 F6               [ 1]  645 	ld	a, (x)
      008324 26 03            [ 1]  646 	jrne	00102$
                                    647 ;	main.c: 320: return 0;
      008326 5F               [ 1]  648 	clrw	x
      008327 20 25            [ 2]  649 	jra	00107$
      008329                        650 00102$:
                                    651 ;	main.c: 323: steps = strtol(cmd + 1, &endptr, 10);
      008329 4B 0A            [ 1]  652 	push	#0x0a
      00832B 4B 00            [ 1]  653 	push	#0x00
      00832D 90 96            [ 1]  654 	ldw	y, sp
      00832F 72 A9 00 03      [ 2]  655 	addw	y, #3
      008333 90 89            [ 2]  656 	pushw	y
      008335 89               [ 2]  657 	pushw	x
      008336 CD 84 A9         [ 4]  658 	call	_strtol
      008339 5B 06            [ 2]  659 	addw	sp, #6
      00833B 51               [ 1]  660 	exgw	x, y
                                    661 ;	main.c: 325: if (endptr == cmd || !(*endptr == '\0' || *endptr == '\n')) {
      00833C 1E 01            [ 2]  662 	ldw	x, (0x01, sp)
      00833E 13 05            [ 2]  663 	cpw	x, (0x05, sp)
      008340 27 09            [ 1]  664 	jreq	00103$
      008342 1E 01            [ 2]  665 	ldw	x, (0x01, sp)
      008344 F6               [ 1]  666 	ld	a, (x)
      008345 27 06            [ 1]  667 	jreq	00104$
      008347 A1 0A            [ 1]  668 	cp	a, #0x0a
      008349 27 02            [ 1]  669 	jreq	00104$
      00834B                        670 00103$:
                                    671 ;	main.c: 326: return 0;
      00834B 5F               [ 1]  672 	clrw	x
                                    673 ;	main.c: 329: return steps;
      00834C 21                     674 	.byte 0x21
      00834D                        675 00104$:
      00834D 93               [ 1]  676 	ldw	x, y
      00834E                        677 00107$:
                                    678 ;	main.c: 330: }
      00834E 5B 02            [ 2]  679 	addw	sp, #2
      008350 81               [ 4]  680 	ret
                                    681 ;	main.c: 335: uart2_write(char *str) {
                                    682 ;	-----------------------------------------
                                    683 ;	 function uart2_write
                                    684 ;	-----------------------------------------
      008351                        685 _uart2_write:
                                    686 ;	main.c: 337: uart_tx_buf = str;
      008351 1E 03            [ 2]  687 	ldw	x, (0x03, sp)
                                    688 ;	main.c: 338: UART2_DR    = uart_tx_buf[0];
      008353 CF 00 A0         [ 2]  689 	ldw	_uart_tx_buf+0, x
      008356 F6               [ 1]  690 	ld	a, (x)
      008357 C7 52 41         [ 1]  691 	ld	0x5241, a
                                    692 ;	main.c: 339: UART2_CR2  |= TIEN;
      00835A C6 52 45         [ 1]  693 	ld	a, 0x5245
      00835D AA 80            [ 1]  694 	or	a, #0x80
      00835F C7 52 45         [ 1]  695 	ld	0x5245, a
                                    696 ;	main.c: 343: while(!uart_tx_done)
      008362                        697 00101$:
      008362 CE 04 B1         [ 2]  698 	ldw	x, _uart_tx_done+0
      008365 26 03            [ 1]  699 	jrne	00103$
                                    700 ;	main.c: 344: __asm__("wfi");
      008367 8F               [10]  701 	wfi
      008368 20 F8            [ 2]  702 	jra	00101$
      00836A                        703 00103$:
                                    704 ;	main.c: 346: UART2_CR2 &= ~TIEN;
      00836A 72 1F 52 45      [ 1]  705 	bres	21061, #7
                                    706 ;	main.c: 348: uart_tx_done = 0;
      00836E 5F               [ 1]  707 	clrw	x
      00836F CF 04 B1         [ 2]  708 	ldw	_uart_tx_done+0, x
                                    709 ;	main.c: 350: return 0;
      008372 5F               [ 1]  710 	clrw	x
                                    711 ;	main.c: 351: }
      008373 81               [ 4]  712 	ret
                                    713 ;	main.c: 356: uart2_init () {
                                    714 ;	-----------------------------------------
                                    715 ;	 function uart2_init
                                    716 ;	-----------------------------------------
      008374                        717 _uart2_init:
                                    718 ;	main.c: 358: UART2_CR2 |= TEN; // Transmitter enable
      008374 72 16 52 45      [ 1]  719 	bset	21061, #3
                                    720 ;	main.c: 359: UART2_CR2 |= REN; // Receiver enable
      008378 72 14 52 45      [ 1]  721 	bset	21061, #2
                                    722 ;	main.c: 361: UART2_CR3 &= ~(STOP_H | STOP_L); // 1 stop bit
      00837C C6 52 46         [ 1]  723 	ld	a, 0x5246
      00837F A4 CF            [ 1]  724 	and	a, #0xcf
      008381 C7 52 46         [ 1]  725 	ld	0x5246, a
                                    726 ;	main.c: 362: UART2_CR1  = 0;
      008384 35 00 52 44      [ 1]  727 	mov	0x5244+0, #0x00
                                    728 ;	main.c: 365: UART2_BRR2 = 0x03;
      008388 35 03 52 43      [ 1]  729 	mov	0x5243+0, #0x03
                                    730 ;	main.c: 366: UART2_BRR1 = 0x68;
      00838C 35 68 52 42      [ 1]  731 	mov	0x5242+0, #0x68
                                    732 ;	main.c: 368: UART2_CR2 |= RIEN;
      008390 C6 52 45         [ 1]  733 	ld	a, 0x5245
      008393 AA 20            [ 1]  734 	or	a, #0x20
      008395 C7 52 45         [ 1]  735 	ld	0x5245, a
                                    736 ;	main.c: 370: init_command_buffer();
                                    737 ;	main.c: 371: }
      008398 CC 82 E1         [ 2]  738 	jp	_init_command_buffer
                                    739 ;	main.c: 377: read_next_command () {
                                    740 ;	-----------------------------------------
                                    741 ;	 function read_next_command
                                    742 ;	-----------------------------------------
      00839B                        743 _read_next_command:
                                    744 ;	main.c: 382: while(command_number == read_index)
      00839B                        745 00101$:
      00839B C6 00 A2         [ 1]  746 	ld	a, _read_next_command_read_index_65536_79+0
      00839E C1 04 B0         [ 1]  747 	cp	a, _command_number+0
      0083A1 26 03            [ 1]  748 	jrne	00103$
                                    749 ;	main.c: 383: __asm__("wfi");
      0083A3 8F               [10]  750 	wfi
      0083A4 20 F5            [ 2]  751 	jra	00101$
      0083A6                        752 00103$:
                                    753 ;	main.c: 386: command = command_buffer[read_index];
      0083A6 5F               [ 1]  754 	clrw	x
      0083A7 C6 00 A2         [ 1]  755 	ld	a, _read_next_command_read_index_65536_79+0
      0083AA 97               [ 1]  756 	ld	xl, a
      0083AB 58               [ 2]  757 	sllw	x
      0083AC DE 00 01         [ 2]  758 	ldw	x, (_command_buffer+0, x)
                                    759 ;	main.c: 388: read_index++;
      0083AF 72 5C 00 A2      [ 1]  760 	inc	_read_next_command_read_index_65536_79+0
                                    761 ;	main.c: 390: if (read_index > (COMMAND_BUFFER_SIZE - 1)) {
      0083B3 C6 00 A2         [ 1]  762 	ld	a, _read_next_command_read_index_65536_79+0
      0083B6 A1 0F            [ 1]  763 	cp	a, #0x0f
      0083B8 22 01            [ 1]  764 	jrugt	00126$
      0083BA 81               [ 4]  765 	ret
      0083BB                        766 00126$:
                                    767 ;	main.c: 391: read_index = 0;
      0083BB 72 5F 00 A2      [ 1]  768 	clr	_read_next_command_read_index_65536_79+0
                                    769 ;	main.c: 394: return command;
                                    770 ;	main.c: 395: }
      0083BF 81               [ 4]  771 	ret
                                    772 ;	main.c: 400: uart2_tx_isr(void) __interrupt(IRQ_UART2_TX) {
                                    773 ;	-----------------------------------------
                                    774 ;	 function uart2_tx_isr
                                    775 ;	-----------------------------------------
      0083C0                        776 _uart2_tx_isr:
                                    777 ;	main.c: 404: UART2_DR = uart_tx_buf[i];
      0083C0 C6 00 A1         [ 1]  778 	ld	a, _uart_tx_buf+1
      0083C3 CB 00 A3         [ 1]  779 	add	a, _uart2_tx_isr_i_65536_82+0
      0083C6 97               [ 1]  780 	ld	xl, a
      0083C7 C6 00 A0         [ 1]  781 	ld	a, _uart_tx_buf+0
      0083CA A9 00            [ 1]  782 	adc	a, #0x00
      0083CC 95               [ 1]  783 	ld	xh, a
      0083CD F6               [ 1]  784 	ld	a, (x)
      0083CE C7 52 41         [ 1]  785 	ld	0x5241, a
                                    786 ;	main.c: 406: if (uart_tx_buf[i] == '\0') {
      0083D1 C6 00 A1         [ 1]  787 	ld	a, _uart_tx_buf+1
      0083D4 CB 00 A3         [ 1]  788 	add	a, _uart2_tx_isr_i_65536_82+0
      0083D7 97               [ 1]  789 	ld	xl, a
      0083D8 C6 00 A0         [ 1]  790 	ld	a, _uart_tx_buf+0
      0083DB A9 00            [ 1]  791 	adc	a, #0x00
      0083DD 95               [ 1]  792 	ld	xh, a
      0083DE F6               [ 1]  793 	ld	a, (x)
      0083DF 26 0C            [ 1]  794 	jrne	00102$
                                    795 ;	main.c: 407: uart_tx_done = 1;
      0083E1 AE 00 01         [ 2]  796 	ldw	x, #0x0001
      0083E4 CF 04 B1         [ 2]  797 	ldw	_uart_tx_done+0, x
                                    798 ;	main.c: 408: i = 1;
      0083E7 35 01 00 A3      [ 1]  799 	mov	_uart2_tx_isr_i_65536_82+0, #0x01
                                    800 ;	main.c: 409: return;
      0083EB 20 04            [ 2]  801 	jra	00103$
      0083ED                        802 00102$:
                                    803 ;	main.c: 412: i++;
      0083ED 72 5C 00 A3      [ 1]  804 	inc	_uart2_tx_isr_i_65536_82+0
      0083F1                        805 00103$:
                                    806 ;	main.c: 413: }
      0083F1 80               [11]  807 	iret
                                    808 ;	main.c: 418: uart2_rx_isr(void) __interrupt(IRQ_UART2_RX) {
                                    809 ;	-----------------------------------------
                                    810 ;	 function uart2_rx_isr
                                    811 ;	-----------------------------------------
      0083F2                        812 _uart2_rx_isr:
      0083F2 52 02            [ 2]  813 	sub	sp, #2
                                    814 ;	main.c: 424: command = command_buffer[command_number];
      0083F4 C6 04 B0         [ 1]  815 	ld	a, _command_number+0
      0083F7 5F               [ 1]  816 	clrw	x
      0083F8 97               [ 1]  817 	ld	xl, a
      0083F9 58               [ 2]  818 	sllw	x
      0083FA DE 00 01         [ 2]  819 	ldw	x, (_command_buffer+0, x)
      0083FD 1F 01            [ 2]  820 	ldw	(0x01, sp), x
                                    821 ;	main.c: 428: command[byte_index] = UART2_DR;
      0083FF 5F               [ 1]  822 	clrw	x
      008400 C6 00 A4         [ 1]  823 	ld	a, _uart2_rx_isr_byte_index_65536_85+0
      008403 97               [ 1]  824 	ld	xl, a
      008404 72 FB 01         [ 2]  825 	addw	x, (0x01, sp)
      008407 C6 52 41         [ 1]  826 	ld	a, 0x5241
      00840A F7               [ 1]  827 	ld	(x), a
                                    828 ;	main.c: 430: if (command[byte_index] == '\n') {
      00840B 5F               [ 1]  829 	clrw	x
      00840C C6 00 A4         [ 1]  830 	ld	a, _uart2_rx_isr_byte_index_65536_85+0
      00840F 97               [ 1]  831 	ld	xl, a
      008410 72 FB 01         [ 2]  832 	addw	x, (0x01, sp)
      008413 F6               [ 1]  833 	ld	a, (x)
      008414 A1 0A            [ 1]  834 	cp	a, #0x0a
      008416 26 15            [ 1]  835 	jrne	00104$
                                    836 ;	main.c: 432: byte_index = 0;
      008418 72 5F 00 A4      [ 1]  837 	clr	_uart2_rx_isr_byte_index_65536_85+0
                                    838 ;	main.c: 434: command_number++;
      00841C 72 5C 04 B0      [ 1]  839 	inc	_command_number+0
                                    840 ;	main.c: 436: if (command_number > (COMMAND_BUFFER_SIZE - 1)) {
      008420 C6 04 B0         [ 1]  841 	ld	a, _command_number+0
      008423 A1 0F            [ 1]  842 	cp	a, #0x0f
      008425 23 15            [ 2]  843 	jrule	00107$
                                    844 ;	main.c: 437: command_number = 0;
      008427 72 5F 04 B0      [ 1]  845 	clr	_command_number+0
                                    846 ;	main.c: 440: return;
      00842B 20 0F            [ 2]  847 	jra	00107$
      00842D                        848 00104$:
                                    849 ;	main.c: 443: byte_index++;
      00842D 72 5C 00 A4      [ 1]  850 	inc	_uart2_rx_isr_byte_index_65536_85+0
                                    851 ;	main.c: 445: if (byte_index > (MAX_COMMAND_LENGTH - 1))
      008431 C6 00 A4         [ 1]  852 	ld	a, _uart2_rx_isr_byte_index_65536_85+0
      008434 A1 11            [ 1]  853 	cp	a, #0x11
      008436 23 04            [ 2]  854 	jrule	00107$
                                    855 ;	main.c: 446: byte_index = 0;
      008438 72 5F 00 A4      [ 1]  856 	clr	_uart2_rx_isr_byte_index_65536_85+0
      00843C                        857 00107$:
                                    858 ;	main.c: 447: }
      00843C 5B 02            [ 2]  859 	addw	sp, #2
      00843E 80               [11]  860 	iret
                                    861 ;	main.c: 450: void hsi_configure () {
                                    862 ;	-----------------------------------------
                                    863 ;	 function hsi_configure
                                    864 ;	-----------------------------------------
      00843F                        865 _hsi_configure:
                                    866 ;	main.c: 451: while ((CLK_ICKR & BIT1) == 0); // HSRDY
      00843F                        867 00101$:
      00843F C6 50 C0         [ 1]  868 	ld	a, 0x50c0
      008442 A5 02            [ 1]  869 	bcp	a, #0x02
      008444 27 F9            [ 1]  870 	jreq	00101$
                                    871 ;	main.c: 453: while((CLK_SWCR & BIT0));
      008446                        872 00104$:
      008446 C6 50 C5         [ 1]  873 	ld	a, 0x50c5
      008449 44               [ 1]  874 	srl	a
      00844A 25 FA            [ 1]  875 	jrc	00104$
                                    876 ;	main.c: 454: CLK_SWR    = 0xE1; // select HSI for Master CLK
      00844C 35 E1 50 C4      [ 1]  877 	mov	0x50c4+0, #0xe1
                                    878 ;	main.c: 455: CLK_CKDIVR = 0;
      008450 35 00 50 C6      [ 1]  879 	mov	0x50c6+0, #0x00
                                    880 ;	main.c: 457: while((CLK_SWCR & BIT0));
      008454                        881 00107$:
      008454 C6 50 C5         [ 1]  882 	ld	a, 0x50c5
      008457 44               [ 1]  883 	srl	a
      008458 25 FA            [ 1]  884 	jrc	00107$
                                    885 ;	main.c: 458: CLK_SWCR |= BIT1;
      00845A 72 12 50 C5      [ 1]  886 	bset	20677, #1
                                    887 ;	main.c: 459: while((CLK_SWCR & BIT0));
      00845E                        888 00110$:
      00845E C6 50 C5         [ 1]  889 	ld	a, 0x50c5
      008461 44               [ 1]  890 	srl	a
      008462 25 FA            [ 1]  891 	jrc	00110$
                                    892 ;	main.c: 460: CLK_SWCR &= ~BIT1;
      008464 72 13 50 C5      [ 1]  893 	bres	20677, #1
                                    894 ;	main.c: 461: }
      008468 81               [ 4]  895 	ret
                                    896 ;	main.c: 463: void clk_out_enable() {
                                    897 ;	-----------------------------------------
                                    898 ;	 function clk_out_enable
                                    899 ;	-----------------------------------------
      008469                        900 _clk_out_enable:
                                    901 ;	main.c: 465: PD_DDR |= BIT0;
      008469 72 10 50 11      [ 1]  902 	bset	20497, #0
                                    903 ;	main.c: 467: PD_CR1 |= BIT0;
      00846D 72 10 50 12      [ 1]  904 	bset	20498, #0
                                    905 ;	main.c: 468: PD_CR2 |= BIT0;
      008471 72 10 50 13      [ 1]  906 	bset	20499, #0
                                    907 ;	main.c: 470: CLK_CCOR |= (BIT0 | (0b1011 << 1));
      008475 C6 50 C9         [ 1]  908 	ld	a, 0x50c9
      008478 AA 17            [ 1]  909 	or	a, #0x17
      00847A C7 50 C9         [ 1]  910 	ld	0x50c9, a
                                    911 ;	main.c: 471: }
      00847D 81               [ 4]  912 	ret
                                    913 ;	main.c: 474: void opt_write() {
                                    914 ;	-----------------------------------------
                                    915 ;	 function opt_write
                                    916 ;	-----------------------------------------
      00847E                        917 _opt_write:
                                    918 ;	main.c: 482: FLASH_DUKR = FLASH_DUKR_KEY1;
      00847E 35 AE 50 64      [ 1]  919 	mov	0x5064+0, #0xae
                                    920 ;	main.c: 483: FLASH_DUKR = FLASH_DUKR_KEY2;
      008482 35 56 50 64      [ 1]  921 	mov	0x5064+0, #0x56
                                    922 ;	main.c: 484: while (!(FLASH_IAPSR & BIT3));
      008486                        923 00101$:
      008486 C6 50 5F         [ 1]  924 	ld	a, 0x505f
      008489 A5 08            [ 1]  925 	bcp	a, #0x08
      00848B 27 F9            [ 1]  926 	jreq	00101$
                                    927 ;	main.c: 486: FLASH_CR2 |= BIT7;
      00848D 72 1E 50 5B      [ 1]  928 	bset	20571, #7
                                    929 ;	main.c: 487: FLASH_NCR2 &= ~BIT7;
      008491 72 1F 50 5C      [ 1]  930 	bres	20572, #7
                                    931 ;	main.c: 490: *((uint8_t*) 0x4803) = opt0;
      008495 35 24 48 03      [ 1]  932 	mov	0x4803+0, #0x24
                                    933 ;	main.c: 491: *((uint8_t*) 0x4804) = ~opt0;
      008499 35 DB 48 04      [ 1]  934 	mov	0x4804+0, #0xdb
                                    935 ;	main.c: 494: while (!(FLASH_IAPSR & BIT2));
      00849D                        936 00104$:
      00849D C6 50 5F         [ 1]  937 	ld	a, 0x505f
      0084A0 A5 04            [ 1]  938 	bcp	a, #0x04
      0084A2 27 F9            [ 1]  939 	jreq	00104$
                                    940 ;	main.c: 496: FLASH_IAPSR &= ~BIT3;
      0084A4 72 17 50 5F      [ 1]  941 	bres	20575, #3
                                    942 ;	main.c: 497: }
      0084A8 81               [ 4]  943 	ret
                                    944 	.area CODE
                                    945 	.area CONST
                                    946 	.area CONST
      00808F                        947 ___str_0:
      00808F 65                     948 	.ascii "e"
      008090 0A                     949 	.db 0x0a
      008091 00                     950 	.db 0x00
                                    951 	.area CODE
                                    952 	.area INITIALIZER
      008098                        953 __xinit__target_steps:
      008098 00 00                  954 	.dw #0x0000
      00809A                        955 __xinit__stepping_done:
      00809A 00                     956 	.db #0x00	; 0
      00809B                        957 __xinit__current_pos_azm:
      00809B 00 00                  958 	.dw #0x0000
      00809D                        959 __xinit__current_pos_elv:
      00809D FF C3                  960 	.dw #0xffc3
      00809F                        961 __xinit__command_number:
      00809F 00                     962 	.db #0x00	; 0
      0080A0                        963 __xinit__uart_tx_done:
      0080A0 00 00                  964 	.dw #0x0000
                                    965 	.area CABS (ABS)
