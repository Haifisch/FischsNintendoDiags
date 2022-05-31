;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module display_tests
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _display_test
	.globl _do_scroll_pattern_animation
	.globl _display_scroll_pattern
	.globl _display_alert_image_pattern
	.globl _display_checkerboard
	.globl _display_colorbar_right_to_left
	.globl _display_colorbar_left_to_right
	.globl _blank_display
	.globl _EMU_printf
	.globl _set_bkg_palette
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _delay
	.globl _bar_b
	.globl _bar_a
	.globl _bar_p
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
_bar_p::
	.ds 64
_bar_a::
	.ds 360
_bar_b::
	.ds 360
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
;src/test_impl/display_tests.c:74: void display_colorbar_left_to_right()  
;	---------------------------------
; Function display_colorbar_left_to_right
; ---------------------------------
_display_colorbar_left_to_right::
;src/test_impl/display_tests.c:76: PRINT_FUNC_INFO;
	ld	de, #___str_2
	push	de
	ld	de, #0x004c
	push	de
	ld	de, #___str_1
	push	de
	ld	de, #___str_0
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/display_tests.c:77: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:78: set_bkg_palette(7, 1, &bar_p[0]);
	ld	de, #_bar_p
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:79: set_bkg_palette(6, 1, &bar_p[4]);
	ld	de, #(_bar_p + 8)
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:80: set_bkg_palette(5, 1, &bar_p[8]);
	ld	de, #(_bar_p + 16)
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:81: set_bkg_palette(4, 1, &bar_p[12]);
	ld	de, #(_bar_p + 24)
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:82: set_bkg_palette(3, 1, &bar_p[16]);
	ld	de, #(_bar_p + 32)
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:83: set_bkg_palette(2, 1, &bar_p[20]);
	ld	de, #(_bar_p + 40)
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:84: set_bkg_palette(1, 1, &bar_p[24]);
	ld	de, #(_bar_p + 48)
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:85: set_bkg_palette(0, 1, &bar_p[28]);
	ld	de, #(_bar_p + 56)
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:86: set_bkg_data(0x0, 32, bar_c);
	ld	de, #_bar_c
	push	de
	ld	hl, #0x2000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/test_impl/display_tests.c:87: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:88: set_bkg_tiles(0, 0, 20, 18, bar_a);
	ld	de, #_bar_a
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:89: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:90: set_bkg_tiles(0, 0, 20, 18, ColorbarsLeftToRight);
	ld	de, #_ColorbarsLeftToRight
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:91: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:92: }
	ret
___str_0:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_1:
	.ascii "src/test_impl/display_tests.c"
	.db 0x00
___str_2:
	.ascii "display_colorbar_left_to_right"
	.db 0x00
;src/test_impl/display_tests.c:94: void display_colorbar_right_to_left()
;	---------------------------------
; Function display_colorbar_right_to_left
; ---------------------------------
_display_colorbar_right_to_left::
;src/test_impl/display_tests.c:96: PRINT_FUNC_INFO;
	ld	de, #___str_5
	push	de
	ld	de, #0x0060
	push	de
	ld	de, #___str_4
	push	de
	ld	de, #___str_3
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/display_tests.c:97: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:106: set_bkg_data(0x0, 32, bar_c);
	ld	de, #_bar_c
	push	de
	ld	hl, #0x2000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/test_impl/display_tests.c:107: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:108: set_bkg_tiles(0, 0, 20, 18, bar_b);
	ld	de, #_bar_b
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:109: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:110: set_bkg_tiles(0, 0, 20, 18, ColorbarsRightToLeft);
	ld	de, #_ColorbarsRightToLeft
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:111: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:112: }
	ret
___str_3:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_4:
	.ascii "src/test_impl/display_tests.c"
	.db 0x00
___str_5:
	.ascii "display_colorbar_right_to_left"
	.db 0x00
