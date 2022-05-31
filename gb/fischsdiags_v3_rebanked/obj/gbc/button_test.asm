;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module button_test
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_button_test
	.globl _button_test
	.globl b___func_button_test
	.globl ___func_button_test
	.globl b_buttons_sequence
	.globl _buttons_sequence
	.globl b___func_buttons_sequence
	.globl ___func_buttons_sequence
	.globl b_next_button
	.globl _next_button
	.globl b___func_next_button
	.globl ___func_next_button
	.globl b_next_arrow
	.globl _next_arrow
	.globl b___func_next_arrow
	.globl ___func_next_arrow
	.globl _set_sprite_palette
	.globl _EMU_printf
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _waitpad
	.globl _joypad
	.globl _delay
	.globl _arrow_center_x
	.globl _primaryButtonBits
	.globl _button_test_palette
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
	.area _CODE_2
;src/test_impl/button_test.c:29: BANKREF(next_arrow)
;	---------------------------------
; Function __func_next_arrow
; ---------------------------------
	b___func_next_arrow	= 2
___func_next_arrow::
	.local b___func_next_arrow 
	___bank_next_arrow = b___func_next_arrow 
	.globl ___bank_next_arrow 
;src/test_impl/button_test.c:30: void next_arrow(uint8_t startIndex) BANKED
;	---------------------------------
; Function next_arrow
; ---------------------------------
	b_next_arrow	= 2
_next_arrow::
	add	sp, #-5
;src/test_impl/button_test.c:32: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:33: set_sprite_palette(0, 1, button_test_palette);
	ld	de, #_button_test_palette
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_palette
	add	sp, #4
;src/test_impl/button_test.c:34: set_sprite_data(0, BUTTON_ARROW_TILE_COUNT, BUTTON_ARROW);
	ld	de, #_BUTTON_ARROW
	push	de
	ld	hl, #0x4000
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/test_impl/button_test.c:35: uint8_t arrow_tile_idx = startIndex;
	ldhl	sp,	#11
	ld	c, (hl)
;src/test_impl/button_test.c:36: uint8_t arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
;src/test_impl/button_test.c:37: uint8_t arrow_y = 64;
	ld	(hl+), a
	ld	(hl), #0x40
;src/test_impl/button_test.c:38: for (uint8_t i = 0; i < 16; ++i)
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
;src/test_impl/button_test.c:41: arrow_tile_idx += 1;
	inc	c
;src/test_impl/button_test.c:38: for (uint8_t i = 0; i < 16; ++i)
	inc	e
	jr	00107$
00101$:
;src/test_impl/button_test.c:43: uint8_t arrow_tile = 0;
;src/test_impl/button_test.c:44: for (uint8_t q = 0; q < 4; ++q)
	ld	bc, #0x0
00113$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00103$
;src/test_impl/button_test.c:46: for (uint8_t t = 0; t < 4; ++t)
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
;src/test_impl/button_test.c:49: arrow_x += 8;
	ld	a, (hl)
	add	a, #0x08
;src/test_impl/button_test.c:50: arrow_tile++;
;src/test_impl/button_test.c:46: for (uint8_t t = 0; t < 4; ++t)
	ld	(hl+), a
	inc	hl
	inc	b
	inc	(hl)
	jr	00110$
00124$:
;src/test_impl/button_test.c:52: arrow_y += 8;
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;src/test_impl/button_test.c:53: arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
	ld	(hl), a
;src/test_impl/button_test.c:44: for (uint8_t q = 0; q < 4; ++q)
	inc	c
	jr	00113$
00103$:
;src/test_impl/button_test.c:55: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:56: }
	add	sp, #5
	ret
_button_test_palette:
	.dw #0x001f
	.dw #0x001f
	.dw #0x001f
	.dw #0x001f
;src/test_impl/button_test.c:58: BANKREF(next_button)
;	---------------------------------
; Function __func_next_button
; ---------------------------------
	b___func_next_button	= 2
___func_next_button::
	.local b___func_next_button 
	___bank_next_button = b___func_next_button 
	.globl ___bank_next_button 
;src/test_impl/button_test.c:59: void next_button(uint8_t startIndex) BANKED
;	---------------------------------
; Function next_button
; ---------------------------------
	b_next_button	= 2
_next_button::
	add	sp, #-5
;src/test_impl/button_test.c:61: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:62: set_sprite_data(64, BUTTONS_TILE_COUNT, BUTTONS);
	ld	de, #_BUTTONS
	push	de
	ld	hl, #0x4040
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/test_impl/button_test.c:63: uint8_t arrow_tile_idx = 64 + startIndex;
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, #0x40
	ld	c, a
