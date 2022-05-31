;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module gblink
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gblink_test
	.globl _receive_data_str
	.globl _show_gblink_background
	.globl _set_bkg_palette
	.globl _text_print_char_bkg
	.globl _text_print_string_bkg
	.globl _blank_display
	.globl _EMU_printf
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _delay
	.globl _receive_byte
	.globl _send_byte
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
	.area _CODE
;src/test_impl/gblink.c:11: void show_gblink_background() {
;	---------------------------------
; Function show_gblink_background
; ---------------------------------
_show_gblink_background::
;src/test_impl/gblink.c:12: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/test_impl/gblink.c:13: set_bkg_palette(1, 1, &gblink_bg_palettes[4]);
	ld	de, #(_gblink_bg_palettes + 8)
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/gblink.c:14: set_bkg_palette(0, 1, &gblink_bg_palettes[0]);
	ld	de, #_gblink_bg_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/gblink.c:16: set_bkg_data(0x0, gblink_bg_TILE_COUNT, gblink_bg_tiles);
	ld	de, #_gblink_bg_tiles
	push	de
	ld	hl, #0x5200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/test_impl/gblink.c:17: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/test_impl/gblink.c:18: set_bkg_tiles(0, 0, 20, 18, gblink_bg_map_attributes);
	ld	de, #_gblink_bg_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/gblink.c:19: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/test_impl/gblink.c:20: set_bkg_tiles(0, 0, 20, 18, gblink_bg_map);
	ld	de, #_gblink_bg_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/gblink.c:21: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/test_impl/gblink.c:22: }
	ret
;src/test_impl/gblink.c:25: void receive_data_str() {
;	---------------------------------
; Function receive_data_str
; ---------------------------------
_receive_data_str::
	dec	sp
	dec	sp
;src/test_impl/gblink.c:27: uint8_t recv_x = 1;
;src/test_impl/gblink.c:28: for (int i = 0; i < 0x20; ++i)
	ld	bc, #0x501
	xor	a, a
	ldhl	sp,	#0
	ld	(hl+), a
	ld	(hl), a
00111$:
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, #0x20
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
;src/test_impl/gblink.c:30: receive_byte();
	push	bc
	call	_receive_byte
	pop	bc
;src/test_impl/gblink.c:32: while (_io_status == IO_RECEIVING);
00101$:
	ld	a, (#__io_status)
	sub	a, #0x02
	jr	Z, 00101$
;src/test_impl/gblink.c:33: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/test_impl/gblink.c:34: text_print_string_bkg(1, 4, "failed to comm...");
	ld	de, #___str_0
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/gblink.c:35: break;
	jr	00113$
00105$:
;src/test_impl/gblink.c:37: text_print_char_bkg(recv_x, recv_y, _io_in);
	push	bc
	ld	a, (#__io_in)
	push	af
	inc	sp
	push	bc
	call	_text_print_char_bkg
	add	sp, #3
	pop	bc
;src/test_impl/gblink.c:38: if (_io_in == ' ') {
	ld	a, (#__io_in)
	sub	a, #0x20
	jr	NZ, 00107$
;src/test_impl/gblink.c:39: recv_y++;
	inc	b
;src/test_impl/gblink.c:40: recv_x = 1;
	ld	c, #0x01
	jr	00112$
00107$:
;src/test_impl/gblink.c:42: recv_x++;
	inc	c
00112$:
;src/test_impl/gblink.c:28: for (int i = 0; i < 0x20; ++i)
	ldhl	sp,	#0
	inc	(hl)
	jr	NZ, 00111$
	inc	hl
	inc	(hl)
	jr	00111$
00113$:
;src/test_impl/gblink.c:45: }
	inc	sp
	inc	sp
	ret
___str_0:
	.ascii "failed to comm..."
	.db 0x00
;src/test_impl/gblink.c:47: int gblink_test() {
;	---------------------------------
; Function gblink_test
; ---------------------------------
_gblink_test::
	add	sp, #-6
;src/test_impl/gblink.c:48: PRINT_FUNC_INFO;
	ld	de, #___str_3
	push	de
	ld	de, #0x0030
	push	de
	ld	de, #___str_2
	push	de
	ld	de, #___str_1
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/gblink.c:49: blank_display();
	call	_blank_display
;src/test_impl/gblink.c:50: show_gblink_background();
	call	_show_gblink_background
;src/test_impl/gblink.c:53: UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
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
;src/test_impl/gblink.c:54: for (int i = 0; i < 4; ++i)
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
;src/test_impl/gblink.c:56: _io_out = start[i];
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	(#__io_out),a
;src/test_impl/gblink.c:57: send_byte();
	push	bc
	call	_send_byte
	pop	bc
;src/test_impl/gblink.c:58: while (_io_status == IO_SENDING) 
00101$:
	ld	a, (#__io_status)
	dec	a
	jr	Z, 00101$
;src/test_impl/gblink.c:62: if (_io_status == IO_ERROR)
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/test_impl/gblink.c:64: text_print_string_bkg(1, 4, "failed to comm...");
	ld	de, #___str_4
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/gblink.c:65: delay(2000);
	ld	de, #0x07d0
	push	de
	call	_delay
	pop	hl
;src/test_impl/gblink.c:66: return TEST_FAILED;
	ld	de, #0x0069
	jr	00110$
00105$:
;src/test_impl/gblink.c:68: delay(100);
	push	bc
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
	pop	bc
;src/test_impl/gblink.c:54: for (int i = 0; i < 4; ++i)
	inc	bc
	jr	00108$
00106$:
;src/test_impl/gblink.c:71: text_print_string_bkg(1, 4, "initiated comm...");
	ld	de, #___str_5
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/gblink.c:72: receive_data_str();
	call	_receive_data_str
;src/test_impl/gblink.c:73: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/test_impl/gblink.c:74: return TEST_PASSED;
	ld	de, #0x0025
00110$:
;src/test_impl/gblink.c:75: } 
	add	sp, #6
	ret
___str_1:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_2:
	.ascii "src/test_impl/gblink.c"
	.db 0x00
___str_3:
	.ascii "gblink_test"
	.db 0x00
___str_4:
	.ascii "failed to comm..."
	.db 0x00
___str_5:
	.ascii "initiated comm..."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
	.area _CABS (ABS)
