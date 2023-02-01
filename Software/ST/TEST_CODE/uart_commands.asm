;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.0 #12072 (Linux)
;--------------------------------------------------------
	.module uart_commands
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _uart2_rx_isr
	.globl _uart2_tx_isr
	.globl _malloc
	.globl _strtol
	.globl _init_command_buffer
	.globl _get_steps_from_command
	.globl _uart2_write
	.globl _uart2_init
	.globl _read_next_command
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
_read_next_command_read_index_65536_45:
	.ds 1
_uart2_tx_isr_i_65536_48:
	.ds 1
_uart2_rx_isr_byte_index_65536_51:
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_command_number:
	.ds 1
_uart_tx_done:
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
;	src/uart_commands/uart_commands.c: 100: static uint8_t read_index = 0; // reading position in command_buffer
	clr	_read_next_command_read_index_65536_45+0
;	src/uart_commands/uart_commands.c: 123: static uint8_t i = 1;
	mov	_uart2_tx_isr_i_65536_48+0, #0x01
;	src/uart_commands/uart_commands.c: 142: static uint8_t byte_index = 0;
	clr	_uart2_rx_isr_byte_index_65536_51+0
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	src/uart_commands/uart_commands.c: 22: init_command_buffer () {
;	-----------------------------------------
;	 function init_command_buffer
;	-----------------------------------------
_init_command_buffer:
	sub	sp, #4
;	src/uart_commands/uart_commands.c: 23: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
	clrw	x
	ldw	(0x03, sp), x
00107$:
	ldw	x, (0x03, sp)
	cpw	x, #0x0010
	jrsge	00109$
;	src/uart_commands/uart_commands.c: 24: command_buffer[i] = malloc(MAX_COMMAND_LENGTH*sizeof(char));
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
;	src/uart_commands/uart_commands.c: 25: char* command = command_buffer[i];
	ldw	(0x01, sp), x
;	src/uart_commands/uart_commands.c: 26: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
	clrw	x
00104$:
	cpw	x, #0x0012
	jrsge	00108$
;	src/uart_commands/uart_commands.c: 27: command[n] = 0;
	ldw	y, x
	addw	y, (0x01, sp)
	clr	(y)
;	src/uart_commands/uart_commands.c: 26: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
	incw	x
	jra	00104$
00108$:
;	src/uart_commands/uart_commands.c: 23: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00107$
00109$:
;	src/uart_commands/uart_commands.c: 30: }
	addw	sp, #4
	ret
