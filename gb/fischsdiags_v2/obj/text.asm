;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module text
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _text_load_font
	.globl _text_print_char_bkg
	.globl _text_print_string_bkg
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
;src/text.c:11: void text_load_font() {
;	---------------------------------
; Function text_load_font
; ---------------------------------
_text_load_font::
;src/text.c:13: set_bkg_data(TEXT_FONT_OFFSET, font_TILE_COUNT, font_tiles);
	ld	de, #_font_tiles
	push	de
	ld	hl, #0x2ed0
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/text.c:14: }
	ret
;src/text.c:17: void text_print_char_bkg(UINT8 x, UINT8 y, unsigned char chr) {
;	---------------------------------
; Function text_print_char_bkg
; ---------------------------------
_text_print_char_bkg::
	dec	sp
;src/text.c:18: UINT8 tile = _TEXT_CHAR_TOFU;
	ldhl	sp,	#0
	ld	(hl), #0xfd
;src/text.c:19: if (chr >= 'a' && chr <= 'z') {
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x61
	jr	C, 00121$
	ld	a, #0x7a
	sub	a, (hl)
	jr	C, 00121$
;src/text.c:20: tile = _TEXT_CHAR_A + chr - 'a';
	ld	a, (hl)
	add	a, #0x6f
	ldhl	sp,	#0
	ld	(hl), a
	jp	00122$
00121$:
;src/text.c:21: } else if (chr >= 'A' && chr <= 'Z') {
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x41
	jr	C, 00117$
	ld	a, #0x5a
	sub	a, (hl)
	jr	C, 00117$
;src/text.c:22: tile = _TEXT_CHAR_A + chr - 'A';
	ld	a, (hl)
	add	a, #0x8f
	ldhl	sp,	#0
	ld	(hl), a
	jp	00122$
00117$:
;src/text.c:23: } else if (chr >= '0' && chr <= '9') {
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x30
	jr	C, 00113$
	ld	a, #0x39
	sub	a, (hl)
	jr	C, 00113$
;src/text.c:24: tile = _TEXT_CHAR_0 + chr - '0';
	ld	a, (hl)
	add	a, #0xba
	ldhl	sp,	#0
	ld	(hl), a
	jp	00122$
00113$:
;src/text.c:26: switch (chr) {
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x20
	jr	Z, 00110$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x21
	jr	Z, 00106$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x27
	jr	Z, 00101$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x28
	jr	Z, 00108$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x29
	jr	Z, 00109$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x2c
	jr	Z, 00104$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x2d
	jr	Z, 00102$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x2e
	jr	Z, 00103$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x3a
	jr	Z, 00105$
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x3f
	jr	Z, 00107$
	jr	00122$
;src/text.c:27: case '\'':
00101$:
;src/text.c:28: tile = _TEXT_CHAR_APOSTROPHE;
	ldhl	sp,	#0
	ld	(hl), #0xf4
;src/text.c:29: break;
	jr	00122$
;src/text.c:30: case '-':
00102$:
;src/text.c:31: tile = _TEXT_CHAR_DASH;
	ldhl	sp,	#0
	ld	(hl), #0xf5
;src/text.c:32: break;
	jr	00122$
;src/text.c:33: case '.':
00103$:
;src/text.c:34: tile = _TEXT_CHAR_DOT;
	ldhl	sp,	#0
	ld	(hl), #0xf6
;src/text.c:35: break;
	jr	00122$
;src/text.c:36: case ',':
00104$:
;src/text.c:37: tile = _TEXT_CHAR_COMMA;
	ldhl	sp,	#0
	ld	(hl), #0xf7
;src/text.c:38: break;
	jr	00122$
;src/text.c:39: case ':':
00105$:
;src/text.c:40: tile = _TEXT_CHAR_COLON;
	ldhl	sp,	#0
	ld	(hl), #0xf8
;src/text.c:41: break;
	jr	00122$
;src/text.c:42: case '!':
00106$:
;src/text.c:43: tile = _TEXT_CHAR_EXCLAMATION;
	ldhl	sp,	#0
	ld	(hl), #0xf9
;src/text.c:44: break;
	jr	00122$
;src/text.c:45: case '?':
00107$:
;src/text.c:46: tile = _TEXT_CHAR_INTERROGATION;
	ldhl	sp,	#0
	ld	(hl), #0xfa
;src/text.c:47: break;
	jr	00122$
;src/text.c:48: case '(':
00108$:
;src/text.c:49: tile = _TEXT_CHAR_LPARENTHESES;
	ldhl	sp,	#0
	ld	(hl), #0xfb
;src/text.c:50: break;
	jr	00122$
;src/text.c:51: case ')':
00109$:
;src/text.c:52: tile = _TEXT_CHAR_RPARENTHESES;
	ldhl	sp,	#0
	ld	(hl), #0xfc
;src/text.c:53: break;
	jr	00122$
;src/text.c:54: case ' ':
00110$:
;src/text.c:55: tile = _TEXT_CHAR_SPACE;
	ldhl	sp,	#0
	ld	(hl), #0xff
;src/text.c:57: }
00122$:
;src/text.c:59: set_bkg_tiles(x, y, 1, 1, &tile);
	ldhl	sp,	#0
	push	hl
	ld	hl, #0x101
	push	hl
	ldhl	sp,	#8
	ld	a, (hl-)
	ld	d, a
	ld	e, (hl)
	push	de
	call	_set_bkg_tiles
;src/text.c:60: }
	add	sp, #7
	ret
;src/text.c:64: void text_print_string_bkg(UINT8 x, UINT8 y, unsigned char *string) {
;	---------------------------------
; Function text_print_string_bkg
; ---------------------------------
_text_print_string_bkg::
	dec	sp
	dec	sp
;src/text.c:65: UINT8 offset_x = 0;
;src/text.c:66: UINT8 offset_y = 0;
	ld	bc, #0x0
;src/text.c:68: while (string[0]) {
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
00104$:
	ld	a, (de)
	ldhl	sp,	#0
;src/text.c:69: if (string[0] == '\n') {
	ld	(hl),a
	or	a,a
	jr	Z, 00107$
;src/text.c:70: offset_x = 0;
	sub	a,#0x0a
	jr	NZ, 00102$
	ld	c,a
;src/text.c:71: offset_y += 1;
	inc	b
	jr	00103$
00102$:
;src/text.c:73: text_print_char_bkg(x + offset_x, y + offset_y, (unsigned char) string[0]);
	ldhl	sp,	#5
	ld	a, (hl)
	add	a, b
	ldhl	sp,	#1
	ld	(hl), a
	ldhl	sp,	#4
	ld	a, (hl)
	add	a, c
	push	bc
	push	de
	ldhl	sp,	#4
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	ldhl	sp,	#6
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_text_print_char_bkg
	add	sp, #3
	pop	de
	pop	bc
;src/text.c:74: offset_x += 1;
	inc	c
00103$:
;src/text.c:76: string += 1;  // Increment pointer address, /!\ THIS IS DANGEROUS!
	inc	de
	jr	00104$
00107$:
;src/text.c:78: }
	inc	sp
	inc	sp
	ret
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
