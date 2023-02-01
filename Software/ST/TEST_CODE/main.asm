;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module main
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uart2_rx_isr
	.globl _uart2_tx_isr
	.globl _port_c_isr
	.globl _timer_isr
	.globl _main
	.globl _malloc
	.globl _strtol
	.globl _port_init
	.globl _stepper_init
	.globl _home_azm
	.globl _home_elv
	.globl _turn_steps_azm
	.globl _turn_steps_elv
	.globl _init_command_buffer
	.globl _get_steps_from_command
	.globl _uart2_write
	.globl _uart2_init
	.globl _read_next_command
	.globl _hsi_configure
	.globl _clk_out_enable
	.globl _opt_write
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_command_buffer:
	.ds 32
_uart_rx_buf:
	.ds 127
_uart_tx_buf:
	.ds 2
_read_next_command_read_index_65536_79:
	.ds 1
_uart2_tx_isr_i_65536_82:
	.ds 1
_uart2_rx_isr_byte_index_65536_85:
	.ds 1
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
_current_pos_elv:
	.ds 2
_command_number:
	.ds 1
_uart_tx_done:
	.ds 2
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

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
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ; reset
	int 0x000000 ; trap
	int 0x000000 ; int0
	int 0x000000 ; int1
	int 0x000000 ; int2
	int 0x000000 ; int3
	int 0x000000 ; int4
	int _port_c_isr ; int5
	int 0x000000 ; int6
	int 0x000000 ; int7
	int 0x000000 ; int8
	int 0x000000 ; int9
	int 0x000000 ; int10
	int _timer_isr ; int11
	int 0x000000 ; int12
	int 0x000000 ; int13
	int 0x000000 ; int14
	int 0x000000 ; int15
	int 0x000000 ; int16
	int 0x000000 ; int17
	int 0x000000 ; int18
	int 0x000000 ; int19
	int _uart2_tx_isr ; int20
	int _uart2_rx_isr ; int21
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
;	main.c: 379: static uint8_t read_index = 0; // reading position in command_buffer
	clr	_read_next_command_read_index_65536_79+0
;	main.c: 402: static uint8_t i = 1;
	mov	_uart2_tx_isr_i_65536_82+0, #0x01
;	main.c: 421: static uint8_t byte_index = 0;
	clr	_uart2_rx_isr_byte_index_65536_85+0
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	main.c: 18: void main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #2
;	main.c: 19: __asm__("rim");
	rim
;	main.c: 22: hsi_configure(); // hse currently doesnt work
	call	_hsi_configure
;	main.c: 23: port_init();
	call	_port_init
;	main.c: 24: stepper_init();
	call	_stepper_init
;	main.c: 25: uart2_init();
	call	_uart2_init
