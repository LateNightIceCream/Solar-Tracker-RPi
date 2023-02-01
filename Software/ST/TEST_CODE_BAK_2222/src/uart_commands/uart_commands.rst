                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 4.1.0 #12072 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module uart_commands
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _uart2_rx_isr
                                     12 	.globl _uart2_tx_isr
                                     13 	.globl _malloc
                                     14 	.globl _strtol
                                     15 	.globl _init_command_buffer
                                     16 	.globl _get_steps_from_command
                                     17 	.globl _uart2_write
                                     18 	.globl _uart2_init
                                     19 	.globl _read_next_command
                                     20 ;--------------------------------------------------------
                                     21 ; ram data
                                     22 ;--------------------------------------------------------
                                     23 	.area DATA
      000001                         24 _command_buffer:
      000001                         25 	.ds 32
      000021                         26 _uart_rx_buf:
      000021                         27 	.ds 127
      0000A0                         28 _uart_tx_buf:
      0000A0                         29 	.ds 2
      0000A2                         30 _read_next_command_read_index_65536_45:
      0000A2                         31 	.ds 1
      0000A3                         32 _uart2_tx_isr_i_65536_48:
      0000A3                         33 	.ds 1
      0000A4                         34 _uart2_rx_isr_byte_index_65536_51:
      0000A4                         35 	.ds 1
                                     36 ;--------------------------------------------------------
                                     37 ; ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area INITIALIZED
      0004AE                         40 _command_number:
      0004AE                         41 	.ds 1
      0004AF                         42 _uart_tx_done:
      0004AF                         43 	.ds 2
                                     44 ;--------------------------------------------------------
                                     45 ; absolute external ram data
                                     46 ;--------------------------------------------------------
                                     47 	.area DABS (ABS)
                                     48 
                                     49 ; default segment ordering for linker
                                     50 	.area HOME
                                     51 	.area GSINIT
                                     52 	.area GSFINAL
                                     53 	.area CONST
                                     54 	.area INITIALIZER
                                     55 	.area CODE
                                     56 
                                     57 ;--------------------------------------------------------
                                     58 ; global & static initialisations
                                     59 ;--------------------------------------------------------
                                     60 	.area HOME
                                     61 	.area GSINIT
                                     62 	.area GSFINAL
                                     63 	.area GSINIT
                                     64 ;	src/uart_commands/uart_commands.c: 100: static uint8_t read_index = 0; // reading position in command_buffer
      008021 72 5F 00 A2      [ 1]   65 	clr	_read_next_command_read_index_65536_45+0
                                     66 ;	src/uart_commands/uart_commands.c: 123: static uint8_t i = 1;
      008025 35 01 00 A3      [ 1]   67 	mov	_uart2_tx_isr_i_65536_48+0, #0x01
                                     68 ;	src/uart_commands/uart_commands.c: 142: static uint8_t byte_index = 0;
      008029 72 5F 00 A4      [ 1]   69 	clr	_uart2_rx_isr_byte_index_65536_51+0
                                     70 ;--------------------------------------------------------
                                     71 ; Home
                                     72 ;--------------------------------------------------------
                                     73 	.area HOME
                                     74 	.area HOME
                                     75 ;--------------------------------------------------------
                                     76 ; code
                                     77 ;--------------------------------------------------------
                                     78 	.area CODE
                                     79 ;	src/uart_commands/uart_commands.c: 22: init_command_buffer () {
                                     80 ;	-----------------------------------------
                                     81 ;	 function init_command_buffer
                                     82 ;	-----------------------------------------
      00824C                         83 _init_command_buffer:
      00824C 52 04            [ 2]   84 	sub	sp, #4
                                     85 ;	src/uart_commands/uart_commands.c: 23: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
      00824E 5F               [ 1]   86 	clrw	x
      00824F 1F 03            [ 2]   87 	ldw	(0x03, sp), x
      008251                         88 00107$:
      008251 1E 03            [ 2]   89 	ldw	x, (0x03, sp)
      008253 A3 00 10         [ 2]   90 	cpw	x, #0x0010
      008256 2E 2E            [ 1]   91 	jrsge	00109$
                                     92 ;	src/uart_commands/uart_commands.c: 24: command_buffer[i] = malloc(MAX_COMMAND_LENGTH*sizeof(char));
      008258 1E 03            [ 2]   93 	ldw	x, (0x03, sp)
      00825A 58               [ 2]   94 	sllw	x
      00825B 1C 00 01         [ 2]   95 	addw	x, #(_command_buffer+0)
      00825E 1F 01            [ 2]   96 	ldw	(0x01, sp), x
      008260 4B 12            [ 1]   97 	push	#0x12
      008262 4B 00            [ 1]   98 	push	#0x00
      008264 CD 85 04         [ 4]   99 	call	_malloc
      008267 5B 02            [ 2]  100 	addw	sp, #2
      008269 16 01            [ 2]  101 	ldw	y, (0x01, sp)
      00826B 90 FF            [ 2]  102 	ldw	(y), x
                                    103 ;	src/uart_commands/uart_commands.c: 25: char* command = command_buffer[i];
      00826D 1F 01            [ 2]  104 	ldw	(0x01, sp), x
                                    105 ;	src/uart_commands/uart_commands.c: 26: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
      00826F 5F               [ 1]  106 	clrw	x
      008270                        107 00104$:
      008270 A3 00 12         [ 2]  108 	cpw	x, #0x0012
      008273 2E 0A            [ 1]  109 	jrsge	00108$
                                    110 ;	src/uart_commands/uart_commands.c: 27: command[n] = 0;
      008275 90 93            [ 1]  111 	ldw	y, x
      008277 72 F9 01         [ 2]  112 	addw	y, (0x01, sp)
      00827A 90 7F            [ 1]  113 	clr	(y)
                                    114 ;	src/uart_commands/uart_commands.c: 26: for (int n = 0; n < MAX_COMMAND_LENGTH; n++) {
      00827C 5C               [ 1]  115 	incw	x
      00827D 20 F1            [ 2]  116 	jra	00104$
      00827F                        117 00108$:
                                    118 ;	src/uart_commands/uart_commands.c: 23: for (int i = 0; i < COMMAND_BUFFER_SIZE; i++){
      00827F 1E 03            [ 2]  119 	ldw	x, (0x03, sp)
      008281 5C               [ 1]  120 	incw	x
      008282 1F 03            [ 2]  121 	ldw	(0x03, sp), x
      008284 20 CB            [ 2]  122 	jra	00107$
      008286                        123 00109$:
                                    124 ;	src/uart_commands/uart_commands.c: 30: }
      008286 5B 04            [ 2]  125 	addw	sp, #4
      008288 81               [ 4]  126 	ret
                                    127 ;	src/uart_commands/uart_commands.c: 35: get_steps_from_command (const char* cmd) {
                                    128 ;	-----------------------------------------
                                    129 ;	 function get_steps_from_command
                                    130 ;	-----------------------------------------
      008289                        131 _get_steps_from_command:
      008289 52 02            [ 2]  132 	sub	sp, #2
                                    133 ;	src/uart_commands/uart_commands.c: 40: if (cmd[1] == '\0') {
      00828B 1E 05            [ 2]  134 	ldw	x, (0x05, sp)
      00828D 5C               [ 1]  135 	incw	x
      00828E F6               [ 1]  136 	ld	a, (x)
      00828F 26 03            [ 1]  137 	jrne	00102$
                                    138 ;	src/uart_commands/uart_commands.c: 41: return 0;
      008291 5F               [ 1]  139 	clrw	x
      008292 20 25            [ 2]  140 	jra	00107$
      008294                        141 00102$:
                                    142 ;	src/uart_commands/uart_commands.c: 44: steps = strtol(cmd + 1, &endptr, 10);
      008294 4B 0A            [ 1]  143 	push	#0x0a
      008296 4B 00            [ 1]  144 	push	#0x00
      008298 90 96            [ 1]  145 	ldw	y, sp
      00829A 72 A9 00 03      [ 2]  146 	addw	y, #3
      00829E 90 89            [ 2]  147 	pushw	y
      0082A0 89               [ 2]  148 	pushw	x
      0082A1 CD 84 14         [ 4]  149 	call	_strtol
      0082A4 5B 06            [ 2]  150 	addw	sp, #6
      0082A6 51               [ 1]  151 	exgw	x, y
                                    152 ;	src/uart_commands/uart_commands.c: 46: if (endptr == cmd || !(*endptr == '\0' || *endptr == '\n')) {
      0082A7 1E 01            [ 2]  153 	ldw	x, (0x01, sp)
      0082A9 13 05            [ 2]  154 	cpw	x, (0x05, sp)
      0082AB 27 09            [ 1]  155 	jreq	00103$
      0082AD 1E 01            [ 2]  156 	ldw	x, (0x01, sp)
      0082AF F6               [ 1]  157 	ld	a, (x)
      0082B0 27 06            [ 1]  158 	jreq	00104$
      0082B2 A1 0A            [ 1]  159 	cp	a, #0x0a
      0082B4 27 02            [ 1]  160 	jreq	00104$
      0082B6                        161 00103$:
                                    162 ;	src/uart_commands/uart_commands.c: 47: return 0;
      0082B6 5F               [ 1]  163 	clrw	x
                                    164 ;	src/uart_commands/uart_commands.c: 50: return steps;
      0082B7 21                     165 	.byte 0x21
      0082B8                        166 00104$:
      0082B8 93               [ 1]  167 	ldw	x, y
      0082B9                        168 00107$:
                                    169 ;	src/uart_commands/uart_commands.c: 51: }
      0082B9 5B 02            [ 2]  170 	addw	sp, #2
      0082BB 81               [ 4]  171 	ret
                                    172 ;	src/uart_commands/uart_commands.c: 56: uart2_write(char *str) {
                                    173 ;	-----------------------------------------
                                    174 ;	 function uart2_write
                                    175 ;	-----------------------------------------
      0082BC                        176 _uart2_write:
                                    177 ;	src/uart_commands/uart_commands.c: 58: uart_tx_buf = str;
      0082BC 1E 03            [ 2]  178 	ldw	x, (0x03, sp)
                                    179 ;	src/uart_commands/uart_commands.c: 59: UART2_DR    = uart_tx_buf[0];
      0082BE CF 00 A0         [ 2]  180 	ldw	_uart_tx_buf+0, x
      0082C1 F6               [ 1]  181 	ld	a, (x)
      0082C2 C7 52 41         [ 1]  182 	ld	0x5241, a
                                    183 ;	src/uart_commands/uart_commands.c: 60: UART2_CR2  |= TIEN;
      0082C5 C6 52 45         [ 1]  184 	ld	a, 0x5245
      0082C8 AA 80            [ 1]  185 	or	a, #0x80
      0082CA C7 52 45         [ 1]  186 	ld	0x5245, a
                                    187 ;	src/uart_commands/uart_commands.c: 64: while(!uart_tx_done)
      0082CD                        188 00101$:
      0082CD CE 04 AF         [ 2]  189 	ldw	x, _uart_tx_done+0
      0082D0 26 03            [ 1]  190 	jrne	00103$
                                    191 ;	src/uart_commands/uart_commands.c: 65: __asm__("wfi");
      0082D2 8F               [10]  192 	wfi
      0082D3 20 F8            [ 2]  193 	jra	00101$
      0082D5                        194 00103$:
                                    195 ;	src/uart_commands/uart_commands.c: 67: UART2_CR2 &= ~TIEN;
      0082D5 72 1F 52 45      [ 1]  196 	bres	21061, #7
                                    197 ;	src/uart_commands/uart_commands.c: 69: uart_tx_done = 0;
      0082D9 5F               [ 1]  198 	clrw	x
      0082DA CF 04 AF         [ 2]  199 	ldw	_uart_tx_done+0, x
                                    200 ;	src/uart_commands/uart_commands.c: 71: return 0;
      0082DD 5F               [ 1]  201 	clrw	x
                                    202 ;	src/uart_commands/uart_commands.c: 72: }
      0082DE 81               [ 4]  203 	ret
                                    204 ;	src/uart_commands/uart_commands.c: 77: uart2_init () {
                                    205 ;	-----------------------------------------
                                    206 ;	 function uart2_init
                                    207 ;	-----------------------------------------
      0082DF                        208 _uart2_init:
                                    209 ;	src/uart_commands/uart_commands.c: 79: UART2_CR2 |= TEN; // Transmitter enable
      0082DF 72 16 52 45      [ 1]  210 	bset	21061, #3
                                    211 ;	src/uart_commands/uart_commands.c: 80: UART2_CR2 |= REN; // Receiver enable
      0082E3 72 14 52 45      [ 1]  212 	bset	21061, #2
                                    213 ;	src/uart_commands/uart_commands.c: 82: UART2_CR3 &= ~(STOP_H | STOP_L); // 1 stop bit
      0082E7 C6 52 46         [ 1]  214 	ld	a, 0x5246
      0082EA A4 CF            [ 1]  215 	and	a, #0xcf
      0082EC C7 52 46         [ 1]  216 	ld	0x5246, a
                                    217 ;	src/uart_commands/uart_commands.c: 83: UART2_CR1  = 0;
      0082EF 35 00 52 44      [ 1]  218 	mov	0x5244+0, #0x00
                                    219 ;	src/uart_commands/uart_commands.c: 86: UART2_BRR2 = 0x03;
      0082F3 35 03 52 43      [ 1]  220 	mov	0x5243+0, #0x03
                                    221 ;	src/uart_commands/uart_commands.c: 87: UART2_BRR1 = 0x68;
      0082F7 35 68 52 42      [ 1]  222 	mov	0x5242+0, #0x68
                                    223 ;	src/uart_commands/uart_commands.c: 89: UART2_CR2 |= RIEN;
      0082FB C6 52 45         [ 1]  224 	ld	a, 0x5245
      0082FE AA 20            [ 1]  225 	or	a, #0x20
      008300 C7 52 45         [ 1]  226 	ld	0x5245, a
                                    227 ;	src/uart_commands/uart_commands.c: 91: init_command_buffer();
                                    228 ;	src/uart_commands/uart_commands.c: 92: }
      008303 CC 82 4C         [ 2]  229 	jp	_init_command_buffer
                                    230 ;	src/uart_commands/uart_commands.c: 98: read_next_command () {
                                    231 ;	-----------------------------------------
                                    232 ;	 function read_next_command
                                    233 ;	-----------------------------------------
      008306                        234 _read_next_command:
                                    235 ;	src/uart_commands/uart_commands.c: 103: while(command_number == read_index)
      008306                        236 00101$:
      008306 C6 00 A2         [ 1]  237 	ld	a, _read_next_command_read_index_65536_45+0
      008309 C1 04 AE         [ 1]  238 	cp	a, _command_number+0
      00830C 26 03            [ 1]  239 	jrne	00103$
                                    240 ;	src/uart_commands/uart_commands.c: 104: __asm__("wfi");
      00830E 8F               [10]  241 	wfi
      00830F 20 F5            [ 2]  242 	jra	00101$
      008311                        243 00103$:
                                    244 ;	src/uart_commands/uart_commands.c: 107: command = command_buffer[read_index];
      008311 5F               [ 1]  245 	clrw	x
      008312 C6 00 A2         [ 1]  246 	ld	a, _read_next_command_read_index_65536_45+0
      008315 97               [ 1]  247 	ld	xl, a
      008316 58               [ 2]  248 	sllw	x
      008317 DE 00 01         [ 2]  249 	ldw	x, (_command_buffer+0, x)
                                    250 ;	src/uart_commands/uart_commands.c: 109: read_index++;
      00831A 72 5C 00 A2      [ 1]  251 	inc	_read_next_command_read_index_65536_45+0
                                    252 ;	src/uart_commands/uart_commands.c: 111: if (read_index > (COMMAND_BUFFER_SIZE - 1)) {
      00831E C6 00 A2         [ 1]  253 	ld	a, _read_next_command_read_index_65536_45+0
      008321 A1 0F            [ 1]  254 	cp	a, #0x0f
      008323 22 01            [ 1]  255 	jrugt	00126$
      008325 81               [ 4]  256 	ret
      008326                        257 00126$:
                                    258 ;	src/uart_commands/uart_commands.c: 112: read_index = 0;
      008326 72 5F 00 A2      [ 1]  259 	clr	_read_next_command_read_index_65536_45+0
                                    260 ;	src/uart_commands/uart_commands.c: 115: return command;
                                    261 ;	src/uart_commands/uart_commands.c: 116: }
      00832A 81               [ 4]  262 	ret
                                    263 ;	src/uart_commands/uart_commands.c: 121: uart2_tx_isr(void) __interrupt(IRQ_UART2_TX) {
                                    264 ;	-----------------------------------------
                                    265 ;	 function uart2_tx_isr
                                    266 ;	-----------------------------------------
      00832B                        267 _uart2_tx_isr:
                                    268 ;	src/uart_commands/uart_commands.c: 125: UART2_DR = uart_tx_buf[i];
      00832B C6 00 A1         [ 1]  269 	ld	a, _uart_tx_buf+1
      00832E CB 00 A3         [ 1]  270 	add	a, _uart2_tx_isr_i_65536_48+0
      008331 97               [ 1]  271 	ld	xl, a
      008332 C6 00 A0         [ 1]  272 	ld	a, _uart_tx_buf+0
      008335 A9 00            [ 1]  273 	adc	a, #0x00
      008337 95               [ 1]  274 	ld	xh, a
      008338 F6               [ 1]  275 	ld	a, (x)
      008339 C7 52 41         [ 1]  276 	ld	0x5241, a
                                    277 ;	src/uart_commands/uart_commands.c: 127: if (uart_tx_buf[i] == '\0') {
      00833C C6 00 A1         [ 1]  278 	ld	a, _uart_tx_buf+1
      00833F CB 00 A3         [ 1]  279 	add	a, _uart2_tx_isr_i_65536_48+0
      008342 97               [ 1]  280 	ld	xl, a
      008343 C6 00 A0         [ 1]  281 	ld	a, _uart_tx_buf+0
      008346 A9 00            [ 1]  282 	adc	a, #0x00
      008348 95               [ 1]  283 	ld	xh, a
      008349 F6               [ 1]  284 	ld	a, (x)
      00834A 26 0C            [ 1]  285 	jrne	00102$
                                    286 ;	src/uart_commands/uart_commands.c: 128: uart_tx_done = 1;
      00834C AE 00 01         [ 2]  287 	ldw	x, #0x0001
      00834F CF 04 AF         [ 2]  288 	ldw	_uart_tx_done+0, x
                                    289 ;	src/uart_commands/uart_commands.c: 129: i = 1;
      008352 35 01 00 A3      [ 1]  290 	mov	_uart2_tx_isr_i_65536_48+0, #0x01
                                    291 ;	src/uart_commands/uart_commands.c: 130: return;
      008356 20 04            [ 2]  292 	jra	00103$
      008358                        293 00102$:
                                    294 ;	src/uart_commands/uart_commands.c: 133: i++;
      008358 72 5C 00 A3      [ 1]  295 	inc	_uart2_tx_isr_i_65536_48+0
      00835C                        296 00103$:
                                    297 ;	src/uart_commands/uart_commands.c: 134: }
      00835C 80               [11]  298 	iret
                                    299 ;	src/uart_commands/uart_commands.c: 139: uart2_rx_isr(void) __interrupt(IRQ_UART2_RX) {
                                    300 ;	-----------------------------------------
                                    301 ;	 function uart2_rx_isr
                                    302 ;	-----------------------------------------
      00835D                        303 _uart2_rx_isr:
      00835D 52 02            [ 2]  304 	sub	sp, #2
                                    305 ;	src/uart_commands/uart_commands.c: 145: command = command_buffer[command_number];
      00835F C6 04 AE         [ 1]  306 	ld	a, _command_number+0
      008362 5F               [ 1]  307 	clrw	x
      008363 97               [ 1]  308 	ld	xl, a
      008364 58               [ 2]  309 	sllw	x
      008365 DE 00 01         [ 2]  310 	ldw	x, (_command_buffer+0, x)
      008368 1F 01            [ 2]  311 	ldw	(0x01, sp), x
                                    312 ;	src/uart_commands/uart_commands.c: 149: command[byte_index] = UART2_DR;
      00836A 5F               [ 1]  313 	clrw	x
      00836B C6 00 A4         [ 1]  314 	ld	a, _uart2_rx_isr_byte_index_65536_51+0
      00836E 97               [ 1]  315 	ld	xl, a
      00836F 72 FB 01         [ 2]  316 	addw	x, (0x01, sp)
      008372 C6 52 41         [ 1]  317 	ld	a, 0x5241
      008375 F7               [ 1]  318 	ld	(x), a
                                    319 ;	src/uart_commands/uart_commands.c: 151: if (command[byte_index] == '\n') {
      008376 5F               [ 1]  320 	clrw	x
      008377 C6 00 A4         [ 1]  321 	ld	a, _uart2_rx_isr_byte_index_65536_51+0
      00837A 97               [ 1]  322 	ld	xl, a
      00837B 72 FB 01         [ 2]  323 	addw	x, (0x01, sp)
      00837E F6               [ 1]  324 	ld	a, (x)
      00837F A1 0A            [ 1]  325 	cp	a, #0x0a
      008381 26 15            [ 1]  326 	jrne	00104$
                                    327 ;	src/uart_commands/uart_commands.c: 153: byte_index = 0;
      008383 72 5F 00 A4      [ 1]  328 	clr	_uart2_rx_isr_byte_index_65536_51+0
                                    329 ;	src/uart_commands/uart_commands.c: 155: command_number++;
      008387 72 5C 04 AE      [ 1]  330 	inc	_command_number+0
                                    331 ;	src/uart_commands/uart_commands.c: 157: if (command_number > (COMMAND_BUFFER_SIZE - 1)) {
      00838B C6 04 AE         [ 1]  332 	ld	a, _command_number+0
      00838E A1 0F            [ 1]  333 	cp	a, #0x0f
      008390 23 15            [ 2]  334 	jrule	00107$
                                    335 ;	src/uart_commands/uart_commands.c: 158: command_number = 0;
      008392 72 5F 04 AE      [ 1]  336 	clr	_command_number+0
                                    337 ;	src/uart_commands/uart_commands.c: 161: return;
      008396 20 0F            [ 2]  338 	jra	00107$
      008398                        339 00104$:
                                    340 ;	src/uart_commands/uart_commands.c: 164: byte_index++;
      008398 72 5C 00 A4      [ 1]  341 	inc	_uart2_rx_isr_byte_index_65536_51+0
                                    342 ;	src/uart_commands/uart_commands.c: 166: if (byte_index > (MAX_COMMAND_LENGTH - 1))
      00839C C6 00 A4         [ 1]  343 	ld	a, _uart2_rx_isr_byte_index_65536_51+0
      00839F A1 11            [ 1]  344 	cp	a, #0x11
      0083A1 23 04            [ 2]  345 	jrule	00107$
                                    346 ;	src/uart_commands/uart_commands.c: 167: byte_index = 0;
      0083A3 72 5F 00 A4      [ 1]  347 	clr	_uart2_rx_isr_byte_index_65536_51+0
      0083A7                        348 00107$:
                                    349 ;	src/uart_commands/uart_commands.c: 168: }
      0083A7 5B 02            [ 2]  350 	addw	sp, #2
      0083A9 80               [11]  351 	iret
                                    352 	.area CODE
                                    353 	.area CONST
                                    354 	.area INITIALIZER
      008041                        355 __xinit__command_number:
      008041 00                     356 	.db #0x00	; 0
      008042                        357 __xinit__uart_tx_done:
      008042 00 00                  358 	.dw #0x0000
                                    359 	.area CABS (ABS)
