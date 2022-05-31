;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module audio_tests
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _audio_test
	.globl _ask_user_pass_or_fail
	.globl _blank_display
	.globl _text_print_string_bkg
	.globl _joypad
	.globl _delay
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
;src/test_impl/audio_tests.c:11: int audio_test() {
;	---------------------------------
; Function audio_test
; ---------------------------------
_audio_test::
;src/test_impl/audio_tests.c:12: blank_display();
	call	_blank_display
;src/test_impl/audio_tests.c:13: text_print_string_bkg(0, 2, "Playing sound...");
	ld	de, #___str_0
	push	de
	ld	hl, #0x200
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/test_impl/audio_tests.c:14: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/test_impl/audio_tests.c:15: NR50_REG = 0x77; 
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/test_impl/audio_tests.c:16: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/test_impl/audio_tests.c:17: while (1) {
00111$:
;src/test_impl/audio_tests.c:18: if ((joypad() & J_START) || (joypad() & J_SELECT) || (joypad() & J_A) || (joypad() & J_B) || (joypad() & J_UP) || (joypad() & J_DOWN) || (joypad() & J_LEFT) || (joypad() & J_RIGHT)) {
	call	_joypad
	ld	a, e
	rlca
	jp	C,_ask_user_pass_or_fail
	call	_joypad
	bit	6, e
	jp	NZ,_ask_user_pass_or_fail
	call	_joypad
	bit	4, e
	jp	NZ,_ask_user_pass_or_fail
	call	_joypad
	bit	5, e
	jp	NZ,_ask_user_pass_or_fail
	call	_joypad
	bit	2, e
	jp	NZ,_ask_user_pass_or_fail
	call	_joypad
	bit	3, e
	jp	NZ,_ask_user_pass_or_fail
	call	_joypad
	bit	1, e
	jp	NZ,_ask_user_pass_or_fail
	call	_joypad
	ld	a, e
	rrca
	jp	C,_ask_user_pass_or_fail
;src/test_impl/audio_tests.c:21: NR10_REG = 0x16;
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;src/test_impl/audio_tests.c:22: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;src/test_impl/audio_tests.c:23: NR12_REG = 0x58;
	ld	a, #0x58
	ldh	(_NR12_REG + 0), a
;src/test_impl/audio_tests.c:24: NR13_REG = 0x00;
	xor	a, a
	ldh	(_NR13_REG + 0), a
;src/test_impl/audio_tests.c:25: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;src/test_impl/audio_tests.c:26: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	de
;src/test_impl/audio_tests.c:29: return ask_user_pass_or_fail();
;src/test_impl/audio_tests.c:30: }
	jr	00111$
___str_0:
	.ascii "Playing sound..."
	.db 0x00
	.area _CODE
	.area _INITIALIZER
	.area _CABS (ABS)