;src/test_impl/button_test.c:64: uint8_t arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
;src/test_impl/button_test.c:65: uint8_t arrow_y = 64;
	ld	(hl+), a
	ld	(hl), #0x40
;src/test_impl/button_test.c:66: for (uint8_t i = 16; i < 32; ++i)
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
;src/test_impl/button_test.c:69: arrow_tile_idx += 1;
	inc	c
;src/test_impl/button_test.c:66: for (uint8_t i = 16; i < 32; ++i)
	inc	e
	jr	00107$
00101$:
;src/test_impl/button_test.c:71: uint8_t arrow_tile = 16;
;src/test_impl/button_test.c:72: for (uint8_t q = 0; q < 4; ++q)
	ld	bc, #0x1000
00113$:
	ld	a, c
	sub	a, #0x04
	jr	NC, 00103$
;src/test_impl/button_test.c:74: for (uint8_t t = 0; t < 4; ++t)
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
;src/test_impl/button_test.c:77: arrow_x += 8;
	ld	a, (hl)
	add	a, #0x08
;src/test_impl/button_test.c:78: arrow_tile++;
;src/test_impl/button_test.c:74: for (uint8_t t = 0; t < 4; ++t)
	ld	(hl+), a
	inc	hl
	inc	b
	inc	(hl)
	jr	00110$
00124$:
;src/test_impl/button_test.c:80: arrow_y += 8;
	ldhl	sp,	#3
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;src/test_impl/button_test.c:81: arrow_x = arrow_center_x;
	ld	a, (#_arrow_center_x)
	ldhl	sp,	#2
	ld	(hl), a
;src/test_impl/button_test.c:72: for (uint8_t q = 0; q < 4; ++q)
	inc	c
	jr	00113$
00103$:
;src/test_impl/button_test.c:83: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:84: }
	add	sp, #5
	ret
;src/test_impl/button_test.c:86: BANKREF(buttons_sequence)
;	---------------------------------
; Function __func_buttons_sequence
; ---------------------------------
	b___func_buttons_sequence	= 2
___func_buttons_sequence::
	.local b___func_buttons_sequence 
	___bank_buttons_sequence = b___func_buttons_sequence 
	.globl ___bank_buttons_sequence 
;src/test_impl/button_test.c:87: void buttons_sequence() BANKED
;	---------------------------------
; Function buttons_sequence
; ---------------------------------
	b_buttons_sequence	= 2
_buttons_sequence::
;src/test_impl/button_test.c:91: next_button(0);
	xor	a, a
	push	af
	inc	sp
	ld	e, #b_next_button
	ld	hl, #_next_button
	call	___sdcc_bcall_ehl
	inc	sp
;src/test_impl/button_test.c:92: waitpad(J_A);
	ld	a, #0x10
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:93: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:95: next_button(16);
	ld	a, #0x10
	push	af
	inc	sp
	ld	e, #b_next_button
	ld	hl, #_next_button
	call	___sdcc_bcall_ehl
	inc	sp
;src/test_impl/button_test.c:96: waitpad(J_B);
	ld	a, #0x20
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:97: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:99: next_button(32);
	ld	a, #0x20
	push	af
	inc	sp
	ld	e, #b_next_button
	ld	hl, #_next_button
	call	___sdcc_bcall_ehl
	inc	sp
;src/test_impl/button_test.c:100: waitpad(J_SELECT);
	ld	a, #0x40
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:101: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:103: next_button(48);
	ld	a, #0x30
	push	af
	inc	sp
	ld	e, #b_next_button
	ld	hl, #_next_button
	call	___sdcc_bcall_ehl
	inc	sp
;src/test_impl/button_test.c:104: waitpad(J_START);
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;src/test_impl/button_test.c:105: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/button_test.c:106: }
	ret
;src/test_impl/button_test.c:108: BANKREF(button_test)
;	---------------------------------
; Function __func_button_test
; ---------------------------------
	b___func_button_test	= 2
___func_button_test::
	.local b___func_button_test 
	___bank_button_test = b___func_button_test 
	.globl ___bank_button_test 
;src/test_impl/button_test.c:109: void button_test() BANKED 
;	---------------------------------
; Function button_test
; ---------------------------------
	b_button_test	= 2
_button_test::
	dec	sp
;src/test_impl/button_test.c:111: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_2
	push	de
	ld	de, #0x006f
	push	de
	ld	de, #___str_1
	push	de
	ld	de, #___str_0
	push	de
	call	_EMU_printf
	add	sp, #10
;src/test_impl/button_test.c:114: uint8_t arrow_index = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
;src/test_impl/button_test.c:115: primaryButtonBits.up = 0;
	ld	hl, #_primaryButtonBits
	res	4, (hl)