;	src/uart_commands/uart_commands.c: 35: get_steps_from_command (const char* cmd) {
;	-----------------------------------------
;	 function get_steps_from_command
;	-----------------------------------------
_get_steps_from_command:
	sub	sp, #2
;	src/uart_commands/uart_commands.c: 40: if (cmd[1] == '\0') {
	ldw	x, (0x05, sp)
	incw	x
	ld	a, (x)
	jrne	00102$
;	src/uart_commands/uart_commands.c: 41: return 0;
	clrw	x
	jra	00107$
00102$:
;	src/uart_commands/uart_commands.c: 44: steps = strtol(cmd + 1, &endptr, 10);
	push	#0x0a
	push	#0x00
	ldw	y, sp
	addw	y, #3
	pushw	y
	pushw	x
	call	_strtol
	addw	sp, #6
	exgw	x, y
;	src/uart_commands/uart_commands.c: 46: if (endptr == cmd || !(*endptr == '\0' || *endptr == '\n')) {
	ldw	x, (0x01, sp)
	cpw	x, (0x05, sp)
	jreq	00103$
	ldw	x, (0x01, sp)
	ld	a, (x)
	jreq	00104$
	cp	a, #0x0a
	jreq	00104$
00103$:
;	src/uart_commands/uart_commands.c: 47: return 0;
	clrw	x
;	src/uart_commands/uart_commands.c: 50: return steps;
	.byte 0x21
00104$:
	ldw	x, y
00107$:
;	src/uart_commands/uart_commands.c: 51: }
	addw	sp, #2
	ret
;	src/uart_commands/uart_commands.c: 56: uart2_write(char *str) {
;	-----------------------------------------
;	 function uart2_write
;	-----------------------------------------
_uart2_write:
;	src/uart_commands/uart_commands.c: 58: uart_tx_buf = str;
	ldw	x, (0x03, sp)
;	src/uart_commands/uart_commands.c: 59: UART2_DR    = uart_tx_buf[0];
	ldw	_uart_tx_buf+0, x
	ld	a, (x)
	ld	0x5241, a
;	src/uart_commands/uart_commands.c: 60: UART2_CR2  |= TIEN;
	ld	a, 0x5245
	or	a, #0x80
	ld	0x5245, a
;	src/uart_commands/uart_commands.c: 64: while(!uart_tx_done)
00101$:
	ldw	x, _uart_tx_done+0
	jrne	00103$
;	src/uart_commands/uart_commands.c: 65: __asm__("wfi");
	wfi
	jra	00101$
00103$:
;	src/uart_commands/uart_commands.c: 67: UART2_CR2 &= ~TIEN;
	bres	21061, #7
;	src/uart_commands/uart_commands.c: 69: uart_tx_done = 0;
	clrw	x
	ldw	_uart_tx_done+0, x
;	src/uart_commands/uart_commands.c: 71: return 0;
	clrw	x
;	src/uart_commands/uart_commands.c: 72: }
	ret
;	src/uart_commands/uart_commands.c: 77: uart2_init () {
;	-----------------------------------------
;	 function uart2_init
;	-----------------------------------------
_uart2_init:
;	src/uart_commands/uart_commands.c: 79: UART2_CR2 |= TEN; // Transmitter enable
	bset	21061, #3
;	src/uart_commands/uart_commands.c: 80: UART2_CR2 |= REN; // Receiver enable
	bset	21061, #2
;	src/uart_commands/uart_commands.c: 82: UART2_CR3 &= ~(STOP_H | STOP_L); // 1 stop bit
	ld	a, 0x5246
	and	a, #0xcf
	ld	0x5246, a
;	src/uart_commands/uart_commands.c: 83: UART2_CR1  = 0;
	mov	0x5244+0, #0x00
;	src/uart_commands/uart_commands.c: 86: UART2_BRR2 = 0x03;
	mov	0x5243+0, #0x03
;	src/uart_commands/uart_commands.c: 87: UART2_BRR1 = 0x68;
	mov	0x5242+0, #0x68
;	src/uart_commands/uart_commands.c: 89: UART2_CR2 |= RIEN;
	ld	a, 0x5245
	or	a, #0x20
	ld	0x5245, a
;	src/uart_commands/uart_commands.c: 91: init_command_buffer();
;	src/uart_commands/uart_commands.c: 92: }
	jp	_init_command_buffer
;	src/uart_commands/uart_commands.c: 98: read_next_command () {
;	-----------------------------------------
;	 function read_next_command
;	-----------------------------------------
_read_next_command:
;	src/uart_commands/uart_commands.c: 103: while(command_number == read_index)
00101$:
	ld	a, _read_next_command_read_index_65536_45+0
	cp	a, _command_number+0
	jrne	00103$
;	src/uart_commands/uart_commands.c: 104: __asm__("wfi");
	wfi
	jra	00101$
00103$:
;	src/uart_commands/uart_commands.c: 107: command = command_buffer[read_index];
	clrw	x
	ld	a, _read_next_command_read_index_65536_45+0
	ld	xl, a
	sllw	x
	ldw	x, (_command_buffer+0, x)
;	src/uart_commands/uart_commands.c: 109: read_index++;
	inc	_read_next_command_read_index_65536_45+0
;	src/uart_commands/uart_commands.c: 111: if (read_index > (COMMAND_BUFFER_SIZE - 1)) {
	ld	a, _read_next_command_read_index_65536_45+0
	cp	a, #0x0f
	jrugt	00126$
	ret
00126$:
;	src/uart_commands/uart_commands.c: 112: read_index = 0;
	clr	_read_next_command_read_index_65536_45+0
;	src/uart_commands/uart_commands.c: 115: return command;
;	src/uart_commands/uart_commands.c: 116: }
	ret
;	src/uart_commands/uart_commands.c: 121: uart2_tx_isr(void) __interrupt(IRQ_UART2_TX) {
;	-----------------------------------------
;	 function uart2_tx_isr
;	-----------------------------------------
_uart2_tx_isr:
;	src/uart_commands/uart_commands.c: 125: UART2_DR = uart_tx_buf[i];
	ld	a, _uart_tx_buf+1
	add	a, _uart2_tx_isr_i_65536_48+0
	ld	xl, a
	ld	a, _uart_tx_buf+0
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	ld	0x5241, a
;	src/uart_commands/uart_commands.c: 127: if (uart_tx_buf[i] == '\0') {
	ld	a, _uart_tx_buf+1
	add	a, _uart2_tx_isr_i_65536_48+0
	ld	xl, a
	ld	a, _uart_tx_buf+0
	adc	a, #0x00
	ld	xh, a
	ld	a, (x)
	jrne	00102$
;	src/uart_commands/uart_commands.c: 128: uart_tx_done = 1;
	ldw	x, #0x0001
	ldw	_uart_tx_done+0, x
;	src/uart_commands/uart_commands.c: 129: i = 1;
	mov	_uart2_tx_isr_i_65536_48+0, #0x01
;	src/uart_commands/uart_commands.c: 130: return;
	jra	00103$
00102$:
;	src/uart_commands/uart_commands.c: 133: i++;
	inc	_uart2_tx_isr_i_65536_48+0
00103$:
;	src/uart_commands/uart_commands.c: 134: }
	iret
;	src/uart_commands/uart_commands.c: 139: uart2_rx_isr(void) __interrupt(IRQ_UART2_RX) {
;	-----------------------------------------
;	 function uart2_rx_isr
;	-----------------------------------------
_uart2_rx_isr:
	sub	sp, #2
;	src/uart_commands/uart_commands.c: 145: command = command_buffer[command_number];
	ld	a, _command_number+0
	clrw	x
	ld	xl, a
	sllw	x
	ldw	x, (_command_buffer+0, x)
	ldw	(0x01, sp), x
;	src/uart_commands/uart_commands.c: 149: command[byte_index] = UART2_DR;
	clrw	x
	ld	a, _uart2_rx_isr_byte_index_65536_51+0
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, 0x5241
	ld	(x), a
;	src/uart_commands/uart_commands.c: 151: if (command[byte_index] == '\n') {
	clrw	x
	ld	a, _uart2_rx_isr_byte_index_65536_51+0
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (x)
	cp	a, #0x0a
	jrne	00104$
;	src/uart_commands/uart_commands.c: 153: byte_index = 0;
	clr	_uart2_rx_isr_byte_index_65536_51+0
;	src/uart_commands/uart_commands.c: 155: command_number++;
	inc	_command_number+0
;	src/uart_commands/uart_commands.c: 157: if (command_number > (COMMAND_BUFFER_SIZE - 1)) {
	ld	a, _command_number+0
	cp	a, #0x0f
	jrule	00107$
;	src/uart_commands/uart_commands.c: 158: command_number = 0;
	clr	_command_number+0
;	src/uart_commands/uart_commands.c: 161: return;
	jra	00107$
00104$:
;	src/uart_commands/uart_commands.c: 164: byte_index++;
	inc	_uart2_rx_isr_byte_index_65536_51+0
;	src/uart_commands/uart_commands.c: 166: if (byte_index > (MAX_COMMAND_LENGTH - 1))
	ld	a, _uart2_rx_isr_byte_index_65536_51+0
	cp	a, #0x11
	jrule	00107$
;	src/uart_commands/uart_commands.c: 167: byte_index = 0;
	clr	_uart2_rx_isr_byte_index_65536_51+0
00107$:
;	src/uart_commands/uart_commands.c: 168: }
	addw	sp, #2
	iret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__command_number:
	.db #0x00	; 0
__xinit__uart_tx_done:
	.dw #0x0000
	.area CABS (ABS)
