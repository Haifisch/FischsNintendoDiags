;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module button_test
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _button_test
	.globl _buttons_sequence
	.globl _button_test_blank
	.globl _cleanup_arrow_sprites
	.globl _next_button
	.globl _next_arrow
	.globl _blank_display
	.globl _text_print_string_bkg
	.globl _text_load_font
	.globl _EMU_printf
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
	.globl _delay
	.globl _arrow_center_x
	.globl _primaryButtonBits
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_primaryButtonBits::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
___EMU_PROFILER_INIT:
	.ds 2
_arrow_center_x::
	.ds 1
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
;src/test_impl/button_test.c:23: void next_arrow(uint8_t startIndex) { // UP = 0, RIGHT = 16, DOWN = 32, LEFT = 48
;	---------------------------------
; Function next_arrow
; ---------------------------------
_next_arrow::
	add	sp, #-5
;src/test_impl/button_test.c:24: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:25: set_sprite_data(0, BUTTON_ARROW_TILE_COUNT, BUTTON_ARROW);
	ld	de, #_BUTTON_ARROW
	push	de
	ld	hl, #0x4000
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/test_impl/button_test.c:26: uint8_t arrow_tile_idx = startIndex;
	ldhl	sp,	#7
	ld	c, (hl)
;src/test_impl/button_test.c:27: uint8_t arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
;src/test_impl/button_test.c:28: uint8_t arrow_y = 64;
	ld	(hl+), a
	ld	(hl), #0x40
;src/test_impl/button_test.c:29: for (uint8_t i = 0; i < 16; ++i)
	ld	e, #0x00
00107$:
	ld	a, e
	sub	a, #0x10
	jr	NC, 00101$
;X:/gbc_hacks/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	b, (hl)
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, #<(_shadow_OAM)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	adc	a, #>(_shadow_OAM)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	(hl), c
;src/test_impl/button_test.c:32: arrow_tile_idx += 1;
	inc	c
;src/test_impl/button_test.c:29: for (uint8_t i = 0; i < 16; ++i)
	inc	e
	jr	00107$
00101$:
;src/test_impl/button_test.c:34: uint8_t arrow_tile = 0;
;src/test_impl/button_test.c:35: for (uint8_t q = 0; q < 4; ++q)
	ld	bc, #0x0
00113$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00103$
;src/test_impl/button_test.c:37: for (uint8_t t = 0; t < 4; ++t)
	ldhl	sp,	#4
	ld	(hl), #0x00
00110$:
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00124$
;X:/gbc_hacks/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;X:/gbc_hacks/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/test_impl/button_test.c:40: arrow_x += 8;
	ld	a, (hl)
	add	a, #0x08
;src/test_impl/button_test.c:41: arrow_tile++;
;src/test_impl/button_test.c:37: for (uint8_t t = 0; t < 4; ++t)
	ld	(hl+), a
	inc	hl
	inc	b
	inc	(hl)
	jr	00110$
00124$:
;src/test_impl/button_test.c:43: arrow_y += 8;
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;src/test_impl/button_test.c:44: arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
	ld	(hl), a
;src/test_impl/button_test.c:35: for (uint8_t q = 0; q < 4; ++q)
	inc	c
	jr	00113$
00103$:
;src/test_impl/button_test.c:46: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:47: }
	add	sp, #5
	ret
;src/test_impl/button_test.c:49: void next_button(uint8_t startIndex) {
;	---------------------------------
; Function next_button
; ---------------------------------
_next_button::
	add	sp, #-5
;src/test_impl/button_test.c:50: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:51: set_sprite_data(64, BUTTONS_TILE_COUNT, BUTTONS);
	ld	de, #_BUTTONS
	push	de
	ld	hl, #0x4040
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/test_impl/button_test.c:52: uint8_t arrow_tile_idx = 64 + startIndex;
	ldhl	sp,	#7
	ld	a, (hl)
	add	a, #0x40
	ld	c, a
;src/test_impl/button_test.c:53: uint8_t arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
;src/test_impl/button_test.c:54: uint8_t arrow_y = 64;
	ld	(hl+), a
	ld	(hl), #0x40
;src/test_impl/button_test.c:55: for (uint8_t i = 16; i < 32; ++i)
	ld	e, #0x10
00107$:
	ld	a, e
	sub	a, #0x20
	jr	NC, 00101$
;X:/gbc_hacks/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	ld	b, (hl)
	add	a, a
	rl	b
	add	a, a
	rl	b
	add	a, #<(_shadow_OAM)
	ld	l, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, b
	adc	a, #>(_shadow_OAM)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	ld	(hl), c
;src/test_impl/button_test.c:58: arrow_tile_idx += 1;
	inc	c
;src/test_impl/button_test.c:55: for (uint8_t i = 16; i < 32; ++i)
	inc	e
	jr	00107$
00101$:
;src/test_impl/button_test.c:60: uint8_t arrow_tile = 16;
;src/test_impl/button_test.c:61: for (uint8_t q = 0; q < 4; ++q)
	ld	bc, #0x1000
00113$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00103$
;src/test_impl/button_test.c:63: for (uint8_t t = 0; t < 4; ++t)
	ldhl	sp,	#4
	ld	(hl), #0x00
00110$:
	ldhl	sp,	#4
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00124$
;X:/gbc_hacks/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	e, l
	ld	d, h
;X:/gbc_hacks/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/test_impl/button_test.c:66: arrow_x += 8;
	ld	a, (hl)
	add	a, #0x08
;src/test_impl/button_test.c:67: arrow_tile++;
;src/test_impl/button_test.c:63: for (uint8_t t = 0; t < 4; ++t)
	ld	(hl+), a
	inc	hl
	inc	b
	inc	(hl)
	jr	00110$
00124$:
;src/test_impl/button_test.c:69: arrow_y += 8;
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;src/test_impl/button_test.c:70: arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
	ld	(hl), a
;src/test_impl/button_test.c:61: for (uint8_t q = 0; q < 4; ++q)
	inc	c
	jr	00113$
00103$:
;src/test_impl/button_test.c:72: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:73: }
	add	sp, #5
	ret