;	main.c: 28: while (1) {
00120$:
;	main.c: 30: command = read_next_command();
	call	_read_next_command
;	main.c: 35: switch (command[0]) {
	ldw	(0x01, sp), x
	ld	a, (x)
	cp	a, #0x61
	jreq	00101$
	cp	a, #0x65
	jreq	00104$
	cp	a, #0x68
	jreq	00108$
	cp	a, #0x70
	jreq	00107$
	jra	00118$
;	main.c: 37: case 'a': // azimuth
00101$:
;	main.c: 39: steps = get_steps_from_command(command);
	ldw	x, (0x01, sp)
	pushw	x
	call	_get_steps_from_command
	addw	sp, #2
;	main.c: 41: if (steps == 0)
	tnzw	x
	jreq	00118$
;	main.c: 44: turn_steps_azm(steps);
	pushw	x
	call	_turn_steps_azm
	addw	sp, #2
;	main.c: 46: break;
	jra	00118$
;	main.c: 48: case 'e': // elevation
00104$:
;	main.c: 50: steps = get_steps_from_command(command);
	ldw	x, (0x01, sp)
	pushw	x
	call	_get_steps_from_command
	addw	sp, #2
;	main.c: 52: if (steps == 0)
	tnzw	x
	jreq	00118$
;	main.c: 55: turn_steps_elv(steps);
	pushw	x
	call	_turn_steps_elv
	addw	sp, #2
;	main.c: 57: break;
	jra	00118$
;	main.c: 59: case 'p': // ping
00107$:
;	main.c: 60: uart2_write("e\n");
	push	#<(___str_0+0)
	push	#((___str_0+0) >> 8)
	call	_uart2_write
	addw	sp, #2
;	main.c: 61: break;
	jra	00118$
;	main.c: 63: case 'h':
00108$:
;	main.c: 64: if (command[1] == '\n' || command[1] == '\0') {
	ldw	x, (0x01, sp)
	ld	a, (0x1, x)
	cp	a, #0x0a
	jreq	00118$
	tnz	a
	jreq	00118$
;	main.c: 68: if (command[1] == 'a') {
	cp	a, #0x61
	jrne	00115$
;	main.c: 69: home_azm();
	call	_home_azm
	jra	00118$
00115$:
;	main.c: 71: else if ( command[1] == 'e'){
	cp	a, #0x65
	jrne	00118$
;	main.c: 72: home_elv();
	call	_home_elv
;	main.c: 79: }
00118$:
;	main.c: 80: uart2_write(command);
	ldw	x, (0x01, sp)
	pushw	x
	call	_uart2_write
	addw	sp, #2
;	main.c: 82: }
	jra	00120$
;	main.c: 84: void port_init () {
;	-----------------------------------------
;	 function port_init
;	-----------------------------------------
_port_init:
;	main.c: 86: PC_DDR |= (BIT3);
	bset	20492, #3
;	main.c: 87: PC_CR1 |= (BIT3);
	bset	20493, #3
;	main.c: 88: PC_CR2 &= ~(BIT3);
	bres	20494, #3
;	main.c: 89: PC_ODR |= BIT3; // HIGH Output reset and sleep
	bset	20490, #3
;	main.c: 91: PB_DDR &= ~BIT2; // has to be set as input bc of a short to ground on the board
	bres	20487, #2
;	main.c: 93: STEPPER_AZM_STP_DDR |= STEPPER_AZM_STP_BIT;
	bset	20487, #0
;	main.c: 94: STEPPER_AZM_STP_CR1 |= STEPPER_AZM_STP_BIT;
	bset	20488, #0
;	main.c: 95: STEPPER_AZM_STP_CR2 &=~STEPPER_AZM_STP_BIT;
	bres	20489, #0
;	main.c: 97: STEPPER_ELV_STP_DDR |= STEPPER_ELV_STP_BIT;
	bset	20487, #4
;	main.c: 98: STEPPER_ELV_STP_CR1 |= STEPPER_ELV_STP_BIT;
	bset	20488, #4
;	main.c: 99: STEPPER_ELV_STP_CR2 &=~STEPPER_ELV_STP_BIT;
	bres	20489, #4
;	main.c: 101: STEPPER_AZM_DIR_DDR |= STEPPER_AZM_DIR_BIT;
	bset	20492, #1
;	main.c: 102: STEPPER_AZM_DIR_CR1 |= STEPPER_AZM_DIR_BIT;
	bset	20493, #1
;	main.c: 103: STEPPER_AZM_DIR_CR2 &=~STEPPER_AZM_DIR_BIT;
	bres	20494, #1
;	main.c: 105: STEPPER_ELV_DIR_DDR |= STEPPER_ELV_DIR_BIT;
	bset	20492, #2
;	main.c: 106: STEPPER_ELV_DIR_CR1 |= STEPPER_ELV_DIR_BIT;
	bset	20493, #2
;	main.c: 107: STEPPER_ELV_DIR_CR2 &=~STEPPER_ELV_DIR_BIT;
	ld	a, 0x500e
	and	a, #0xfb
	ld	0x500e, a
;	main.c: 109: __asm__("sim");
	sim
;	main.c: 110: EXTI_CR1 |= PCIS_L; // 01 into PCIS bits --> rising edge interrupt
	ld	a, 0x50a0
	or	a, #0x10
	ld	0x50a0, a
;	main.c: 111: EXTI_CR1 &=~PCIS_H;
	ld	a, 0x50a0
	and	a, #0xdf
	ld	0x50a0, a
;	main.c: 112: __asm__("rim");
	rim
;	main.c: 116: STEPPER_AZM_LIMIT_DDR &=~STEPPER_AZM_LIMIT_BIT;
	bres	20492, #4
;	main.c: 117: STEPPER_AZM_LIMIT_CR1 &=~STEPPER_AZM_LIMIT_BIT;
	bres	20493, #4
;	main.c: 118: STEPPER_AZM_LIMIT_CR2 |= STEPPER_AZM_LIMIT_BIT;
	bset	20494, #4
;	main.c: 120: STEPPER_ELV_LIMIT_DDR &=~STEPPER_ELV_LIMIT_BIT;
	bres	20492, #5
;	main.c: 121: STEPPER_ELV_LIMIT_CR1 &=~STEPPER_ELV_LIMIT_BIT;
	bres	20493, #5
;	main.c: 122: STEPPER_ELV_LIMIT_CR2 |= STEPPER_ELV_LIMIT_BIT;
	bset	20494, #5
;	main.c: 124: }
	ret
;	main.c: 135: stepper_init () {
;	-----------------------------------------
;	 function stepper_init
;	-----------------------------------------
_stepper_init:
;	main.c: 136: timer_init();
	call	_timer_init
;	main.c: 137: home_azm();
	call	_home_azm
;	main.c: 138: home_elv();
;	main.c: 139: }
	jp	_home_elv
;	main.c: 144: home_azm () {
;	-----------------------------------------
;	 function home_azm
;	-----------------------------------------
_home_azm:
;	main.c: 146: turn_steps_azm(-6400);
	push	#0x00
	push	#0xe7
	call	_turn_steps_azm
	addw	sp, #2
;	main.c: 147: }
	ret
;	main.c: 150: home_elv () {
;	-----------------------------------------
;	 function home_elv
;	-----------------------------------------
_home_elv:
;	main.c: 151: turn_steps_elv(-6400);
	push	#0x00
	push	#0xe7
	call	_turn_steps_elv
	addw	sp, #2
;	main.c: 152: }
	ret
;	main.c: 157: turn_steps_azm (int16_t steps) {
;	-----------------------------------------
;	 function turn_steps_azm
;	-----------------------------------------
_turn_steps_azm:
;	main.c: 159: if (steps == 0) {
	ldw	x, (0x03, sp)
	jrne	00107$
;	main.c: 160: return;
	ret
00107$:
;	main.c: 162: else if (steps < 0) {
	ldw	x, (0x03, sp)
	jrpl	00104$
;	main.c: 164: if (AZM_LIMIT_PUSHED) {
	ld	a, 0x500b
	bcp	a, #0x10
	jreq	00102$
;	main.c: 165: return;
	ret
00102$:
;	main.c: 168: AZM_SET_DIR_HOME;
	bres	20490, #1
;	main.c: 169: steps = -steps;
	ldw	x, (0x03, sp)
	negw	x
	ldw	(0x03, sp), x
	jra	00108$
00104$:
;	main.c: 172: AZM_SET_DIR_SPA;
	bset	20490, #1
00108$:
;	main.c: 175: ELV_STEP_DISABLE;
	bres	21084, #6
;	main.c: 176: AZM_STEP_ENABLE;
	bset	21084, #2
;	main.c: 178: stepping_done = 0;
	clr	_stepping_done+0
;	main.c: 180: target_steps = steps;
	ldw	x, (0x03, sp)
	ldw	_target_steps+0, x
;	main.c: 181: TIM1_CR1 |= CEN;
	ld	a, 0x5250
	or	a, #0x01
	ld	0x5250, a
;	main.c: 183: while(!stepping_done)
00109$:
	tnz	_stepping_done+0
	jrne	00111$
;	main.c: 184: __asm__("wfi");
	wfi
	jra	00109$
00111$:
;	main.c: 186: AZM_STEP_DISABLE;
	bres	21084, #2
;	main.c: 187: }
	ret
;	main.c: 190: turn_steps_elv (int16_t steps) {
;	-----------------------------------------
;	 function turn_steps_elv
;	-----------------------------------------
_turn_steps_elv:
;	main.c: 192: if (steps == 0) {
	ldw	x, (0x03, sp)
	jrne	00107$
;	main.c: 193: return;
	ret
00107$:
;	main.c: 195: else if (steps < 0) {
	ldw	x, (0x03, sp)
	jrpl	00104$
;	main.c: 197: if (ELV_LIMIT_PUSHED) {
	ld	a, 0x500b
	bcp	a, #0x20
	jreq	00102$
;	main.c: 198: return;
	ret
00102$:
;	main.c: 201: ELV_SET_DIR_HOME;
	bres	20490, #2
;	main.c: 202: steps = -steps;
	ldw	x, (0x03, sp)
	negw	x
	ldw	(0x03, sp), x
	jra	00108$
00104$:
;	main.c: 205: ELV_SET_DIR_SPA;
	bset	20490, #2
00108$:
;	main.c: 208: AZM_STEP_DISABLE;
	bres	21084, #2
;	main.c: 209: ELV_STEP_ENABLE;
	bset	21084, #6
;	main.c: 211: stepping_done = 0;
	clr	_stepping_done+0
;	main.c: 213: target_steps = steps;
	ldw	x, (0x03, sp)
	ldw	_target_steps+0, x
;	main.c: 214: TIM1_CR1 |= CEN;
	ld	a, 0x5250
	or	a, #0x01
	ld	0x5250, a
;	main.c: 216: while(!stepping_done)
00109$:
	tnz	_stepping_done+0
	jrne	00111$
;	main.c: 217: __asm__("wfi");
	wfi
	jra	00109$
00111$:
;	main.c: 219: ELV_STEP_DISABLE;
	bres	21084, #6
;	main.c: 220: }
	ret
;	main.c: 225: timer_init () {
;	-----------------------------------------
;	 function timer_init
;	-----------------------------------------
_timer_init:
;	main.c: 226: TIM1_CR1 &= ~CEN; // disable timer
	bres	21072, #0
;	main.c: 227: TIM1_IER &= ~UIE;
	bres	21076, #0
;	main.c: 229: TIM1_PSCRH = 0x00;
	mov	0x5260+0, #0x00
;	main.c: 230: TIM1_PSCRL = 0x5F;
	mov	0x5261+0, #0x5f
;	main.c: 232: TIM1_CR1 |= ARPE;
	bset	21072, #7
;	main.c: 233: TIM1_ARRH = 0x00;
	mov	0x5262+0, #0x00
;	main.c: 234: TIM1_ARRL = 0xff;
	mov	0x5263+0, #0xff
;	main.c: 236: TIM1_CCR1H  = 0x00; // CCRx determines duty cycle
	mov	0x5265+0, #0x00
;	main.c: 237: TIM1_CCR1L  = 0x80;
	mov	0x5266+0, #0x80
;	main.c: 239: TIM1_CCR2H  = 0x00; // CCRx determines duty cycle
	mov	0x5267+0, #0x00
;	main.c: 240: TIM1_CCR2L  = 0x80;
	mov	0x5268+0, #0x80
;	main.c: 242: TIM1_CCMR1 &= ~(CC1S_H | CC1S_L); // Output mode
	ld	a, 0x5258
	and	a, #0xfc
	ld	0x5258, a
;	main.c: 243: TIM1_CCMR2 &= ~(CC1S_H | CC1S_L); // Output mode
	ld	a, 0x5259
	and	a, #0xfc
	ld	0x5259, a
;	main.c: 245: TIM1_CCMR1 |= OCM1_PWM2; /* PWM mode 2 */
	ld	a, 0x5258
	or	a, #0x70
	ld	0x5258, a
;	main.c: 246: TIM1_CCMR2 |= OCM1_PWM2;
	ld	a, 0x5259
	or	a, #0x70
	ld	0x5259, a
;	main.c: 248: TIM1_CCER1 |= CC1NE | CC2NE; /* output enable */
	ld	a, 0x525c
	or	a, #0x44
	ld	0x525c, a
;	main.c: 250: TIM1_BKR  = MOE; // automatic output enable
	mov	0x526d+0, #0x80
;	main.c: 251: TIM1_IER |= UIE;
	bset	21076, #0
;	main.c: 252: }
	ret
;	main.c: 257: timer_isr(void) __interrupt(IRQ_TIM1) {
;	-----------------------------------------
;	 function timer_isr
;	-----------------------------------------
_timer_isr:
;	main.c: 259: target_steps--;
	ldw	x, _target_steps+0
	decw	x
;	main.c: 261: if (target_steps == 0) {
	ldw	_target_steps+0, x
	jrne	00102$
;	main.c: 262: TIM1_CR1 &= ~CEN;
	bres	21072, #0
;	main.c: 263: stepping_done = 1;
	mov	_stepping_done+0, #0x01
00102$:
;	main.c: 266: TIM1_SR1 &= ~UIF;
	bres	21077, #0
;	main.c: 267: }
	iret
;	main.c: 271: port_c_isr(void) __interrupt(IRQ_EXTI2) {
;	-----------------------------------------
;	 function port_c_isr
;	-----------------------------------------
_port_c_isr:
;	main.c: 272: if (AZM_LIMIT_PUSHED) {
	ld	a, 0x500b
	bcp	a, #0x10
	jreq	00102$
;	main.c: 273: current_pos_azm  = ZERO_POSITION_AZM;
	clrw	x
	ldw	_current_pos_azm+0, x
;	main.c: 274: target_steps = 0;
	clrw	x
	ldw	_target_steps+0, x
;	main.c: 275: stepping_done = 1;
	mov	_stepping_done+0, #0x01
;	main.c: 276: TIM1_CR1 &= ~CEN;
	bres	21072, #0
00102$:
;	main.c: 279: if (ELV_LIMIT_PUSHED) {
	ld	a, 0x500b
	bcp	a, #0x20
	jreq	00105$
;	main.c: 280: current_pos_elv  = ZERO_POSITION_ELV;
	ldw	x, #0xffc3
	ldw	_current_pos_elv+0, x
;	main.c: 281: target_steps = 0;
	clrw	x
	ldw	_target_steps+0, x
;	main.c: 282: stepping_done = 1; // ?
	mov	_stepping_done+0, #0x01
;	main.c: 283: TIM1_CR1 &= ~CEN;
	bres	21072, #0
00105$:
;	main.c: 285: }
	iret
;	main.c: 301: init_command_buffer () {
;	-----------------------------------------
;	 function init_command_buffer
;	-----------------------------------------
_init_command_buffer:
	sub	sp, #4
;	main.c: 302: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
	clrw	x
	ldw	(0x03, sp), x
00107$:
	ldw	x, (0x03, sp)
	cpw	x, #0x0010
	jrsge	00109$
;	main.c: 303: command_buffer[i] = malloc(MAX_COMMAND_LENGTH*sizeof(char));
	ldw	x, (0x03, sp)
	sllw	x
	addw	x, #(_command_buffer+0)
	ldw	(0x01, sp), x
	push	#0x12
	push	#0x00
	call	_malloc
	addw	sp, #2
	ldw	y, (0x01, sp)
	ldw	(y), x
;	main.c: 304: char* command = command_buffer[i];
	ldw	(0x01, sp), x
;	main.c: 305: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
	clrw	x
00104$:
	cpw	x, #0x0012
	jrsge	00108$
;	main.c: 306: command[n] = 0;
	ldw	y, x
	addw	y, (0x01, sp)
	clr	(y)
;	main.c: 305: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
	incw	x
	jra	00104$
00108$:
;	main.c: 302: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00107$
00109$:
;	main.c: 309: }
	addw	sp, #4
	ret
;	main.c: 314: get_steps_from_command (const char* cmd) {
;	-----------------------------------------
;	 function get_steps_from_command
;	-----------------------------------------
_get_steps_from_command:
	sub	sp, #2
;	main.c: 319: if (cmd[1] == '\0') {
	ldw	x, (0x05, sp)
	incw	x
	ld	a, (x)
	jrne	00102$
;	main.c: 320: return 0;
	clrw	x
	jra	00107$
00102$:
;	main.c: 323: steps = strtol(cmd + 1, &endptr, 10);
	push	#0x0a
	push	#0x00
	ldw	y, sp
	addw	y, #3
	pushw	y
	pushw	x
	call	_strtol
	addw	sp, #6
	exgw	x, y
;	main.c: 325: if (endptr == cmd || !(*endptr == '\0' || *endptr == '\n')) {
	ldw	x, (0x01, sp)
	cpw	x, (0x05, sp)
	jreq	00103$
	ldw	x, (0x01, sp)
	ld	a, (x)
	jreq	00104$
	cp	a, #0x0a
	jreq	00104$
00103$:
;	main.c: 326: return 0;
	clrw	x
;	main.c: 329: return steps;
	.byte 0x21
00104$:
	ldw	x, y
00107$:
;	main.c: 330: }
	addw	sp, #2
	ret
;	main.c: 335: uart2_write(char *str) {
;	-----------------------------------------
;	 function uart2_write
;	-----------------------------------------
_uart2_write:
;	main.c: 337: uart_tx_buf = str;
	ldw	x, (0x03, sp)
;	main.c: 338: UART2_DR    = uart_tx_buf[0];
	ldw	_uart_tx_buf+0, x
	ld	a, (x)
	ld	0x5241, a
;	main.c: 339: UART2_CR2  |= TIEN;
	ld	a, 0x5245
	or	a, #0x80
	ld	0x5245, a
;	main.c: 343: while(!uart_tx_done)
00101$:
	ldw	x, _uart_tx_done+0
	jrne	00103$
;	main.c: 344: __asm__("wfi");
	wfi
	jra	00101$
00103$:
;	main.c: 346: UART2_CR2 &= ~TIEN;
	bres	21061, #7
;	main.c: 348: uart_tx_done = 0;
	clrw	x
	ldw	_uart_tx_done+0, x
;	main.c: 350: return 0;
	clrw	x
;	main.c: 351: }
	ret
;	main.c: 356: uart2_init () {
;	-----------------------------------------
;	 function uart2_init
;	-----------------------------------------
_uart2_init:
;	main.c: 358: UART2_CR2 |= TEN; // Transmitter enable
	bset	21061, #3
;	main.c: 359: UART2_CR2 |= REN; // Receiver enable
	bset	21061, #2
;	main.c: 361: UART2_CR3 &= ~(STOP_H | STOP_L); // 1 stop bit
	ld	a, 0x5246
	and	a, #0xcf
	ld	0x5246, a
;	main.c: 362: UART2_CR1  = 0;
	mov	0x5244+0, #0x00
;	main.c: 365: UART2_BRR2 = 0x03;
	mov	0x5243+0, #0x03
;	main.c: 366: UART2_BRR1 = 0x68;
	mov	0x5242+0, #0x68
;	main.c: 368: UART2_CR2 |= RIEN;
	ld	a, 0x5245
	or	a, #0x20
	ld	0x5245, a
;	main.c: 370: init_command_buffer();
;	main.c: 371: }
	jp	_init_command_buffer
;	main.c: 377: read_next_command () {
;	-----------------------------------------
;	 function read_next_command
;	-----------------------------------------
_read_next_command:
;	main.c: 382: while(command_number == read_index)
00101$:
	ld	a, _read_next_command_read_index_65536_79+0
	cp	a, _command_number+0
	jrne	00103$
;	main.c: 383: __asm__("wfi");
	wfi
	jra	00101$
00103$:
;	main.c: 386: command = command_buffer[read_index];
	clrw	x
	ld	a, _read_next_command_read_index_65536_79+0
	ld	xl, a
	sllw	x
	ldw	x, (_command_buffer+0, x)
;	main.c: 388: read_index++;
	inc	_read_next_command_read_index_65536_79+0
;	main.c: 390: if (read_index > (COMMAND_BUFFER_SIZE - 1)) {
	ld	a, _read_next_command_read_index_65536_79+0
	cp	a, #0x0f
	jrugt	00126$
	ret
00126$:
;	main.c: 391: read_index = 0;
	clr	_read_next_command_read_index_65536_79+0
;	main.c: 394: return command;
;	main.c: 395: }
	ret
;	main.c: 400: uart2_tx_isr(void) __interrupt(IRQ_UART2_TX) {
;	-----------------------------------------
;	 function uart2_tx_isr
;	-----------------------------------------
_uart2_tx_isr:
;	main.c: 404: UART2_DR = uart_tx_buf[i];
	ld	a, _uart_tx_buf+1
	add	a, _uart2_tx_isr_i_65536_82+0
	ld	xl, a
	ld	a, _uart_tx_buf+0
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	ld	0x5241, a
;	main.c: 406: if (uart_tx_buf[i] == '\0') {
	ld	a, _uart_tx_buf+1
	add	a, _uart2_tx_isr_i_65536_82+0
	ld	xl, a
	ld	a, _uart_tx_buf+0
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	jrne	00102$
;	main.c: 407: uart_tx_done = 1;
	ldw	x, #0x0001
	ldw	_uart_tx_done+0, x
;	main.c: 408: i = 1;
	mov	_uart2_tx_isr_i_65536_82+0, #0x01
;	main.c: 409: return;
	jra	00103$
00102$:
;	main.c: 412: i++;
	inc	_uart2_tx_isr_i_65536_82+0
00103$:
;	main.c: 413: }
	iret
;	main.c: 418: uart2_rx_isr(void) __interrupt(IRQ_UART2_RX) {
;	-----------------------------------------
;	 function uart2_rx_isr
;	-----------------------------------------
_uart2_rx_isr:
	sub	sp, #2
;	main.c: 424: command = command_buffer[command_number];
	ld	a, _command_number+0
	clrw	x
	ld	xl, a
	sllw	x
	ldw	x, (_command_buffer+0, x)
	ldw	(0x01, sp), x
;	main.c: 428: command[byte_index] = UART2_DR;
	clrw	x
	ld	a, _uart2_rx_isr_byte_index_65536_85+0
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, 0x5241
	ld	(x), a
;	main.c: 430: if (command[byte_index] == '\n') {
	clrw	x
	ld	a, _uart2_rx_isr_byte_index_65536_85+0
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	cp	a, #0x0a
	jrne	00104$
;	main.c: 432: byte_index = 0;
	clr	_uart2_rx_isr_byte_index_65536_85+0
;	main.c: 434: command_number++;
	inc	_command_number+0
;	main.c: 436: if (command_number > (COMMAND_BUFFER_SIZE - 1)) {
	ld	a, _command_number+0
	cp	a, #0x0f
	jrule	00107$
;	main.c: 437: command_number = 0;
	clr	_command_number+0
;	main.c: 440: return;
	jra	00107$
00104$:
;	main.c: 443: byte_index++;
	inc	_uart2_rx_isr_byte_index_65536_85+0
;	main.c: 445: if (byte_index > (MAX_COMMAND_LENGTH - 1))
	ld	a, _uart2_rx_isr_byte_index_65536_85+0
	cp	a, #0x11
	jrule	00107$
;	main.c: 446: byte_index = 0;
	clr	_uart2_rx_isr_byte_index_65536_85+0
00107$:
;	main.c: 447: }
	addw	sp, #2
	iret
;	main.c: 450: void hsi_configure () {
;	-----------------------------------------
;	 function hsi_configure
;	-----------------------------------------
_hsi_configure:
;	main.c: 451: while ((CLK_ICKR & BIT1) == 0); // HSRDY
00101$:
	ld	a, 0x50c0
	bcp	a, #0x02
	jreq	00101$
;	main.c: 453: while((CLK_SWCR & BIT0));
00104$:
	ld	a, 0x50c5
	srl	a
	jrc	00104$
;	main.c: 454: CLK_SWR    = 0xE1; // select HSI for Master CLK
	mov	0x50c4+0, #0xe1
;	main.c: 455: CLK_CKDIVR = 0;
	mov	0x50c6+0, #0x00
;	main.c: 457: while((CLK_SWCR & BIT0));
00107$:
	ld	a, 0x50c5
	srl	a
	jrc	00107$
;	main.c: 458: CLK_SWCR |= BIT1;
	bset	20677, #1
;	main.c: 459: while((CLK_SWCR & BIT0));
00110$:
	ld	a, 0x50c5
	srl	a
	jrc	00110$
;	main.c: 460: CLK_SWCR &= ~BIT1;
	bres	20677, #1
;	main.c: 461: }
	ret
;	main.c: 463: void clk_out_enable() {
;	-----------------------------------------
;	 function clk_out_enable
;	-----------------------------------------
_clk_out_enable:
;	main.c: 465: PD_DDR |= BIT0;
	bset	20497, #0
;	main.c: 467: PD_CR1 |= BIT0;
	bset	20498, #0
;	main.c: 468: PD_CR2 |= BIT0;
	bset	20499, #0
;	main.c: 470: CLK_CCOR |= (BIT0 | (0b1011 << 1));
	ld	a, 0x50c9
	or	a, #0x17
	ld	0x50c9, a
;	main.c: 471: }
	ret
;	main.c: 474: void opt_write() {
;	-----------------------------------------
;	 function opt_write
;	-----------------------------------------
_opt_write:
;	main.c: 482: FLASH_DUKR = FLASH_DUKR_KEY1;
	mov	0x5064+0, #0xae
;	main.c: 483: FLASH_DUKR = FLASH_DUKR_KEY2;
	mov	0x5064+0, #0x56
;	main.c: 484: while (!(FLASH_IAPSR & BIT3));
00101$:
	ld	a, 0x505f
	bcp	a, #0x08
	jreq	00101$
;	main.c: 486: FLASH_CR2 |= BIT7;
	bset	20571, #7
;	main.c: 487: FLASH_NCR2 &= ~BIT7;
	bres	20572, #7
;	main.c: 490: *((uint8_t*) 0x4803) = opt0;
	mov	0x4803+0, #0x24
;	main.c: 491: *((uint8_t*) 0x4804) = ~opt0;
	mov	0x4804+0, #0xdb
;	main.c: 494: while (!(FLASH_IAPSR & BIT2));
00104$:
	ld	a, 0x505f
	bcp	a, #0x04
	jreq	00104$
;	main.c: 496: FLASH_IAPSR &= ~BIT3;
	bres	20575, #3
;	main.c: 497: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "e"
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
__xinit__target_steps:
	.dw #0x0000
__xinit__stepping_done:
	.db #0x00	; 0
__xinit__current_pos_azm:
	.dw #0x0000
__xinit__current_pos_elv:
	.dw #0xffc3
__xinit__command_number:
	.db #0x00	; 0
__xinit__uart_tx_done:
	.dw #0x0000
	.area CABS (ABS)
