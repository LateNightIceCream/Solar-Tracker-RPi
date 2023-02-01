                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.1.0 #12072 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module stepper
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _port_c_isr
                                     12 	.globl _timer_isr
                                     13 	.globl __home_elv
                                     14 	.globl _stepper_init
                                     15 	.globl _home_azm
                                     16 	.globl _turn_steps_azm
                                     17 	.globl _turn_steps_elv
                                     18 ;--------------------------------------------------------
                                     19 ; ram data
                                     20 ;--------------------------------------------------------
                                     21 	.area DATA
                                     22 ;--------------------------------------------------------
                                     23 ; ram data
                                     24 ;--------------------------------------------------------
                                     25 	.area INITIALIZED
      0004A9                         26 _target_steps:
      0004A9                         27 	.ds 2
      0004AB                         28 _stepping_done:
      0004AB                         29 	.ds 1
      0004AC                         30 _current_pos_azm:
      0004AC                         31 	.ds 2
                                     32 ;--------------------------------------------------------
                                     33 ; absolute external ram data
                                     34 ;--------------------------------------------------------
                                     35 	.area DABS (ABS)
                                     36 
                                     37 ; default segment ordering for linker
                                     38 	.area HOME
                                     39 	.area GSINIT
                                     40 	.area GSFINAL
                                     41 	.area CONST
                                     42 	.area INITIALIZER
                                     43 	.area CODE
                                     44 
                                     45 ;--------------------------------------------------------
                                     46 ; global & static initialisations
                                     47 ;--------------------------------------------------------
                                     48 	.area HOME
                                     49 	.area GSINIT
                                     50 	.area GSFINAL
                                     51 	.area GSINIT
                                     52 ;--------------------------------------------------------
                                     53 ; Home
                                     54 ;--------------------------------------------------------
                                     55 	.area HOME
                                     56 	.area HOME
                                     57 ;--------------------------------------------------------
                                     58 ; code
                                     59 ;--------------------------------------------------------
                                     60 	.area CODE
                                     61 ;	src/stepper/stepper.c: 11: stepper_init () {
                                     62 ;	-----------------------------------------
                                     63 ;	 function stepper_init
                                     64 ;	-----------------------------------------
      008122                         65 _stepper_init:
                                     66 ;	src/stepper/stepper.c: 12: timer_init();
      008122 CD 81 BE         [ 4]   67 	call	_timer_init
                                     68 ;	src/stepper/stepper.c: 13: home_azm();
                                     69 ;	src/stepper/stepper.c: 14: }
      008125 CC 81 28         [ 2]   70 	jp	_home_azm
                                     71 ;	src/stepper/stepper.c: 18: void home_azm () {
                                     72 ;	-----------------------------------------
                                     73 ;	 function home_azm
                                     74 ;	-----------------------------------------
      008128                         75 _home_azm:
                                     76 ;	src/stepper/stepper.c: 20: turn_steps_azm(-6400);
      008128 4B 00            [ 1]   77 	push	#0x00
      00812A 4B E7            [ 1]   78 	push	#0xe7
      00812C CD 81 3C         [ 4]   79 	call	_turn_steps_azm
      00812F 5B 02            [ 2]   80 	addw	sp, #2
                                     81 ;	src/stepper/stepper.c: 21: }
      008131 81               [ 4]   82 	ret
                                     83 ;	src/stepper/stepper.c: 23: void _home_elv () {
                                     84 ;	-----------------------------------------
                                     85 ;	 function _home_elv
                                     86 ;	-----------------------------------------
      008132                         87 __home_elv:
                                     88 ;	src/stepper/stepper.c: 24: turn_steps_elv(-6400);
      008132 4B 00            [ 1]   89 	push	#0x00
      008134 4B E7            [ 1]   90 	push	#0xe7
      008136 CD 81 7E         [ 4]   91 	call	_turn_steps_elv
      008139 5B 02            [ 2]   92 	addw	sp, #2
                                     93 ;	src/stepper/stepper.c: 25: }
      00813B 81               [ 4]   94 	ret
                                     95 ;	src/stepper/stepper.c: 30: turn_steps_azm (int16_t steps) {
                                     96 ;	-----------------------------------------
                                     97 ;	 function turn_steps_azm
                                     98 ;	-----------------------------------------
      00813C                         99 _turn_steps_azm:
                                    100 ;	src/stepper/stepper.c: 32: if (steps < 0) {
      00813C 1E 03            [ 2]  101 	ldw	x, (0x03, sp)
      00813E 2A 13            [ 1]  102 	jrpl	00104$
                                    103 ;	src/stepper/stepper.c: 34: if (AZM_LIMIT_PUSHED) {
      008140 C6 50 0B         [ 1]  104 	ld	a, 0x500b
      008143 A5 10            [ 1]  105 	bcp	a, #0x10
      008145 27 01            [ 1]  106 	jreq	00102$
                                    107 ;	src/stepper/stepper.c: 35: return;
      008147 81               [ 4]  108 	ret
      008148                        109 00102$:
                                    110 ;	src/stepper/stepper.c: 38: AZM_SET_DIR_HOME;
      008148 72 13 50 0A      [ 1]  111 	bres	20490, #1
                                    112 ;	src/stepper/stepper.c: 39: steps = -steps;
      00814C 1E 03            [ 2]  113 	ldw	x, (0x03, sp)
      00814E 50               [ 2]  114 	negw	x
      00814F 1F 03            [ 2]  115 	ldw	(0x03, sp), x
      008151 20 04            [ 2]  116 	jra	00105$
      008153                        117 00104$:
                                    118 ;	src/stepper/stepper.c: 42: AZM_SET_DIR_SPA;
      008153 72 12 50 0A      [ 1]  119 	bset	20490, #1
      008157                        120 00105$:
                                    121 ;	src/stepper/stepper.c: 45: ELV_STEP_DISABLE;
      008157 72 1D 52 5C      [ 1]  122 	bres	21084, #6
                                    123 ;	src/stepper/stepper.c: 46: AZM_STEP_ENABLE;
      00815B 72 14 52 5C      [ 1]  124 	bset	21084, #2
                                    125 ;	src/stepper/stepper.c: 48: stepping_done = 0;
      00815F 72 5F 04 AB      [ 1]  126 	clr	_stepping_done+0
                                    127 ;	src/stepper/stepper.c: 50: target_steps = steps;
      008163 1E 03            [ 2]  128 	ldw	x, (0x03, sp)
      008165 CF 04 A9         [ 2]  129 	ldw	_target_steps+0, x
                                    130 ;	src/stepper/stepper.c: 51: TIM1_CR1 |= CEN;
      008168 C6 52 50         [ 1]  131 	ld	a, 0x5250
      00816B AA 01            [ 1]  132 	or	a, #0x01
      00816D C7 52 50         [ 1]  133 	ld	0x5250, a
                                    134 ;	src/stepper/stepper.c: 53: while(!stepping_done)
      008170                        135 00106$:
      008170 72 5D 04 AB      [ 1]  136 	tnz	_stepping_done+0
      008174 26 03            [ 1]  137 	jrne	00108$
                                    138 ;	src/stepper/stepper.c: 54: __asm__("wfi");
      008176 8F               [10]  139 	wfi
      008177 20 F7            [ 2]  140 	jra	00106$
      008179                        141 00108$:
                                    142 ;	src/stepper/stepper.c: 56: AZM_STEP_DISABLE;
      008179 72 15 52 5C      [ 1]  143 	bres	21084, #2
                                    144 ;	src/stepper/stepper.c: 57: }
      00817D 81               [ 4]  145 	ret
                                    146 ;	src/stepper/stepper.c: 60: turn_steps_elv (int16_t steps) {
                                    147 ;	-----------------------------------------
                                    148 ;	 function turn_steps_elv
                                    149 ;	-----------------------------------------
      00817E                        150 _turn_steps_elv:
                                    151 ;	src/stepper/stepper.c: 62: if (steps < 0) {
      00817E 1E 03            [ 2]  152 	ldw	x, (0x03, sp)
                                    153 ;	src/stepper/stepper.c: 63: ELV_SET_DIR_HOME;
      008180 C6 50 0A         [ 1]  154 	ld	a, 0x500a
                                    155 ;	src/stepper/stepper.c: 62: if (steps < 0) {
      008183 5D               [ 2]  156 	tnzw	x
      008184 2A 0C            [ 1]  157 	jrpl	00102$
                                    158 ;	src/stepper/stepper.c: 63: ELV_SET_DIR_HOME;
      008186 A4 FB            [ 1]  159 	and	a, #0xfb
      008188 C7 50 0A         [ 1]  160 	ld	0x500a, a
                                    161 ;	src/stepper/stepper.c: 64: steps = -steps;
      00818B 1E 03            [ 2]  162 	ldw	x, (0x03, sp)
      00818D 50               [ 2]  163 	negw	x
      00818E 1F 03            [ 2]  164 	ldw	(0x03, sp), x
      008190 20 05            [ 2]  165 	jra	00103$
      008192                        166 00102$:
                                    167 ;	src/stepper/stepper.c: 67: ELV_SET_DIR_SPA;
      008192 AA 04            [ 1]  168 	or	a, #0x04
      008194 C7 50 0A         [ 1]  169 	ld	0x500a, a
      008197                        170 00103$:
                                    171 ;	src/stepper/stepper.c: 70: AZM_STEP_DISABLE;
      008197 72 15 52 5C      [ 1]  172 	bres	21084, #2
                                    173 ;	src/stepper/stepper.c: 71: ELV_STEP_ENABLE;
      00819B 72 1C 52 5C      [ 1]  174 	bset	21084, #6
                                    175 ;	src/stepper/stepper.c: 73: stepping_done = 0;
      00819F 72 5F 04 AB      [ 1]  176 	clr	_stepping_done+0
                                    177 ;	src/stepper/stepper.c: 75: target_steps = steps;
      0081A3 1E 03            [ 2]  178 	ldw	x, (0x03, sp)
      0081A5 CF 04 A9         [ 2]  179 	ldw	_target_steps+0, x
                                    180 ;	src/stepper/stepper.c: 76: TIM1_CR1 |= CEN;
      0081A8 C6 52 50         [ 1]  181 	ld	a, 0x5250
      0081AB AA 01            [ 1]  182 	or	a, #0x01
      0081AD C7 52 50         [ 1]  183 	ld	0x5250, a
                                    184 ;	src/stepper/stepper.c: 78: while(!stepping_done)
      0081B0                        185 00104$:
      0081B0 72 5D 04 AB      [ 1]  186 	tnz	_stepping_done+0
      0081B4 26 03            [ 1]  187 	jrne	00106$
                                    188 ;	src/stepper/stepper.c: 79: __asm__("wfi");
      0081B6 8F               [10]  189 	wfi
      0081B7 20 F7            [ 2]  190 	jra	00104$
      0081B9                        191 00106$:
                                    192 ;	src/stepper/stepper.c: 81: ELV_STEP_DISABLE;
      0081B9 72 1D 52 5C      [ 1]  193 	bres	21084, #6
                                    194 ;	src/stepper/stepper.c: 82: }
      0081BD 81               [ 4]  195 	ret
                                    196 ;	src/stepper/stepper.c: 87: timer_init () {
                                    197 ;	-----------------------------------------
                                    198 ;	 function timer_init
                                    199 ;	-----------------------------------------
      0081BE                        200 _timer_init:
                                    201 ;	src/stepper/stepper.c: 88: TIM1_CR1 &= ~CEN; // disable timer
      0081BE 72 11 52 50      [ 1]  202 	bres	21072, #0
                                    203 ;	src/stepper/stepper.c: 89: TIM1_IER &= ~UIE;
      0081C2 72 11 52 54      [ 1]  204 	bres	21076, #0
                                    205 ;	src/stepper/stepper.c: 91: TIM1_PSCRH = 0x00;
      0081C6 35 00 52 60      [ 1]  206 	mov	0x5260+0, #0x00
                                    207 ;	src/stepper/stepper.c: 92: TIM1_PSCRL = 0x5F;
      0081CA 35 5F 52 61      [ 1]  208 	mov	0x5261+0, #0x5f
                                    209 ;	src/stepper/stepper.c: 94: TIM1_CR1 |= ARPE;
      0081CE 72 1E 52 50      [ 1]  210 	bset	21072, #7
                                    211 ;	src/stepper/stepper.c: 95: TIM1_ARRH = 0x00;
      0081D2 35 00 52 62      [ 1]  212 	mov	0x5262+0, #0x00
                                    213 ;	src/stepper/stepper.c: 96: TIM1_ARRL = 0xff;
      0081D6 35 FF 52 63      [ 1]  214 	mov	0x5263+0, #0xff
                                    215 ;	src/stepper/stepper.c: 98: TIM1_CCR1H  = 0x00; // CCRx determines duty cycle
      0081DA 35 00 52 65      [ 1]  216 	mov	0x5265+0, #0x00
                                    217 ;	src/stepper/stepper.c: 99: TIM1_CCR1L  = 0x80;
      0081DE 35 80 52 66      [ 1]  218 	mov	0x5266+0, #0x80
                                    219 ;	src/stepper/stepper.c: 101: TIM1_CCR2H  = 0x00; // CCRx determines duty cycle
      0081E2 35 00 52 67      [ 1]  220 	mov	0x5267+0, #0x00
                                    221 ;	src/stepper/stepper.c: 102: TIM1_CCR2L  = 0x80;
      0081E6 35 80 52 68      [ 1]  222 	mov	0x5268+0, #0x80
                                    223 ;	src/stepper/stepper.c: 104: TIM1_CCMR1 &= ~(CC1S_H | CC1S_L); // Output mode
      0081EA C6 52 58         [ 1]  224 	ld	a, 0x5258
      0081ED A4 FC            [ 1]  225 	and	a, #0xfc
      0081EF C7 52 58         [ 1]  226 	ld	0x5258, a
                                    227 ;	src/stepper/stepper.c: 105: TIM1_CCMR2 &= ~(CC1S_H | CC1S_L); // Output mode
      0081F2 C6 52 59         [ 1]  228 	ld	a, 0x5259
      0081F5 A4 FC            [ 1]  229 	and	a, #0xfc
      0081F7 C7 52 59         [ 1]  230 	ld	0x5259, a
                                    231 ;	src/stepper/stepper.c: 107: TIM1_CCMR1 |= OCM1_PWM2; /* PWM mode 2 */
      0081FA C6 52 58         [ 1]  232 	ld	a, 0x5258
      0081FD AA 70            [ 1]  233 	or	a, #0x70
      0081FF C7 52 58         [ 1]  234 	ld	0x5258, a
                                    235 ;	src/stepper/stepper.c: 108: TIM1_CCMR2 |= OCM1_PWM2;
      008202 C6 52 59         [ 1]  236 	ld	a, 0x5259
      008205 AA 70            [ 1]  237 	or	a, #0x70
      008207 C7 52 59         [ 1]  238 	ld	0x5259, a
                                    239 ;	src/stepper/stepper.c: 110: TIM1_CCER1 |= CC1NE | CC2NE; /* output enable */
      00820A C6 52 5C         [ 1]  240 	ld	a, 0x525c
      00820D AA 44            [ 1]  241 	or	a, #0x44
      00820F C7 52 5C         [ 1]  242 	ld	0x525c, a
                                    243 ;	src/stepper/stepper.c: 112: TIM1_BKR  = MOE; // automatic output enable
      008212 35 80 52 6D      [ 1]  244 	mov	0x526d+0, #0x80
                                    245 ;	src/stepper/stepper.c: 113: TIM1_IER |= UIE;
      008216 72 10 52 54      [ 1]  246 	bset	21076, #0
                                    247 ;	src/stepper/stepper.c: 114: }
      00821A 81               [ 4]  248 	ret
                                    249 ;	src/stepper/stepper.c: 119: timer_isr(void) __interrupt(IRQ_TIM1) {
                                    250 ;	-----------------------------------------
                                    251 ;	 function timer_isr
                                    252 ;	-----------------------------------------
      00821B                        253 _timer_isr:
                                    254 ;	src/stepper/stepper.c: 121: if (target_steps == 0) {
      00821B CE 04 A9         [ 2]  255 	ldw	x, _target_steps+0
      00821E 26 08            [ 1]  256 	jrne	00102$
                                    257 ;	src/stepper/stepper.c: 122: TIM1_CR1 &= ~CEN;
      008220 72 11 52 50      [ 1]  258 	bres	21072, #0
                                    259 ;	src/stepper/stepper.c: 123: stepping_done = 1;
      008224 35 01 04 AB      [ 1]  260 	mov	_stepping_done+0, #0x01
      008228                        261 00102$:
                                    262 ;	src/stepper/stepper.c: 126: target_steps--;
      008228 CE 04 A9         [ 2]  263 	ldw	x, _target_steps+0
      00822B 5A               [ 2]  264 	decw	x
      00822C CF 04 A9         [ 2]  265 	ldw	_target_steps+0, x
                                    266 ;	src/stepper/stepper.c: 128: TIM1_SR1 &= ~UIF;
      00822F 72 11 52 55      [ 1]  267 	bres	21077, #0
                                    268 ;	src/stepper/stepper.c: 129: }
      008233 80               [11]  269 	iret
                                    270 ;	src/stepper/stepper.c: 133: port_c_isr(void) __interrupt(IRQ_EXTI2) {
                                    271 ;	-----------------------------------------
                                    272 ;	 function port_c_isr
                                    273 ;	-----------------------------------------
      008234                        274 _port_c_isr:
                                    275 ;	src/stepper/stepper.c: 134: if (AZM_LIMIT_PUSHED) {
      008234 C6 50 0B         [ 1]  276 	ld	a, 0x500b
      008237 A5 10            [ 1]  277 	bcp	a, #0x10
      008239 27 10            [ 1]  278 	jreq	00103$
                                    279 ;	src/stepper/stepper.c: 135: current_pos_azm  = ZERO_POSITION_AZM;
      00823B 5F               [ 1]  280 	clrw	x
      00823C CF 04 AC         [ 2]  281 	ldw	_current_pos_azm+0, x
                                    282 ;	src/stepper/stepper.c: 136: target_steps = 0;
      00823F 5F               [ 1]  283 	clrw	x
      008240 CF 04 A9         [ 2]  284 	ldw	_target_steps+0, x
                                    285 ;	src/stepper/stepper.c: 137: stepping_done = 1;
      008243 35 01 04 AB      [ 1]  286 	mov	_stepping_done+0, #0x01
                                    287 ;	src/stepper/stepper.c: 138: TIM1_CR1 &= ~CEN;
      008247 72 11 52 50      [ 1]  288 	bres	21072, #0
      00824B                        289 00103$:
                                    290 ;	src/stepper/stepper.c: 140: }
      00824B 80               [11]  291 	iret
                                    292 	.area CODE
                                    293 	.area CONST
                                    294 	.area INITIALIZER
      00803C                        295 __xinit__target_steps:
      00803C 00 00                  296 	.dw #0x0000
      00803E                        297 __xinit__stepping_done:
      00803E 00                     298 	.db #0x00	; 0
      00803F                        299 __xinit__current_pos_azm:
      00803F 00 00                  300 	.dw #0x0000
                                    301 	.area CABS (ABS)