;src/test_impl/button_test.c:116: primaryButtonBits.down = 0;
	res	5, (hl)
;src/test_impl/button_test.c:117: primaryButtonBits.left = 0;
	res	6, (hl)
;src/test_impl/button_test.c:118: primaryButtonBits.right = 0;
	res	7, (hl)
;src/test_impl/button_test.c:119: primaryButtonBits.start = 0;
	res	2, (hl)
;src/test_impl/button_test.c:120: primaryButtonBits.select = 0;
	res	3, (hl)
;src/test_impl/button_test.c:121: primaryButtonBits.a = 0;
	res	0, (hl)
;src/test_impl/button_test.c:122: primaryButtonBits.b = 0;
	res	1, (hl)
;src/test_impl/button_test.c:123: if (_cpu == DMG_TYPE) {
	ld	a, (#__cpu)
	dec	a
	jr	NZ, 00102$
;src/test_impl/button_test.c:124: BGP_REG = DMG_PALETTE(DMG_BLACK, DMG_DARK_GRAY, DMG_LITE_GRAY, DMG_WHITE);
	ld	a, #0x1b
	ldh	(_BGP_REG + 0), a
;src/test_impl/button_test.c:125: OBP0_REG = DMG_PALETTE(DMG_WHITE, DMG_WHITE, DMG_WHITE, DMG_WHITE);
	xor	a, a
	ldh	(_OBP0_REG + 0), a
00102$:
;src/test_impl/button_test.c:131: next_arrow(arrow_index);
	xor	a, a
	push	af
	inc	sp
	ld	e, #b_next_arrow
	ld	hl, #_next_arrow
	call	___sdcc_bcall_ehl
	inc	sp
;src/test_impl/button_test.c:133: while (1) {
00150$:
;src/test_impl/button_test.c:134: if (primaryButtonBits.up && primaryButtonBits.left && primaryButtonBits.down && primaryButtonBits.right) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	and	a,#0x01
	jr	Z, 00104$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	rlca
	jr	NC, 00104$
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	Z, 00104$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jp	C, 00196$
;src/test_impl/button_test.c:135: break;
00104$:
;src/test_impl/button_test.c:138: if (primaryButtonBits.up == 0 && (joypad() & J_UP)) {
	ld	a, (#_primaryButtonBits)
	swap	a
	and	a,#0x01
	jr	NZ, 00109$
	call	_joypad
	bit	2, e
	jr	Z, 00109$
;src/test_impl/button_test.c:139: primaryButtonBits.up = 1;
	ld	hl, #_primaryButtonBits
	set	4, (hl)
00109$:
;src/test_impl/button_test.c:141: if (primaryButtonBits.down == 0 && (joypad() & J_DOWN)) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	NZ, 00112$
	call	_joypad
	bit	3, e
	jr	Z, 00112$
;src/test_impl/button_test.c:142: primaryButtonBits.down = 1;
	ld	hl, #_primaryButtonBits
	set	5, (hl)
00112$:
;src/test_impl/button_test.c:144: if (primaryButtonBits.left == 0 && (joypad() & J_LEFT)) {
	ld	a, (#_primaryButtonBits + 0)
	rlca
	rlca
	jr	C, 00115$
	call	_joypad
	bit	1, e
	jr	Z, 00115$
;src/test_impl/button_test.c:145: primaryButtonBits.left = 1;
	ld	hl, #_primaryButtonBits
	set	6, (hl)
00115$:
;src/test_impl/button_test.c:147: if (primaryButtonBits.right == 0 && (joypad() & J_RIGHT)) {
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	C, 00118$
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00118$
;src/test_impl/button_test.c:148: primaryButtonBits.right = 1;
	ld	hl, #_primaryButtonBits
	set	7, (hl)
00118$:
;src/test_impl/button_test.c:150: if (primaryButtonBits.select == 0 && (joypad() & J_SELECT)) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rlca
	jr	C, 00121$
	call	_joypad
	bit	6, e
	jr	Z, 00121$
;src/test_impl/button_test.c:151: primaryButtonBits.select = 1;
	ld	hl, #_primaryButtonBits
	set	3, (hl)
00121$:
;src/test_impl/button_test.c:153: if (primaryButtonBits.start == 0 && (joypad() & J_START)) {
	ld	a, (#_primaryButtonBits + 0)
	rrca
	rrca
	and	a,#0x01
	jr	NZ, 00124$
	call	_joypad
	ld	a, e
	rlca
	jr	NC, 00124$
;src/test_impl/button_test.c:154: primaryButtonBits.start = 1;
	ld	hl, #_primaryButtonBits
	set	2, (hl)
00124$:
;src/test_impl/button_test.c:156: if (primaryButtonBits.a == 0 && (joypad() & J_A)) {
	ld	a, (#_primaryButtonBits + 0)
	and	a,#0x01
	jr	NZ, 00127$
	call	_joypad
	bit	4, e
	jr	Z, 00127$
;src/test_impl/button_test.c:157: primaryButtonBits.a = 1;
	ld	hl, #_primaryButtonBits
	set	0, (hl)
00127$:
;src/test_impl/button_test.c:159: if (primaryButtonBits.b == 0 && (joypad() & J_B)) {
	ld	a, (#_primaryButtonBits + 0)
	rrca
	and	a,#0x01
	jr	NZ, 00130$
	call	_joypad
	bit	5, e
	jr	Z, 00130$
;src/test_impl/button_test.c:160: primaryButtonBits.b = 1;
	ld	hl, #_primaryButtonBits
	set	1, (hl)
00130$:
;src/test_impl/button_test.c:162: waitpadup();
	call	_waitpadup
;src/test_impl/button_test.c:163: if (primaryButtonBits.up == 0) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	and	a,#0x01
	jr	NZ, 00147$
;src/test_impl/button_test.c:164: arrow_index = 0;
	ldhl	sp,	#0
	ld	(hl), #0x00
	jr	00148$
00147$:
;src/test_impl/button_test.c:165: } else if (primaryButtonBits.up && primaryButtonBits.right == 0) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	and	a,#0x01
	jr	Z, 00143$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	C, 00143$
;src/test_impl/button_test.c:166: arrow_index = 16;
	ldhl	sp,	#0
	ld	(hl), #0x10
	jr	00148$
00143$:
;src/test_impl/button_test.c:167: } else if (primaryButtonBits.up && primaryButtonBits.right && primaryButtonBits.down == 0) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	and	a,#0x01
	jr	Z, 00138$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	NC, 00138$
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	NZ, 00138$
;src/test_impl/button_test.c:168: arrow_index = 32;
	ldhl	sp,	#0
	ld	(hl), #0x20
	jr	00148$
00138$:
;src/test_impl/button_test.c:169: } else if (primaryButtonBits.up && primaryButtonBits.right && primaryButtonBits.down && primaryButtonBits.left == 0) {
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	and	a,#0x01
	jr	Z, 00148$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	jr	NC, 00148$
	ld	a, (#_primaryButtonBits + 0)
	swap	a
	rrca
	and	a,#0x01
	jr	Z, 00148$
	ld	a, (#_primaryButtonBits + 0)
	rlca
	rlca
	jr	C, 00148$
;src/test_impl/button_test.c:170: arrow_index = 48;
	ldhl	sp,	#0
	ld	(hl), #0x30
00148$:
;src/test_impl/button_test.c:172: next_arrow(arrow_index);
	ldhl	sp,	#0
	ld	a, (hl)
	push	af
	inc	sp
	ld	e, #b_next_arrow
	ld	hl, #_next_arrow
	call	___sdcc_bcall_ehl
	inc	sp
;src/test_impl/button_test.c:173: wait_vbl_done();
	call	_wait_vbl_done
	jp	00150$
;src/test_impl/button_test.c:176: for (uint8_t q = 0; q < 32; ++q)
00196$:
	ldhl	sp,	#0
	ld	(hl), #0x00
00157$:
	ldhl	sp,	#0
	ld	a, (hl)
	sub	a, #0x20
	jr	NC, 00152$
;X:/gbc_hacks/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, bc
;X:/gbc_hacks/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
;src/test_impl/button_test.c:176: for (uint8_t q = 0; q < 32; ++q)
	ldhl	sp,	#0
	inc	(hl)
	jr	00157$
00152$:
;src/test_impl/button_test.c:180: buttons_sequence();
	ld	e, #b_buttons_sequence
	ld	hl, #_buttons_sequence
	call	___sdcc_bcall_ehl
;src/test_impl/button_test.c:182: for (uint8_t q = 0; q < 32; ++q)
	ld	c, #0x00
00160$:
	ld	a, c
	sub	a, #0x20
	jr	NC, 00153$
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
;src/test_impl/button_test.c:182: for (uint8_t q = 0; q < 32; ++q)
	inc	c
	jr	00160$
00153$:
;src/test_impl/button_test.c:186: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/test_impl/button_test.c:188: }
	inc	sp
	ret
___str_0:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_1:
	.ascii "src/test_impl/button_test.c"
	.db 0x00
___str_2:
	.ascii "button_test"
	.db 0x00
	.area _CODE_2
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
__xinit__arrow_center_x:
	.db #0x48	; 72	'H'
	.area _CABS (ABS)
