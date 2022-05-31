;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module utilities
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_default_palette
	.globl _set_bkg_palette
	.globl _EMU_printf
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _waitpadup
	.globl _joypad
	.globl b_blank_display
	.globl _blank_display
	.globl b_ask_user_pass_or_fail
	.globl _ask_user_pass_or_fail
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
	.area _CODE_2
;src/utilities.c:10: void blank_display() BANKED
;	---------------------------------
; Function blank_display
; ---------------------------------
	b_blank_display	= 2
_blank_display::
	ld	hl, #-380
	add	hl, sp
	ld	sp, hl
;src/utilities.c:12: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_2
	push	de
	ld	de, #0x000c
	push	de
	ld	de, #___str_1
	push	de
	ld	de, #___str_0
	push	de
	call	_EMU_printf
	add	sp, #10
;src/utilities.c:13: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:14: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:18: for (i = 0; i < 16; ++i)
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ld	hl, #376
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ld	bc, #0x0000
00103$:
;src/utilities.c:20: blank_display_tiles[i] = 0x0;
	ld	hl, #376
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
;src/utilities.c:18: for (i = 0; i < 16; ++i)
	inc	bc
	ld	a, c
	sub	a, #0x10
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	C, 00103$
;src/utilities.c:23: for (i = 0; i < 360; ++i)
	ldhl	sp,	#16
	ld	a, l
	ld	d, h
	ld	hl, #378
	add	hl, sp
	ld	(hl+), a
	ld	(hl), d
	ld	bc, #0x0000
00105$:
;src/utilities.c:25: blank_display_map_and_attr[i] = 0x0;
	ld	hl, #378
	add	hl, sp
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	xor	a, a
	ld	(de), a
;src/utilities.c:23: for (i = 0; i < 360; ++i)
	inc	bc
	ld	a, c
	sub	a, #0x68
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x81
	jr	C, 00105$
;src/utilities.c:27: set_default_palette();
	call	_set_default_palette
;src/utilities.c:28: set_bkg_data(0, 1, blank_display_tiles);
	ld	hl, #376
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_data
	add	sp, #4
;src/utilities.c:29: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/utilities.c:30: set_bkg_tiles(0, 0, 20, 18, blank_display_map_and_attr);
	ld	hl, #378
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:31: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/utilities.c:32: set_bkg_tiles(0, 0, 20, 18, blank_display_map_and_attr);
	ld	hl, #378
	add	hl, sp
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	push	bc
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:33: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:34: }
	ld	hl, #380
	add	hl, sp
	ld	sp, hl
	ret
___str_0:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_1:
	.ascii "src/utilities.c"
	.db 0x00
___str_2:
	.ascii "blank_display"
	.db 0x00
;src/utilities.c:36: int ask_user_pass_or_fail() BANKED
;	---------------------------------
; Function ask_user_pass_or_fail
; ---------------------------------
	b_ask_user_pass_or_fail	= 2
_ask_user_pass_or_fail::
;src/utilities.c:38: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_5
	push	de
	ld	de, #0x0026
	push	de
	ld	de, #___str_4
	push	de
	ld	de, #___str_3
	push	de
	call	_EMU_printf
	add	sp, #10
;src/utilities.c:39: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:40: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:41: set_bkg_palette(0, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:42: set_bkg_palette(1, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:43: set_bkg_palette(2, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:44: set_bkg_palette(3, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:45: set_bkg_palette(4, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:46: set_bkg_palette(5, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:47: set_bkg_palette(6, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:48: set_bkg_palette(7, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:49: set_bkg_data(0, passfail_bg_TILE_COUNT, passfail_bg_tiles);
	ld	de, #_passfail_bg_tiles
	push	de
	ld	hl, #0x9600
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/utilities.c:50: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/utilities.c:51: set_bkg_tiles(0, 0, 20, 18, passfail_bg_map_attributes);
	ld	de, #_passfail_bg_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:52: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/utilities.c:53: set_bkg_tiles(0, 0, 20, 18, passfail_bg_map);
	ld	de, #_passfail_bg_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:54: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:56: while (1) {
00107$:
;src/utilities.c:57: if (joypad() & J_A) {
	call	_joypad
	bit	4, e
	jr	Z, 00104$
;src/utilities.c:58: result = TEST_PASSED;
	ld	de, #0x0025
;src/utilities.c:59: waitpadup();
;src/utilities.c:60: break;
	jp  _waitpadup
00104$:
;src/utilities.c:61: } else if (joypad() & J_B) {
	call	_joypad
	bit	5, e
	jr	Z, 00107$
;src/utilities.c:62: result = TEST_FAILED;
	ld	de, #0x0069
;src/utilities.c:63: waitpadup();
;src/utilities.c:64: break;
;src/utilities.c:68: return result;
;src/utilities.c:69: }
	jp  _waitpadup
___str_3:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_4:
	.ascii "src/utilities.c"
	.db 0x00
___str_5:
	.ascii "ask_user_pass_or_fail"
	.db 0x00
	.area _CODE_2
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
	.area _CABS (ABS)
