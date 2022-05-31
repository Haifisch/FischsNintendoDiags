;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module utilities
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ask_user_pass_or_fail
	.globl _text_load_font
	.globl _set_bkg_palette
	.globl _EMU_printf
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _joypad
	.globl _blank_display
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
;src/utilities.c:11: void blank_display() {
;	---------------------------------
; Function blank_display
; ---------------------------------
_blank_display::
;src/utilities.c:12: PRINT_FUNC_INFO;
	ld	de, #___str_2
	push	de
	ld	de, #0x000c
	push	de
	ld	de, #___str_1
	push	de
	ld	de, #___str_0
	push	de
	call	_EMU_printf
	add	sp, #8
;src/utilities.c:13: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:14: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:15: set_bkg_palette(0, 1,  blank_display_palettes);//FAR_OFS(pal_ptr));
	ld	de, #_blank_display_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:16: set_bkg_palette(1, 1,  blank_display_palettes);
	ld	de, #_blank_display_palettes
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:17: set_bkg_palette(2, 1,  blank_display_palettes);
	ld	de, #_blank_display_palettes
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:18: set_bkg_palette(3, 1,  blank_display_palettes);
	ld	de, #_blank_display_palettes
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:19: set_bkg_palette(4, 1,  blank_display_palettes);
	ld	de, #_blank_display_palettes
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:20: set_bkg_palette(5, 1,  blank_display_palettes);
	ld	de, #_blank_display_palettes
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:21: set_bkg_palette(6, 1,  blank_display_palettes);
	ld	de, #_blank_display_palettes
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:22: set_bkg_palette(7, 1,  blank_display_palettes);
	ld	de, #_blank_display_palettes
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:23: set_bkg_data(0, blank_display_TILE_COUNT, blank_display_tiles);
	ld	de, #_blank_display_tiles
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_data
	add	sp, #4
;src/utilities.c:24: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/utilities.c:25: set_bkg_tiles(0, 0, 20, 18, blank_display_map_attributes);
	ld	de, #_blank_display_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:26: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/utilities.c:27: set_bkg_tiles(0, 0, 20, 18, blank_display_map);
	ld	de, #_blank_display_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:28: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:29: text_load_font();
	call	_text_load_font
;src/utilities.c:30: set_bkg_palette(0, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:31: wait_vbl_done();
;src/utilities.c:32: }
	jp	_wait_vbl_done
___str_0:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_1:
	.ascii "src/utilities.c"
	.db 0x00
___str_2:
	.ascii "blank_display"
	.db 0x00
;src/utilities.c:34: int ask_user_pass_or_fail() {
;	---------------------------------
; Function ask_user_pass_or_fail
; ---------------------------------
_ask_user_pass_or_fail::
;src/utilities.c:35: blank_display();
	call	_blank_display
;src/utilities.c:36: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:37: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:38: set_bkg_palette(0, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:39: set_bkg_palette(1, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:40: set_bkg_palette(2, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:41: set_bkg_palette(3, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:42: set_bkg_palette(4, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:43: set_bkg_palette(5, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:44: set_bkg_palette(6, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:45: set_bkg_palette(7, 1, passfail_bg_palettes);
	ld	de, #_passfail_bg_palettes
	push	de
	ld	hl, #0x107
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/utilities.c:46: set_bkg_data(0, passfail_bg_TILE_COUNT, passfail_bg_tiles);
	ld	de, #_passfail_bg_tiles
	push	de
	ld	hl, #0x7200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/utilities.c:47: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/utilities.c:48: set_bkg_tiles(0, 0, 20, 18, passfail_bg_map_attributes);
	ld	de, #_passfail_bg_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:49: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/utilities.c:50: set_bkg_tiles(0, 0, 20, 18, passfail_bg_map);
	ld	de, #_passfail_bg_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/utilities.c:51: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/utilities.c:53: while (1) {
00107$:
;src/utilities.c:54: if (joypad() & J_A) {
	call	_joypad
	bit	4, e
	jr	Z, 00104$
;src/utilities.c:55: result = TEST_PASSED;
	ld	de, #0x0025
;src/utilities.c:56: waitpadup();
	call	_waitpadup
;src/utilities.c:57: break;
	jr	00108$
00104$:
;src/utilities.c:58: } else if (joypad() & J_B) {
	call	_joypad
	bit	5, e
	jr	Z, 00107$
;src/utilities.c:59: result = TEST_FAILED;
	ld	de, #0x0069
;src/utilities.c:60: waitpadup();
	call	_waitpadup
;src/utilities.c:61: break;
00108$:
;src/utilities.c:65: blank_display();
	push	de
	call	_blank_display
	pop	de
;src/utilities.c:66: return result;
;src/utilities.c:67: }
	ret
	.area _CODE
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
	.area _CABS (ABS)