;src/test_impl/button_test.c:75: void cleanup_arrow_sprites() {
;	---------------------------------
; Function cleanup_arrow_sprites
; ---------------------------------
_cleanup_arrow_sprites::
;src/test_impl/button_test.c:76: for (uint8_t q = 0; q < 32; ++q)
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x20
	jr	NC, 00101$
;X:/gbc_hacks/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	de, #_shadow_OAM+0
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, de
;X:/gbc_hacks/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/test_impl/button_test.c:76: for (uint8_t q = 0; q < 32; ++q)
	inc	c
	jr	00104$
00101$:
;src/test_impl/button_test.c:80: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:81: }
	ret
;src/test_impl/button_test.c:83: void button_test_blank() {
;	---------------------------------
; Function button_test_blank
; ---------------------------------
_button_test_blank::
;src/test_impl/button_test.c:84: blank_display();
	call	_blank_display
;src/test_impl/button_test.c:85: wait_vbl_done();
	call	_wait_vbl_done
;src/test_impl/button_test.c:86: text_load_font();
	call	_text_load_font
;src/test_impl/button_test.c:87: text_print_string_bkg(3, 2, "Press the button");
	ld	de, #___str_0
	push	de
	ld	hl, #0x203
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/button_test.c:88: text_print_string_bkg(6, 3, "indicated");
	ld	de, #___str_1
	push	de
	ld	hl, #0x306
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/button_test.c:89: }
	ret
___str_0:
	.ascii "Press the button"
	.db 0x00
___str_1:
	.ascii "indicated"
	.db 0x00
;src/test_impl/button_test.c:91: void buttons_sequence() {
;	---------------------------------
; Function buttons_sequence
; ---------------------------------
_buttons_sequence::
;src/test_impl/button_test.c:94: button_test_blank();
	call	_button_test_blank
;src/test_impl/button_test.c:95: next_button(0);
	xor	a, a
	push	af
	inc	sp
	call	_next_button
	inc	sp
;src/test_impl/button_test.c:96: waitpad(J_A);
	ld	a, #0x10
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:97: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:99: next_button(16);
	ld	a, #0x10
	push	af
	inc	sp
	call	_next_button
	inc	sp
;src/test_impl/button_test.c:100: waitpad(J_B);
	ld	a, #0x20
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:101: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:103: button_test_blank();
	call	_button_test_blank
;src/test_impl/button_test.c:104: text_print_string_bkg(mid_screen-2, 12, "SELECT");
	ld	de, #___str_2
	push	de
	ld	hl, #0xc08
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/button_test.c:105: next_button(32);
	ld	a, #0x20
	push	af
	inc	sp
	call	_next_button
	inc	sp
;src/test_impl/button_test.c:106: waitpad(J_SELECT);
	ld	a, #0x40
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:107: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:109: button_test_blank();
	call	_button_test_blank
;src/test_impl/button_test.c:110: text_print_string_bkg(mid_screen-2, 12, "START");
	ld	de, #___str_3
	push	de
	ld	hl, #0xc08
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/button_test.c:111: next_button(48);
	ld	a, #0x30
	push	af
	inc	sp
	call	_next_button
	inc	sp
;src/test_impl/button_test.c:112: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:113: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:114: }
	ret
___str_2:
	.ascii "SELECT"
	.db 0x00
___str_3:
	.ascii "START"
	.db 0x00
