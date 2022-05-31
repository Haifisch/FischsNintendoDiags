;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _send_data_str
	.globl _wait_for_start
	.globl _cls
	.globl _puts
	.globl _printf
	.globl _wait_vbl_done
	.globl _delay
	.globl _receive_byte
	.globl _send_byte
	.globl _test_data_str
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;src/main.c:9: void wait_for_start() 
;	---------------------------------
; Function wait_for_start
; ---------------------------------
_wait_for_start::
	add	sp, #-6
;src/main.c:11: UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#4
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x73
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	inc	bc
	ld	a, #0x74
	ld	(bc), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	inc	bc
	inc	bc
	ld	a, #0x72
	ld	(bc), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, #0x74
	ld	(bc), a
;src/main.c:13: for (int i = 0; i < 4; ++i)
	ld	bc, #0x0000
00110$:
	ld	a, c
	sub	a, #0x04
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00108$
;src/main.c:15: receive_byte();
	push	bc
	call	_receive_byte
	pop	bc
;src/main.c:17: while (_io_status == IO_RECEIVING);
00101$:
	ld	a, (#__io_status)
	sub	a, #0x02
	jr	Z, 00101$
;src/main.c:18: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/main.c:19: printf("i/o error!\n");
	ld	de, #___str_1
	push	de
	call	_puts
	pop	hl
;src/main.c:20: break;
	jr	00108$
00105$:
;src/main.c:22: if (_io_in == start[i]) {
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	a, (#__io_in)
	sub	a, e
	jr	NZ, 00111$
;src/main.c:23: printf("%c", _io_in);
	ld	hl, #__io_in
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00111$:
;src/main.c:13: for (int i = 0; i < 4; ++i)
	inc	bc
	jr	00110$
00108$:
;src/main.c:26: printf("\n"); 
	ld	de, #___str_4
	push	de
	call	_puts
	pop	hl
;src/main.c:27: }
	add	sp, #6
	ret
_test_data_str:
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x48	; 72	'H'
	.db #0x53	; 83	'S'
	.db #0x20	; 32
	.db #0x44	; 68	'D'
	.db #0x49	; 73	'I'
	.db #0x41	; 65	'A'
	.db #0x47	; 71	'G'
	.db #0x53	; 83	'S'
	.db #0x20	; 32
	.db #0x43	; 67	'C'
	.db #0x4f	; 79	'O'
	.db #0x4d	; 77	'M'
	.db #0x4d	; 77	'M'
	.db #0x20	; 32
	.db #0x54	; 84	'T'
	.db #0x45	; 69	'E'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x20	; 32
	.db #0x44	; 68	'D'
	.db #0x41	; 65	'A'
	.db #0x54	; 84	'T'
	.db #0x41	; 65	'A'
	.db #0x20	; 32
	.db #0x4c	; 76	'L'
	.db #0x49	; 73	'I'
	.db #0x4e	; 78	'N'
	.db #0x4b	; 75	'K'
___str_1:
	.ascii "i/o error!"
	.db 0x00
___str_2:
	.ascii "%c"
	.db 0x00
___str_4:
	.db 0x00
;src/main.c:29: void send_data_str() 
;	---------------------------------
; Function send_data_str
; ---------------------------------
_send_data_str::
	dec	sp
;src/main.c:31: for (int i = 0; i < 0x20; ++i)
	ld	bc, #0x0000
00111$:
	ld	a, c
	sub	a, #0x20
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00109$
;src/main.c:33: _io_out = test_data_str[i];
	ld	hl, #_test_data_str
	add	hl, bc
	ld	a, (hl)
	ld	(#__io_out),a
;src/main.c:34: send_byte();
	push	bc
	call	_send_byte
	pop	bc
;src/main.c:35: while(_io_status == IO_SENDING);
00101$:
	ld	a, (#__io_status)
	dec	a
	jr	Z, 00101$
;src/main.c:36: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/main.c:37: printf("i/o error!\n");
	ld	de, #___str_6
	push	de
	call	_puts
	pop	hl
;src/main.c:38: break;
	jr	00109$
00105$:
;src/main.c:40: if (test_data_str[i] == 0x20) {
	ld	hl, #_test_data_str
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,#0
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x20
	jr	NZ, 00107$
;src/main.c:41: printf("\n");
	push	bc
	ld	de, #___str_8
	push	de
	call	_puts
	pop	hl
	pop	bc
	jr	00108$
00107$:
;src/main.c:43: printf("%c", test_data_str[i]);
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_9
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00108$:
;src/main.c:45: delay(100);
	push	bc
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
	pop	bc
;src/main.c:31: for (int i = 0; i < 0x20; ++i)
	inc	bc
	jr	00111$
00109$:
;src/main.c:47: printf("\n"); 
	ld	de, #___str_8
	push	de
	call	_puts
	pop	hl
;src/main.c:48: }
	inc	sp
	ret
___str_6:
	.ascii "i/o error!"
	.db 0x00
___str_8:
	.db 0x00
___str_9:
	.ascii "%c"
	.db 0x00
;src/main.c:51: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
;src/main.c:54: while(1) {
00102$:
;src/main.c:55: cls();
	call	_cls
;src/main.c:56: printf("waiting for init\n");
	ld	de, #___str_12
	push	de
	call	_puts
	pop	hl
;src/main.c:57: wait_for_start();
	call	_wait_for_start
;src/main.c:58: printf("received init!\nsending big string\n");
	ld	de, #___str_14
	push	de
	call	_puts
	pop	hl
;src/main.c:59: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/main.c:60: send_data_str();
	call	_send_data_str
;src/main.c:61: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/main.c:62: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:64: }
	jr	00102$
___str_12:
	.ascii "waiting for init"
	.db 0x00
___str_14:
	.ascii "received init!"
	.db 0x0a
	.ascii "sending big string"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
