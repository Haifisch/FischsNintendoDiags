;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module gblink
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_gblink_test
	.globl _gblink_test
	.globl b___func_gblink_test
	.globl ___func_gblink_test
	.globl b_superuser_enter_hostmode
	.globl _superuser_enter_hostmode
	.globl b___func_superuser_enter_hostmode
	.globl ___func_superuser_enter_hostmode
	.globl b_superuser_hold
	.globl _superuser_hold
	.globl b___func_superuser_hold
	.globl ___func_superuser_hold
	.globl _send_data_str
	.globl _wait_for_start
	.globl _receive_data_str
	.globl _show_gblink_background
	.globl _set_bkg_palette
	.globl b_text_print_char_bkg
	.globl _text_print_char_bkg
	.globl b_text_print_string_bkg
	.globl _text_print_string_bkg
	.globl _puts
	.globl _printf
	.globl _cls
	.globl _EMU_printf
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _joypad
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
___EMU_PROFILER_INIT:
	.ds 2
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
	.area _CODE_1
;src/test_impl/gblink.c:23: void show_gblink_background() 
;	---------------------------------
; Function show_gblink_background
; ---------------------------------
_show_gblink_background::
;src/test_impl/gblink.c:25: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/test_impl/gblink.c:26: set_bkg_palette(1, 1, &gblink_bg_palettes[4]);
	ld	de, #(_gblink_bg_palettes + 8)
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/gblink.c:27: set_bkg_palette(0, 1, &gblink_bg_palettes[0]);
	ld	de, #_gblink_bg_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/gblink.c:29: set_bkg_data(0, gblink_bg_TILE_COUNT, gblink_bg_tiles);
	ld	de, #_gblink_bg_tiles
	push	de
	ld	hl, #0x5200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/test_impl/gblink.c:30: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/test_impl/gblink.c:31: set_tile_map(0, 0, 20, 18, gblink_bg_map_attributes);
	ld	de, #_gblink_bg_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/gblink.c:32: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/test_impl/gblink.c:33: set_tile_map(0, 0, 20, 18, gblink_bg_map);
	ld	de, #_gblink_bg_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/gblink.c:34: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/test_impl/gblink.c:35: }
	ret
_test_data_str:
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x48	; 72	'H'
	.db #0x53	; 83	'S'
	.db #0x2d	; 45
	.db #0x44	; 68	'D'
	.db #0x49	; 73	'I'
	.db #0x41	; 65	'A'
	.db #0x47	; 71	'G'
	.db #0x53	; 83	'S'
	.db #0x2d	; 45
	.db #0x56	; 86	'V'
	.db #0x33	; 51	'3'
	.db #0x2d	; 45
	.db #0x47	; 71	'G'
	.db #0x42	; 66	'B'
	.db #0x2d	; 45
	.db #0x4c	; 76	'L'
	.db #0x49	; 73	'I'
	.db #0x4e	; 78	'N'
	.db #0x4b	; 75	'K'
	.db #0x2d	; 45
	.db #0x43	; 67	'C'
	.db #0x4f	; 79	'O'
	.db #0x4d	; 77	'M'
	.db #0x4d	; 77	'M'
	.db #0x55	; 85	'U'
	.db #0x4e	; 78	'N'
	.db #0x49	; 73	'I'
	.db #0x43	; 67	'C'
	.db #0x41	; 65	'A'
	.db #0x54	; 84	'T'
	.db #0x49	; 73	'I'
	.db #0x4f	; 79	'O'
	.db #0x4e	; 78	'N'
	.db #0x2d	; 45
	.db #0x54	; 84	'T'
	.db #0x45	; 69	'E'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x2d	; 45
	.db #0x50	; 80	'P'
	.db #0x41	; 65	'A'
	.db #0x53	; 83	'S'
	.db #0x53	; 83	'S'
	.db #0x20	; 32
;src/test_impl/gblink.c:37: void receive_data_str()
;	---------------------------------
; Function receive_data_str
; ---------------------------------
_receive_data_str::
	dec	sp
	dec	sp
;src/test_impl/gblink.c:40: uint8_t recv_x = 0;
;src/test_impl/gblink.c:41: for (int i = 0; i < 0x30; ++i)
	ld	bc, #0x500
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
00111$:
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x30
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00145$
	bit	7, d
	jr	NZ, 00146$
	cp	a, a
	jr	00146$
00145$:
	bit	7, d
	jr	Z, 00146$
	scf
00146$:
	jr	NC, 00113$
;src/test_impl/gblink.c:43: receive_byte();
	push	bc
	call	_receive_byte
	pop	bc