;src/test_impl/display_tests.c:114: void display_checkerboard()  
;	---------------------------------
; Function display_checkerboard
; ---------------------------------
_display_checkerboard::
;src/test_impl/display_tests.c:116: PRINT_FUNC_INFO;
	ld	de, #___str_8
	push	de
	ld	de, #0x0074
	push	de
	ld	de, #___str_7
	push	de
	ld	de, #___str_6
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/display_tests.c:117: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:118: set_bkg_palette(7, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:119: set_bkg_palette(6, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:120: set_bkg_palette(5, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:121: set_bkg_palette(4, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:122: set_bkg_palette(3, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:123: set_bkg_palette(2, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:124: set_bkg_palette(1, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:125: set_bkg_palette(0, 1, checkerboard_32x32_palettes);
	ld	de, #_checkerboard_32x32_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:126: set_bkg_data(0x0, checkerboard_32x32_TILE_COUNT, checkerboard_32x32_tiles);
	ld	de, #_checkerboard_32x32_tiles
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/test_impl/display_tests.c:127: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:128: set_bkg_tiles(0, 0, 20, 18, checkerboard_32x32_map_attributes);
	ld	de, #_checkerboard_32x32_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:129: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:130: set_bkg_tiles(0, 0, 20, 18, checkerboard_32x32_map);
	ld	de, #_checkerboard_32x32_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:131: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:132: }
	ret
___str_6:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_7:
	.ascii "src/test_impl/display_tests.c"
	.db 0x00
___str_8:
	.ascii "display_checkerboard"
	.db 0x00
;src/test_impl/display_tests.c:135: void display_alert_image_pattern() {
;	---------------------------------
; Function display_alert_image_pattern
; ---------------------------------
_display_alert_image_pattern::
;src/test_impl/display_tests.c:136: PRINT_FUNC_INFO;
	ld	de, #___str_11
	push	de
	ld	de, #0x0088
	push	de
	ld	de, #___str_10
	push	de
	ld	de, #___str_9
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/display_tests.c:137: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:138: set_bkg_palette(7, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:139: set_bkg_palette(6, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:140: set_bkg_palette(5, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:141: set_bkg_palette(4, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:142: set_bkg_palette(3, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:143: set_bkg_palette(2, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:144: set_bkg_palette(1, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:145: set_bkg_palette(0, 1, alert_pattern_palettes);
	ld	de, #_alert_pattern_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:146: set_bkg_data(0x0, alert_pattern_TILE_COUNT, alert_pattern_tiles);
	ld	de, #_alert_pattern_tiles
	push	de
	ld	hl, #0x2000
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/test_impl/display_tests.c:147: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:148: set_bkg_tiles(0, 0, 20, 18, alert_pattern_map_attributes);
	ld	de, #_alert_pattern_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:149: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:150: set_bkg_tiles(0, 0, 20, 18, alert_pattern_map);
	ld	de, #_alert_pattern_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:151: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:152: }
	ret
___str_9:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_10:
	.ascii "src/test_impl/display_tests.c"
	.db 0x00
___str_11:
	.ascii "display_alert_image_pattern"
	.db 0x00
;src/test_impl/display_tests.c:154: void display_scroll_pattern() {
;	---------------------------------
; Function display_scroll_pattern
; ---------------------------------
_display_scroll_pattern::
;src/test_impl/display_tests.c:155: PRINT_FUNC_INFO;
	ld	de, #___str_14
	push	de
	ld	de, #0x009b
	push	de
	ld	de, #___str_13
	push	de
	ld	de, #___str_12
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/display_tests.c:156: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:157: set_bkg_palette(7, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:158: set_bkg_palette(6, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:159: set_bkg_palette(5, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:160: set_bkg_palette(4, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:161: set_bkg_palette(3, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:162: set_bkg_palette(2, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:163: set_bkg_palette(1, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:164: set_bkg_palette(0, 1, scroll_pattern_palettes);
	ld	de, #_scroll_pattern_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/test_impl/display_tests.c:165: set_bkg_data(0x0, scroll_pattern_TILE_COUNT, scroll_pattern_tiles);
	ld	de, #_scroll_pattern_tiles
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/test_impl/display_tests.c:166: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:167: set_bkg_tiles(0, 0, 20, 18, scroll_pattern_map_attributes);
	ld	bc, #_scroll_pattern_map_attributes+0
	push	bc
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:168: set_bkg_tiles(0, 18, 20, 17, scroll_pattern_map_attributes);
	push	bc
	ld	hl, #0x1114
	push	hl
	ld	hl, #0x1200
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:169: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/test_impl/display_tests.c:170: set_bkg_tiles(0, 0, 20, 18, scroll_pattern_map);
	ld	bc, #_scroll_pattern_map+0
	push	bc
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:171: set_bkg_tiles(0, 18, 20, 17, scroll_pattern_map);
	push	bc
	ld	hl, #0x1114
	push	hl
	ld	hl, #0x1200
	push	hl
	call	_set_bkg_tiles
	add	sp, #6
;src/test_impl/display_tests.c:172: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:173: }
	ret
___str_12:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_13:
	.ascii "src/test_impl/display_tests.c"
	.db 0x00
___str_14:
	.ascii "display_scroll_pattern"
	.db 0x00
;src/test_impl/display_tests.c:175: void do_scroll_pattern_animation() {
;	---------------------------------
; Function do_scroll_pattern_animation
; ---------------------------------
_do_scroll_pattern_animation::
;src/test_impl/display_tests.c:176: PRINT_FUNC_INFO;
	ld	de, #___str_17
	push	de
	ld	de, #0x00b0
	push	de
	ld	de, #___str_16
	push	de
	ld	de, #___str_15
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/display_tests.c:178: while (scrollTick < 120) {
	ld	c, #0x00
00101$:
	ld	a, c
	sub	a, #0x78
	ret	NC
;X:/gbc_hacks/gbdk/include/gb/gb.h:1094: SCX_REG+=x, SCY_REG+=y;
	ldh	a, (_SCY_REG + 0)
	inc	a
	ldh	(_SCY_REG + 0), a
;src/test_impl/display_tests.c:180: scrollTick++;
	inc	c
;src/test_impl/display_tests.c:181: delay(100);
	push	bc
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
	pop	bc
;src/test_impl/display_tests.c:183: }
	jr	00101$
___str_15:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_16:
	.ascii "src/test_impl/display_tests.c"
	.db 0x00
___str_17:
	.ascii "do_scroll_pattern_animation"
	.db 0x00
;src/test_impl/display_tests.c:185: void display_test()
;	---------------------------------
; Function display_test
; ---------------------------------
_display_test::
;src/test_impl/display_tests.c:187: PRINT_FUNC_INFO;
	ld	de, #___str_20
	push	de
	ld	de, #0x00bb
	push	de
	ld	de, #___str_19
	push	de
	ld	de, #___str_18
	push	de
	call	_EMU_printf
	add	sp, #8
;src/test_impl/display_tests.c:188: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/test_impl/display_tests.c:189: blank_display();
	call	_blank_display
;src/test_impl/display_tests.c:190: PRINT_BANK_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_21
	push	de
	call	_EMU_printf
	add	sp, #4
;src/test_impl/display_tests.c:193: display_colorbar_left_to_right();
	call	_display_colorbar_left_to_right
;src/test_impl/display_tests.c:194: PRINT_BANK_INFO;
	ldh	a, (__current_bank + 0)
	ld	b, #0x00
	ld	c, a
	push	bc
	ld	de, #___str_21
	push	de
	call	_EMU_printf
	add	sp, #4
;src/test_impl/display_tests.c:195: delay(2000);
	ld	de, #0x07d0
	push	de
	call	_delay
	pop	hl
;src/test_impl/display_tests.c:197: display_colorbar_right_to_left();
	call	_display_colorbar_right_to_left
;src/test_impl/display_tests.c:198: delay(2000);
	ld	de, #0x07d0
	push	de
	call	_delay
	pop	hl
;src/test_impl/display_tests.c:200: display_checkerboard();
	call	_display_checkerboard
;src/test_impl/display_tests.c:201: delay(2000);
	ld	de, #0x07d0
	push	de
	call	_delay
	pop	hl
;src/test_impl/display_tests.c:203: display_alert_image_pattern();
	call	_display_alert_image_pattern
;src/test_impl/display_tests.c:204: delay(2000);
	ld	de, #0x07d0
	push	de
	call	_delay
	pop	hl
;src/test_impl/display_tests.c:206: display_scroll_pattern();
	call	_display_scroll_pattern
;src/test_impl/display_tests.c:207: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/test_impl/display_tests.c:208: do_scroll_pattern_animation();
	call	_do_scroll_pattern_animation
;src/test_impl/display_tests.c:209: wait_vbl_done();
	call	_wait_vbl_done
;src/test_impl/display_tests.c:210: blank_display();
	call	_blank_display
;X:/gbc_hacks/gbdk/include/gb/gb.h:1080: SCX_REG=x, SCY_REG=y;
	xor	a, a
	ldh	(_SCX_REG + 0), a
	xor	a, a
	ldh	(_SCY_REG + 0), a
;src/test_impl/display_tests.c:212: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/test_impl/display_tests.c:213: }
	ret
___str_18:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_19:
	.ascii "src/test_impl/display_tests.c"
	.db 0x00
___str_20:
	.ascii "display_test"
	.db 0x00
___str_21:
	.ascii "[DBG] bank => %d"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
__xinit__bar_p:
	.dw #0x7fff
	.dw #0x6318
	.dw #0x4a52
	.dw #0x0000
	.dw #0x0012
	.dw #0x0018
	.dw #0x001f
	.dw #0x000c
	.dw #0x0180
	.dw #0x0240
	.dw #0x0300
	.dw #0x03e0
	.dw #0x3000
	.dw #0x4800
	.dw #0x6000
	.dw #0x7c00
	.dw #0x0318
	.dw #0x03ff
	.dw #0x018c
	.dw #0x0252
	.dw #0x6018
	.dw #0x7c1f
	.dw #0x300c
	.dw #0x4812
	.dw #0x4a40
	.dw #0x6300
	.dw #0x7fe0
	.dw #0x3180
	.dw #0x7fff
	.dw #0x6318
	.dw #0x4a52
	.dw #0x318c
__xinit__bar_a:
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x01	; 1
	.db #0x01	; 1
__xinit__bar_b:
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x07	; 7
	.db #0x07	; 7
	.area _CABS (ABS)
