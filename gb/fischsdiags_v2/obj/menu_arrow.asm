;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module menu_arrow
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _menu_arrow_tiles
	.globl b___func_menu_arrow_tiles
	.globl ___func_menu_arrow_tiles
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
;src/gfx/menu_arrow.c:12: BANKREF(menu_arrow_tiles)
;	---------------------------------
; Function __func_menu_arrow_tiles
; ---------------------------------
	b___func_menu_arrow_tiles	= 0
___func_menu_arrow_tiles::
	.local b___func_menu_arrow_tiles 
	___bank_menu_arrow_tiles = b___func_menu_arrow_tiles 
	.globl ___bank_menu_arrow_tiles 
	.area _CODE
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
	.area _INITIALIZER
	.area _CABS (ABS)