;src/test_impl/button_test.c:116: int button_test() {
;	---------------------------------
; Function button_test
; ---------------------------------
_button_test::
	add	sp, #-3
;src/test_impl/button_test.c:117: PRINT_FUNC_INFO;
	ld	de, #___str_6
	push	de
	ld	de, #0x0075
	push	de
	ld	de, #___str_5
	push	de
	ld	de, #___str_4
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/button_test.c:120: uint8_t arrow_index = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/test_impl/button_test.c:121: button_test_blank();
	call	_button_test_blank
;src/test_impl/button_test.c:122: next_arrow(arrow_index);
	xor	a, a
	push	af
	inc	sp
	call	_next_arrow
	inc	sp
;src/test_impl/button_test.c:123: wait_vbl_done();
	call	_wait_vbl_done
;src/test_impl/button_test.c:124: while (1) {
00140$:
;src/test_impl/button_test.c:125: if (primaryButtonBits.up == 0) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	and	a,#0x01
	jr	NZ, 00116$
;src/test_impl/button_test.c:126: arrow_index = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
	jr	00117$
00116$:
;src/test_impl/button_test.c:127: } else if (primaryButtonBits.up && primaryButtonBits.right == 0) {
	ld	a, (#_primaryButtonBits)
	swap	a
	and	a,#0x01
	jr	Z, 00112$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	C, 00112$
;src/test_impl/button_test.c:128: arrow_index = 16;
	ldhl	sp,	#0
	ld	(hl), #0x10
	jr	00117$
00112$:
;src/test_impl/button_test.c:129: } else if (primaryButtonBits.up && primaryButtonBits.right && primaryButtonBits.down == 0) {
	ld	a, (#_primaryButtonBits)
	swap	a
	and	a,#0x01
	jr	Z, 00107$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	NC, 00107$
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	NZ, 00107$
;src/test_impl/button_test.c:130: arrow_index = 32;
	ldhl	sp,	#0
	ld	(hl), #0x20
	jr	00117$
00107$:
;src/test_impl/button_test.c:131: } else if (primaryButtonBits.up && primaryButtonBits.right && primaryButtonBits.down && primaryButtonBits.left == 0) {
	ld	a, (#_primaryButtonBits)
	swap	a
	and	a,#0x01
	jr	Z, 00117$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	NC, 00117$
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	Z, 00117$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	rlca
	jr	C, 00117$
;src/test_impl/button_test.c:132: arrow_index = 48;
	ldhl	sp,	#0
	ld	(hl), #0x30
00117$:
;src/test_impl/button_test.c:134: if (primaryButtonBits.up && primaryButtonBits.left && primaryButtonBits.down && primaryButtonBits.right) {
	ld	a, (#_primaryButtonBits)
	swap	a
	and	a,#0x01
	jr	Z, 00119$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	rlca
	jr	NC, 00119$
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	Z, 00119$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jp	C, 00141$
;src/test_impl/button_test.c:135: break;
00119$:
;src/test_impl/button_test.c:137: next_arrow(arrow_index);
	ldhl	sp,	#0
	ld	a, (hl)
	push	af
	inc	sp
	call	_next_arrow
	inc	sp
;src/test_impl/button_test.c:138: wait_vbl_done();
	call	_wait_vbl_done
;src/test_impl/button_test.c:139: if (primaryButtonBits.up == 0) {
	ld	a, (#_primaryButtonBits)
	swap	a
	and	a,#0x01
	jr	NZ, 00124$
;src/test_impl/button_test.c:140: primaryButtonBits.up = ((joypad() & J_UP) ? 1:0);
	ld	bc, #_primaryButtonBits
	call	_joypad
	bit	2, e
	ld	a, #0x01
	jr	NZ, 00145$
	xor	a, a
00145$:
	swap	a
	and	a, #0x10
	ld	l, a
	ld	a, (bc)
	and	a, #0xef
	or	a, l
	ld	(bc), a
00124$:
;src/test_impl/button_test.c:142: if (primaryButtonBits.down == 0) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	NZ, 00126$
;src/test_impl/button_test.c:143: primaryButtonBits.down = ((joypad() & J_DOWN) ? 1:0);
	call	_joypad
	bit	3, e
	jr	Z, 00146$
	ldhl	sp,	#1
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
	jr	00147$
00146$:
	xor	a, a
	ldhl	sp,	#1
	ld	(hl+), a
	ld	(hl), a
00147$:
	ldhl	sp,	#1
	ld	a, (hl)
	ld	hl, #_primaryButtonBits
	swap	a
	rlca
	and	a, #0x20
	ld	c, a
	ld	a, (hl)
	and	a, #0xdf
	or	a, c
	ld	(hl), a
00126$:
;src/test_impl/button_test.c:145: if (primaryButtonBits.left == 0) {
	ld	a, (#_primaryButtonBits + 0)
	rlca
	rlca
	jr	C, 00128$
;src/test_impl/button_test.c:146: primaryButtonBits.left = ((joypad() & J_LEFT) ? 1:0);
	ld	bc, #_primaryButtonBits
	call	_joypad
	bit	1, e
	ld	a, #0x01
	jr	NZ, 00149$
	xor	a, a
00149$:
	rrca
	rrca
	and	a, #0x40
	ld	l, a
	ld	a, (bc)
	and	a, #0xbf
	or	a, l
	ld	(bc), a
00128$:
;src/test_impl/button_test.c:148: if (primaryButtonBits.right == 0) {
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	C, 00130$
;src/test_impl/button_test.c:149: primaryButtonBits.right = ((joypad() & J_RIGHT) ? 1:0);
	ld	bc, #_primaryButtonBits
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00150$
	ld	a, #0x01
	jr	00151$
00150$:
	xor	a, a
00151$:
	rrca
	and	a, #0x80
	ld	l, a
	ld	a, (bc)
	and	a, #0x7f
	or	a, l
	ld	(bc), a
00130$:
;src/test_impl/button_test.c:151: if (primaryButtonBits.select == 0) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rlca
	jr	C, 00132$
;src/test_impl/button_test.c:152: primaryButtonBits.select = ((joypad() & J_SELECT) ? 1:0);
	ld	bc, #_primaryButtonBits
	call	_joypad
	bit	6, e
	ld	a, #0x01
	jr	NZ, 00153$
	xor	a, a
00153$:
	swap	a
	rrca
	and	a, #0x08
	ld	l, a
	ld	a, (bc)
	and	a, #0xf7
	or	a, l
	ld	(bc), a
00132$:
;src/test_impl/button_test.c:154: if (primaryButtonBits.start == 0) {
	ld	a, (#_primaryButtonBits + 0)
	rrca
	rrca
	and	a,#0x01
	jr	NZ, 00134$
;src/test_impl/button_test.c:155: primaryButtonBits.start = ((joypad() & J_START) ? 1:0);
	ld	bc, #_primaryButtonBits
	call	_joypad
	ld	a, e
	rlca
	jr	NC, 00154$
	ld	a, #0x01
	jr	00155$
00154$:
	xor	a, a
00155$:
	rlca
	rlca
	and	a, #0x04
	ld	l, a
	ld	a, (bc)
	and	a, #0xfb
	or	a, l
	ld	(bc), a
00134$:
;src/test_impl/button_test.c:157: if (primaryButtonBits.a == 0) {
	ld	a, (#_primaryButtonBits + 0)
	and	a,#0x01
	jr	NZ, 00136$
;src/test_impl/button_test.c:158: primaryButtonBits.a = ((joypad() & J_A) ? 1:0);
	ld	bc, #_primaryButtonBits
	call	_joypad
	bit	4, e
	ld	a, #0x01
	jr	NZ, 00157$
	xor	a, a
00157$:
	and	a, #0x01
	ld	l, a
	ld	a, (bc)
	and	a, #0xfe
	or	a, l
	ld	(bc), a
00136$:
;src/test_impl/button_test.c:160: if (primaryButtonBits.b == 0) {
	ld	a, (#_primaryButtonBits + 0)
	rrca
	and	a,#0x01
	jr	NZ, 00138$
;src/test_impl/button_test.c:161: primaryButtonBits.b = ((joypad() & J_B) ? 1:0);
	ld	bc, #_primaryButtonBits
	call	_joypad
	bit	5, e
	ld	a, #0x01
	jr	NZ, 00159$
	xor	a, a
00159$:
	rlca
	and	a, #0x02
	ld	l, a
	ld	a, (bc)
	and	a, #0xfd
	or	a, l
	ld	(bc), a
00138$:
;src/test_impl/button_test.c:163: waitpadup();
	call	_waitpadup
	jp	00140$
00141$:
;src/test_impl/button_test.c:166: cleanup_arrow_sprites();
	call	_cleanup_arrow_sprites
;src/test_impl/button_test.c:167: buttons_sequence();
	call	_buttons_sequence
;src/test_impl/button_test.c:169: cleanup_arrow_sprites();
	call	_cleanup_arrow_sprites
;src/test_impl/button_test.c:170: blank_display();
	call	_blank_display
;src/test_impl/button_test.c:171: wait_vbl_done();
	call	_wait_vbl_done
;src/test_impl/button_test.c:172: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:173: return TEST_PASSED;
	ld	de, #0x0025
;src/test_impl/button_test.c:174: }
	add	sp, #3
	ret
___str_4:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_5:
	.ascii "src/test_impl/button_test.c"
	.db 0x00
___str_6:
	.ascii "button_test"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
__xinit__arrow_center_x:
	.db #0x48	; 72	'H'
	.area _CABS (ABS)
