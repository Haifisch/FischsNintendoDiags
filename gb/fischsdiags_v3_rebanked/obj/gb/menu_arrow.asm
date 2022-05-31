;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module menu_arrow
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b_menu_arrow_display
	.globl _menu_arrow_display
	.globl b___func_menu_arrow_display
	.globl ___func_menu_arrow_display
	.globl b___func_menu_arrow_tiles
	.globl ___func_menu_arrow_tiles
	.globl b___func_menu_arrow_palettes
	.globl ___func_menu_arrow_palettes
	.globl _set_sprite_palette
	.globl _set_sprite_data
	.globl _menu_arrow_tiles
	.globl _menu_arrow_palettes
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
	.area _CODE_1
;src/gfx/menu_arrow.c:7: BANKREF(menu_arrow_palettes)
;	---------------------------------
; Function __func_menu_arrow_palettes
; ---------------------------------
	b___func_menu_arrow_palettes	= 1
___func_menu_arrow_palettes::
	.local b___func_menu_arrow_palettes 
	___bank_menu_arrow_palettes = b___func_menu_arrow_palettes 
	.globl ___bank_menu_arrow_palettes 
;src/gfx/menu_arrow.c:12: BANKREF(menu_arrow_tiles)
;	---------------------------------
; Function __func_menu_arrow_tiles
; ---------------------------------
	b___func_menu_arrow_tiles	= 1
___func_menu_arrow_tiles::
	.local b___func_menu_arrow_tiles 
	___bank_menu_arrow_tiles = b___func_menu_arrow_tiles 
	.globl ___bank_menu_arrow_tiles 
;src/gfx/menu_arrow.c:17: BANKREF(menu_arrow_display)
;	---------------------------------
; Function __func_menu_arrow_display
; ---------------------------------
	b___func_menu_arrow_display	= 1
___func_menu_arrow_display::
	.local b___func_menu_arrow_display 
	___bank_menu_arrow_display = b___func_menu_arrow_display 
	.globl ___bank_menu_arrow_display 
;src/gfx/menu_arrow.c:18: void menu_arrow_display() BANKED
;	---------------------------------
; Function menu_arrow_display
; ---------------------------------
	b_menu_arrow_display	= 1
_menu_arrow_display::
;src/gfx/menu_arrow.c:20: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/gfx/menu_arrow.c:21: set_sprite_palette(0, 1, menu_arrow_palettes);
	ld	de, #_menu_arrow_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_palette
	add	sp, #4
;src/gfx/menu_arrow.c:22: set_sprite_data(0, 8, menu_arrow_tiles);
	ld	de, #_menu_arrow_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;X:/gbc_hacks/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;src/gfx/menu_arrow.c:24: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/gfx/menu_arrow.c:25: }
	ret
_menu_arrow_palettes:
	.dw #0x001f
	.dw #0x0000
	.dw #0x000a
	.dw #0x001f
_menu_arrow_tiles:
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x70	; 112	'p'
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x00	; 0
	.db #0x10	; 16
	.db #0x00	; 0
	.area _CODE_1
	.area _INITIALIZER
	.area _CABS (ABS)