;src/test_impl/gblink.c:45: while (_io_status == IO_RECEIVING);
00101$:
	ld	a, (#__io_status)
	sub	a, #0x02
	jr	Z, 00101$
;src/test_impl/gblink.c:46: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/test_impl/gblink.c:47: text_print_string_bkg(1, 4, "failed to comm...");
	ld	de, #___str_0
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/test_impl/gblink.c:48: break;
	jr	00113$
00105$:
;src/test_impl/gblink.c:50: text_print_char_bkg(recv_x, recv_y, _io_in);
	push	bc
	ld	a, (#__io_in)
	push	af
	inc	sp
	push	bc
	ld	e, #b_text_print_char_bkg
	ld	hl, #_text_print_char_bkg
	call	___sdcc_bcall_ehl
	add	sp, #3
	ld	de, #0x0010
	push	de
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	__modsint
	add	sp, #4
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	pop	bc
	ld	a, d
	or	a, l
	jr	NZ, 00107$
;src/test_impl/gblink.c:52: recv_y++;
	inc	b
;src/test_impl/gblink.c:53: recv_x = 0;
	ld	c, #0x00
	jr	00112$
00107$:
;src/test_impl/gblink.c:55: recv_x++;
	inc	c
00112$:
;src/test_impl/gblink.c:41: for (int i = 0; i < 0x30; ++i)
	ldhl	sp,	#0
	inc	(hl)
	jr	NZ, 00111$
	inc	hl
	inc	(hl)
	jr	00111$
00113$:
;src/test_impl/gblink.c:58: }
	inc	sp
	inc	sp
	ret
___str_0:
	.ascii "failed to comm..."
	.db 0x00
;src/test_impl/gblink.c:60: void wait_for_start()
;	---------------------------------
; Function wait_for_start
; ---------------------------------
_wait_for_start::
	add	sp, #-6
;src/test_impl/gblink.c:62: UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
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
;src/test_impl/gblink.c:64: for (int i = 0; i < 4; ++i)
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
;src/test_impl/gblink.c:66: receive_byte();
	push	bc
	call	_receive_byte
	pop	bc
;src/test_impl/gblink.c:68: while (_io_status == IO_RECEIVING);
00101$:
	ld	a, (#__io_status)
	sub	a, #0x02
	jr	Z, 00101$
;src/test_impl/gblink.c:69: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/test_impl/gblink.c:70: printf("i/o error!\n");
	ld	de, #___str_2
	push	de
	call	_puts
	pop	hl
;src/test_impl/gblink.c:71: break;
	jr	00108$
00105$:
;src/test_impl/gblink.c:73: if (_io_in == start[i]) {
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
;src/test_impl/gblink.c:74: printf("%c", _io_in);
	ld	hl, #__io_in
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_3
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00111$:
;src/test_impl/gblink.c:64: for (int i = 0; i < 4; ++i)
	inc	bc
	jr	00110$
00108$:
;src/test_impl/gblink.c:77: printf("\n"); 
	ld	de, #___str_5
	push	de
	call	_puts
	pop	hl
;src/test_impl/gblink.c:78: }
	add	sp, #6
	ret
___str_2:
	.ascii "i/o error!"
	.db 0x00
___str_3:
	.ascii "%c"
	.db 0x00
___str_5:
	.db 0x00
;src/test_impl/gblink.c:80: void send_data_str()
;	---------------------------------
; Function send_data_str
; ---------------------------------
_send_data_str::
	dec	sp
;src/test_impl/gblink.c:82: for (int i = 0; i < 0x30; ++i)
	ld	bc, #0x0000
00111$:
	ld	a, c
	sub	a, #0x30
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00109$
;src/test_impl/gblink.c:84: _io_out = test_data_str[i];
	ld	hl, #_test_data_str
	add	hl, bc
	ld	a, (hl)
	ld	(#__io_out),a
;src/test_impl/gblink.c:85: send_byte();
	push	bc
	call	_send_byte
	pop	bc
;src/test_impl/gblink.c:86: while(_io_status == IO_SENDING);
00101$:
	ld	a, (#__io_status)
	dec	a
	jr	Z, 00101$
;src/test_impl/gblink.c:87: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/test_impl/gblink.c:88: printf("i/o error!\n");
	ld	de, #___str_7
	push	de
	call	_puts
	pop	hl
;src/test_impl/gblink.c:89: break;
	jr	00109$
00105$:
;src/test_impl/gblink.c:91: if (test_data_str[i] == 0x20) {
	ld	hl, #_test_data_str
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,#0
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x20
	jr	NZ, 00107$
;src/test_impl/gblink.c:92: printf("\n");
	push	bc
	ld	de, #___str_9
	push	de
	call	_puts
	pop	hl
	pop	bc
	jr	00108$
00107$:
;src/test_impl/gblink.c:94: printf("%c", test_data_str[i]);
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_10
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00108$:
;src/test_impl/gblink.c:96: delay(100);
	push	bc
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
	pop	bc
;src/test_impl/gblink.c:82: for (int i = 0; i < 0x30; ++i)
	inc	bc
	jr	00111$
00109$:
;src/test_impl/gblink.c:98: printf("\n"); 
	ld	de, #___str_9
	push	de
	call	_puts
	pop	hl
;src/test_impl/gblink.c:99: }
	inc	sp
	ret
___str_7:
	.ascii "i/o error!"
	.db 0x00
___str_9:
	.db 0x00
___str_10:
	.ascii "%c"
	.db 0x00
;src/test_impl/gblink.c:101: BANKREF(superuser_hold)
;	---------------------------------
; Function __func_superuser_hold
; ---------------------------------
	b___func_superuser_hold	= 1
___func_superuser_hold::
	.local b___func_superuser_hold 
	___bank_superuser_hold = b___func_superuser_hold 
	.globl ___bank_superuser_hold 
;src/test_impl/gblink.c:102: int superuser_hold() BANKED
;	---------------------------------
; Function superuser_hold
; ---------------------------------
	b_superuser_hold	= 1
_superuser_hold::
;src/test_impl/gblink.c:104: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_14
	push	de
	ld	de, #0x0068
	push	de
	ld	de, #___str_13
	push	de
	ld	de, #___str_12
	push	de
	call	_EMU_printf
	add	sp, #10
;src/test_impl/gblink.c:105: int isSuper = 0;
	ld	bc, #0x0000
;src/test_impl/gblink.c:107: while (delayInc > 0) {
	ld	hl, #0x0002
00105$:
	ld	e, h
	xor	a, a
	ld	d, a
	cp	a, l
	sbc	a, h
	bit	7, e
	jr	Z, 00130$
	bit	7, d
	jr	NZ, 00131$
	cp	a, a
	jr	00131$
00130$:
	bit	7, d
	jr	Z, 00131$
	scf
00131$:
	jr	NC, 00107$
;src/test_impl/gblink.c:111: if (joypad() & J_START && joypad() & J_SELECT) {
	push	hl
	call	_joypad
	ld	a, e
	pop	hl
	rlca
	jr	NC, 00102$
	push	hl
	call	_joypad
	pop	hl
	bit	6, e
	jr	Z, 00102$
;src/test_impl/gblink.c:112: isSuper = 1;
	ld	bc, #0x0001
;src/test_impl/gblink.c:113: printf("you are super.\n");
	push	bc
	ld	de, #___str_16
	push	de
	call	_puts
	pop	hl
	pop	bc
;src/test_impl/gblink.c:114: waitpadup();
	call	_waitpadup
;src/test_impl/gblink.c:115: break;
	jr	00107$
00102$:
;src/test_impl/gblink.c:117: isSuper = 0;
;src/test_impl/gblink.c:119: delayInc--;
	dec	hl
	ld	bc, #0x0000
;src/test_impl/gblink.c:120: delay(1000);
	push	hl
	push	bc
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
	pop	bc
	pop	hl
	jr	00105$
00107$:
;src/test_impl/gblink.c:122: return isSuper;
	ld	e, c
	ld	d, b
;src/test_impl/gblink.c:123: }
	ret
___str_12:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_13:
	.ascii "src/test_impl/gblink.c"
	.db 0x00
___str_14:
	.ascii "superuser_hold"
	.db 0x00
___str_16:
	.ascii "you are super."
	.db 0x00
;src/test_impl/gblink.c:125: BANKREF(superuser_enter_hostmode)
;	---------------------------------
; Function __func_superuser_enter_hostmode
; ---------------------------------
	b___func_superuser_enter_hostmode	= 1
___func_superuser_enter_hostmode::
	.local b___func_superuser_enter_hostmode 
	___bank_superuser_enter_hostmode = b___func_superuser_enter_hostmode 
	.globl ___bank_superuser_enter_hostmode 
;src/test_impl/gblink.c:126: void superuser_enter_hostmode() BANKED
;	---------------------------------
; Function superuser_enter_hostmode
; ---------------------------------
	b_superuser_enter_hostmode	= 1
_superuser_enter_hostmode::
;src/test_impl/gblink.c:128: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_19
	push	de
	xor	a, a
	push	af
	ld	de, #___str_18
	push	de
	ld	de, #___str_17
	push	de
	call	_EMU_printf
	add	sp, #10
;src/test_impl/gblink.c:130: while(1) {
00102$:
;src/test_impl/gblink.c:131: cls();
	call	_cls
;src/test_impl/gblink.c:132: printf("\n(SUPERUSER)\n\nwaiting for init\n");
	ld	de, #___str_21
	push	de
	call	_puts
	pop	hl
;src/test_impl/gblink.c:133: wait_for_start();
	call	_wait_for_start
;src/test_impl/gblink.c:134: printf("received init!\nsending test str\n");
	ld	de, #___str_23
	push	de
	call	_puts
	pop	hl
;src/test_impl/gblink.c:135: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/gblink.c:136: send_data_str();
	call	_send_data_str
;src/test_impl/gblink.c:137: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/test_impl/gblink.c:138: wait_vbl_done();
	call	_wait_vbl_done
;src/test_impl/gblink.c:140: }
	jr	00102$
___str_17:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_18:
	.ascii "src/test_impl/gblink.c"
	.db 0x00
___str_19:
	.ascii "superuser_enter_hostmode"
	.db 0x00
___str_21:
	.db 0x0a
	.ascii "(SUPERUSER)"
	.db 0x0a
	.db 0x0a
	.ascii "waiting for init"
	.db 0x00
___str_23:
	.ascii "received init!"
	.db 0x0a
	.ascii "sending test str"
	.db 0x00
;src/test_impl/gblink.c:142: BANKREF(gblink_test)
;	---------------------------------
; Function __func_gblink_test
; ---------------------------------
	b___func_gblink_test	= 1
___func_gblink_test::
	.local b___func_gblink_test 
	___bank_gblink_test = b___func_gblink_test 
	.globl ___bank_gblink_test 
;src/test_impl/gblink.c:143: int gblink_test() BANKED 
;	---------------------------------
; Function gblink_test
; ---------------------------------
	b_gblink_test	= 1
_gblink_test::
	add	sp, #-6
;src/test_impl/gblink.c:145: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_26
	push	de
	ld	de, #0x0091
	push	de
	ld	de, #___str_25
	push	de
	ld	de, #___str_24
	push	de
	call	_EMU_printf
	add	sp, #10
;src/test_impl/gblink.c:146: show_gblink_background();
	call	_show_gblink_background
;src/test_impl/gblink.c:149: UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
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
;src/test_impl/gblink.c:150: for (int i = 0; i < 4; ++i)
	ld	bc, #0x0000
00108$:
	ld	a, c
	sub	a, #0x04
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00106$
;src/test_impl/gblink.c:152: _io_out = start[i];
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(#__io_out),a
;src/test_impl/gblink.c:153: send_byte();
	push	bc
	call	_send_byte
	pop	bc
;src/test_impl/gblink.c:154: while (_io_status == IO_SENDING) 
00101$:
	ld	a, (#__io_status)
	dec	a
	jr	Z, 00101$
;src/test_impl/gblink.c:158: if (_io_status == IO_ERROR)
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/test_impl/gblink.c:160: text_print_string_bkg(1, 4, "failed to comm...");
	ld	de, #___str_27
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/test_impl/gblink.c:162: delay(2000);
	ld	de, #0x07d0
	push	de
	call	_delay
	pop	hl
;src/test_impl/gblink.c:163: return TEST_FAILED;
	ld	de, #0x0069
	jr	00110$
00105$:
;src/test_impl/gblink.c:165: delay(100);
	push	bc
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
	pop	bc
;src/test_impl/gblink.c:150: for (int i = 0; i < 4; ++i)
	inc	bc
	jr	00108$
00106$:
;src/test_impl/gblink.c:168: text_print_string_bkg(1, 4, "initiated comm...");
	ld	de, #___str_28
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/test_impl/gblink.c:169: receive_data_str();
	call	_receive_data_str
;src/test_impl/gblink.c:170: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/test_impl/gblink.c:171: return TEST_PASSED;
	ld	de, #0x0025
00110$:
;src/test_impl/gblink.c:172: } 
	add	sp, #6
	ret
___str_24:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_25:
	.ascii "src/test_impl/gblink.c"
	.db 0x00
___str_26:
	.ascii "gblink_test"
	.db 0x00
___str_27:
	.ascii "failed to comm..."
	.db 0x00
___str_28:
	.ascii "initiated comm..."
	.db 0x00
	.area _CODE_1
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
	.area _CABS (ABS)
