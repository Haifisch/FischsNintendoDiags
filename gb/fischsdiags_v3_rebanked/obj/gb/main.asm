;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _double_rumble
	.globl _start_test
	.globl _audio_test
	.globl b_superuser_enter_hostmode
	.globl _superuser_enter_hostmode
	.globl b_superuser_hold
	.globl _superuser_hold
	.globl b_gblink_test
	.globl _gblink_test
	.globl b_mem_test
	.globl _mem_test
	.globl b_display_test
	.globl _display_test
	.globl b_button_test
	.globl _button_test
	.globl b_text_print_string_bkg
	.globl _text_print_string_bkg
	.globl b_text_load_font
	.globl _text_load_font
	.globl _save_test_result
	.globl _check_savemem
	.globl b_ask_user_pass_or_fail
	.globl _ask_user_pass_or_fail
	.globl b_blank_display
	.globl _blank_display
	.globl b_menu_arrow_display
	.globl _menu_arrow_display
	.globl b_menu_background_display
	.globl _menu_background_display
	.globl _wait_vbl_done
	.globl _reset
	.globl _set_interrupts
	.globl _waitpadup
	.globl _joypad
	.globl _delay
	.globl _EMU_printf
	.globl _initarand
	.globl _CURRENT_INDEX
	.globl _MENU_INDEX_MAX
	.globl _MENU_ARROW_X_FOR_INDEX
	.globl _MENU_ARROW_START_Y
	.globl _MENU_ARROW_START_X
	.globl _rng_seed
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_rng_seed::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
___EMU_PROFILER_INIT:
	.ds 2
_MENU_ARROW_START_X::
	.ds 1
_MENU_ARROW_START_Y::
	.ds 1
_MENU_ARROW_X_FOR_INDEX::
	.ds 6
_MENU_INDEX_MAX::
	.ds 1
_CURRENT_INDEX::
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
	.area _CODE_1
;src/main.c:39: int audio_test()
;	---------------------------------
; Function audio_test
; ---------------------------------
_audio_test::
;src/main.c:41: blank_display();
	ld	e, #b_blank_display
	ld	hl, #_blank_display
	call	___sdcc_bcall_ehl
;src/main.c:42: text_load_font();
	ld	e, #b_text_load_font
	ld	hl, #_text_load_font
	call	___sdcc_bcall_ehl
;src/main.c:43: text_print_string_bkg(0, 2, "Playing sound...");
	ld	de, #___str_0
	push	de
	ld	hl, #0x200
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/main.c:44: text_print_string_bkg(0, 6, "Hold any button");
	ld	de, #___str_1
	push	de
	ld	hl, #0x600
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/main.c:45: text_print_string_bkg(0, 7, "to exit.");
	ld	de, #___str_2
	push	de
	ld	hl, #0x700
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/main.c:46: NR52_REG = 0x80;
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;src/main.c:47: NR50_REG = 0x77; 
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;src/main.c:48: NR51_REG = 0xFF;
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;src/main.c:49: while (1) {
00111$:
;src/main.c:50: if ((joypad() & J_START) || (joypad() & J_SELECT) || (joypad() & J_A) || (joypad() & J_B) || (joypad() & J_UP) || (joypad() & J_DOWN) || (joypad() & J_LEFT) || (joypad() & J_RIGHT)) {
	call	_joypad
	ld	a, e
	rlca
	jr	C, 00112$
	call	_joypad
	bit	6, e
	jr	NZ, 00112$
	call	_joypad
	bit	4, e
	jr	NZ, 00112$
	call	_joypad
	bit	5, e
	jr	NZ, 00112$
	call	_joypad
	bit	2, e
	jr	NZ, 00112$
	call	_joypad
	bit	3, e
	jr	NZ, 00112$
	call	_joypad
	bit	1, e
	jr	NZ, 00112$
	call	_joypad
	ld	a, e
	rrca
	jr	C, 00112$
;src/main.c:53: NR10_REG = 0x16;
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;src/main.c:54: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;src/main.c:55: NR12_REG = 0x58;
	ld	a, #0x58
	ldh	(_NR12_REG + 0), a
;src/main.c:56: NR13_REG = 0x00;
	xor	a, a
	ldh	(_NR13_REG + 0), a
;src/main.c:57: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;src/main.c:58: delay(500);
	ld	de, #0x01f4
	push	de
	call	_delay
	pop	hl
	jr	00111$
00112$:
;src/main.c:60: blank_display();
	ld	e, #b_blank_display
	ld	hl, #_blank_display
	call	___sdcc_bcall_ehl
;src/main.c:61: return ask_user_pass_or_fail();
	ld	e, #b_ask_user_pass_or_fail
	ld	hl, #_ask_user_pass_or_fail
;src/main.c:62: }
	jp  ___sdcc_bcall_ehl
___str_0:
	.ascii "Playing sound..."
	.db 0x00
___str_1:
	.ascii "Hold any button"
	.db 0x00
___str_2:
	.ascii "to exit."
	.db 0x00
;src/main.c:64: void start_test(uint8_t testIdx)
;	---------------------------------
; Function start_test
; ---------------------------------
_start_test::
;src/main.c:66: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_5
	push	de
	ld	de, #0x0042
	push	de
	ld	de, #___str_4
	push	de
	ld	de, #___str_3
	push	de
	call	_EMU_printf
	add	sp, #10
;src/main.c:67: uint8_t testResult = 0;
	ld	e, #0x00
;src/main.c:68: if (testIdx == 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00116$
;src/main.c:70: blank_display();
	push	de
	ld	e, #b_blank_display
	ld	hl, #_blank_display
	call	___sdcc_bcall_ehl
	ld	e, #b_button_test
	ld	hl, #_button_test
	call	___sdcc_bcall_ehl
	pop	de
	jr	00117$
00116$:
;src/main.c:72: } else if (testIdx == 1) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	NZ, 00113$
;src/main.c:74: display_test();
	ld	e, #b_display_test
	ld	hl, #_display_test
	call	___sdcc_bcall_ehl
;src/main.c:75: testResult = ask_user_pass_or_fail();
	ld	e, #b_ask_user_pass_or_fail
	ld	hl, #_ask_user_pass_or_fail
	call	___sdcc_bcall_ehl
	jr	00117$
00113$:
;src/main.c:76: } else if (testIdx == 2) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00110$
;src/main.c:78: blank_display();
	ld	e, #b_blank_display
	ld	hl, #_blank_display
	call	___sdcc_bcall_ehl
;src/main.c:79: text_load_font();
	ld	e, #b_text_load_font
	ld	hl, #_text_load_font
	call	___sdcc_bcall_ehl
;src/main.c:80: testResult = mem_test();
	ld	e, #b_mem_test
	ld	hl, #_mem_test
	call	___sdcc_bcall_ehl
	jr	00117$
00110$:
;src/main.c:81: } else if (testIdx == 3) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00107$
;src/main.c:83: testResult = audio_test();
	call	_audio_test
	jr	00117$
00107$:
;src/main.c:84: } else if (testIdx == 4) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00104$
;src/main.c:86: blank_display();
	ld	e, #b_blank_display
	ld	hl, #_blank_display
	call	___sdcc_bcall_ehl
;src/main.c:87: text_load_font();
	ld	e, #b_text_load_font
	ld	hl, #_text_load_font
	call	___sdcc_bcall_ehl
;src/main.c:88: testResult = gblink_test();
	ld	e, #b_gblink_test
	ld	hl, #_gblink_test
	call	___sdcc_bcall_ehl
	jr	00117$
00104$:
;src/main.c:89: } else if (testIdx == 5) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00117$
;src/main.c:91: reset();
	push	de
	call	_reset
	pop	de
00117$:
;src/main.c:93: EMU_printf("test result => %i", testResult);
	ld	d, #0x00
	push	de
	push	de
	ld	bc, #___str_6
	push	bc
	call	_EMU_printf
	add	sp, #4
	pop	de
;src/main.c:94: save_test_result(testIdx + 1, testResult);
	ldhl	sp,	#2
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	push	de
	push	bc
	call	_save_test_result
	add	sp, #4
;src/main.c:95: menu_background_display();
	ld	e, #b_menu_background_display
	ld	hl, #_menu_background_display
	call	___sdcc_bcall_ehl
;src/main.c:96: menu_arrow_display();
	ld	e, #b_menu_arrow_display
	ld	hl, #_menu_arrow_display
;src/main.c:97: }
	jp  ___sdcc_bcall_ehl
___str_3:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_4:
	.ascii "src/main.c"
	.db 0x00
___str_5:
	.ascii "start_test"
	.db 0x00
___str_6:
	.ascii "test result => %i"
	.db 0x00
;src/main.c:99: void double_rumble() {
;	---------------------------------
; Function double_rumble
; ---------------------------------
_double_rumble::
;src/main.c:100: RUMBLE_ON;
	ld	a, (#0x4000)
	set	3, a
	ld	(#0x4000),a
;src/main.c:101: delay(200);
	ld	de, #0x00c8
	push	de
	call	_delay
	pop	hl
;src/main.c:102: RUMBLE_OFF;
	ld	a, (#0x4000)
	res	3, a
	ld	(#0x4000),a
;src/main.c:103: delay(200);
	ld	de, #0x00c8
	push	de
	call	_delay
	pop	hl
;src/main.c:104: RUMBLE_ON;
	ld	a, (#0x4000)
	set	3, a
	ld	(#0x4000),a
;src/main.c:105: delay(200);
	ld	de, #0x00c8
	push	de
	call	_delay
	pop	hl
;src/main.c:106: RUMBLE_OFF;
	ld	a, (#0x4000)
	res	3, a
	ld	(#0x4000),a
;src/main.c:107: }
	ret
;src/main.c:109: void main() 
;	---------------------------------
; Function main
; ---------------------------------
_main::
	add	sp, #-4
;src/main.c:111: ENABLE_RAM;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/main.c:112: RUMBLE_ON;
	ld	h, #0x40
	ld	a, (hl)
	set	3, a
	ld	(#0x4000),a
;src/main.c:114: uint8_t menu_y = MENU_ARROW_START_Y;
	ld	a, (#_MENU_ARROW_START_Y)
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:115: rng_seed = DIV_REG;
	ldh	a, (_DIV_REG + 0)
	ld	hl, #_rng_seed
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:117: EMU_printf("START (bank=%d)\n", (int)CURRENT_BANK);
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_7
	push	de
	call	_EMU_printf
	add	sp, #4
;X:/gbc_hacks/gbdk/include/gb/gb.h:655: __asm__("ei");
	ei
;src/main.c:119: set_interrupts(VBL_IFLAG | SIO_IFLAG);
	ld	a, #0x09
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src/main.c:120: if (superuser_hold() == 1) {
	ld	e, #b_superuser_hold
	ld	hl, #_superuser_hold
	call	___sdcc_bcall_ehl
	ld	a, e
	dec	a
	or	a, d
	jr	NZ, 00102$
;src/main.c:121: RUMBLE_OFF;
	ld	a, (#0x4000)
	res	3, a
	ld	(#0x4000),a
;src/main.c:122: blank_display();
	ld	e, #b_blank_display
	ld	hl, #_blank_display
	call	___sdcc_bcall_ehl
;src/main.c:123: text_load_font();
	ld	e, #b_text_load_font
	ld	hl, #_text_load_font
	call	___sdcc_bcall_ehl
;src/main.c:124: superuser_enter_hostmode();
	ld	e, #b_superuser_enter_hostmode
	ld	hl, #_superuser_enter_hostmode
	call	___sdcc_bcall_ehl
;src/main.c:125: return;
	jp	00126$
00102$:
;src/main.c:127: check_savemem();
	call	_check_savemem
;src/main.c:128: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/main.c:129: menu_background_display();
	ld	e, #b_menu_background_display
	ld	hl, #_menu_background_display
	call	___sdcc_bcall_ehl
;src/main.c:130: menu_arrow_display();
	ld	e, #b_menu_arrow_display
	ld	hl, #_menu_arrow_display
	call	___sdcc_bcall_ehl
;src/main.c:131: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:133: rng_seed |= (uint16_t)DIV_REG << 8;
	ldh	a, (_DIV_REG + 0)
	ld	c, a
	xor	a, a
	ld	hl, #_rng_seed
	or	a, (hl)
	ld	(hl+), a
	ld	a, c
	or	a, (hl)
;src/main.c:134: initarand(rng_seed);
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_initarand
	pop	hl
;src/main.c:135: RUMBLE_OFF;
	ld	a, (#0x4000)
	res	3, a
	ld	(#0x4000),a
;src/main.c:137: int didRumble = 0;
	ld	bc, #0x0000
;src/main.c:139: while (1) {
	xor	a, a
	ldhl	sp,	#2
	ld	(hl+), a
	ld	(hl), a
00122$:
;src/main.c:140: if (didRumble == 1) {
	ld	a, c
	dec	a
	or	a, b
	jr	NZ, 00107$
;src/main.c:141: if (rumbleDelay > 2) {
	ldhl	sp,	#2
	ld	a, #0x02
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00177$
	bit	7, d
	jr	NZ, 00178$
	cp	a, a
	jr	00178$
00177$:
	bit	7, d
	jr	Z, 00178$
	scf
00178$:
	jr	NC, 00104$
;src/main.c:142: RUMBLE_OFF;
	ld	a, (#0x4000)
	res	3, a
	ld	(#0x4000),a
;src/main.c:143: didRumble = 0;
	ld	bc, #0x0000
	jr	00107$
00104$:
;src/main.c:145: rumbleDelay += 1;
	ldhl	sp,	#2
	inc	(hl)
	jr	NZ, 00179$
	inc	hl
	inc	(hl)
00179$:
00107$:
;src/main.c:148: if (joypad() & J_UP) {
	call	_joypad
;src/main.c:154: menu_y -= 12;
	ldhl	sp,	#0
	ld	a, (hl+)
	ld	(hl), a
;src/main.c:148: if (joypad() & J_UP) {
	bit	2, e
	jr	Z, 00119$
;src/main.c:149: waitpadup();
	call	_waitpadup
;src/main.c:150: RUMBLE_ON;
	ld	a, (#0x4000)
	set	3, a
	ld	(#0x4000),a
;src/main.c:151: didRumble = 1;
	ld	bc, #0x0001
;src/main.c:152: if (CURRENT_INDEX > 0) {
	ld	hl, #_CURRENT_INDEX
	ld	a, (hl)
	or	a, a
	jr	Z, 00120$
;src/main.c:153: CURRENT_INDEX--;
	dec	(hl)
;src/main.c:154: menu_y -= 12;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, #0xf4
	ld	(hl), a
	jr	00120$
00119$:
;src/main.c:156: } else if (joypad() & J_DOWN) {
	call	_joypad
	bit	3, e
	jr	Z, 00116$
;src/main.c:157: waitpadup();
	call	_waitpadup
;src/main.c:158: RUMBLE_ON;
	ld	a, (#0x4000)
	set	3, a
	ld	(#0x4000),a
;src/main.c:159: didRumble = 1;
	ld	bc, #0x0001
;src/main.c:160: if (CURRENT_INDEX < MENU_INDEX_MAX) {
	ld	a, (#_CURRENT_INDEX)
	ld	hl, #_MENU_INDEX_MAX
	sub	a, (hl)
	jr	NC, 00120$
;src/main.c:161: CURRENT_INDEX++;
	ld	hl, #_CURRENT_INDEX
	inc	(hl)
;src/main.c:162: menu_y += 12;
	ldhl	sp,	#1
	ld	a, (hl-)
	add	a, #0x0c
	ld	(hl), a
	jr	00120$
00116$:
;src/main.c:164: } else if (joypad() & J_A || joypad() & J_RIGHT) {
	call	_joypad
	bit	4, e
	jr	NZ, 00112$
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00120$
00112$:
;src/main.c:165: EMU_printf("executing test idx => 0x%x\n", CURRENT_INDEX);
	ld	hl, #_CURRENT_INDEX
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_8
	push	de
	call	_EMU_printf
	add	sp, #4
	pop	bc
;src/main.c:166: waitpadup();
	call	_waitpadup
;src/main.c:167: double_rumble();
	push	bc
	call	_double_rumble
	ld	a, (#_CURRENT_INDEX)
	push	af
	inc	sp
	call	_start_test
	inc	sp
	pop	bc
;src/main.c:169: EMU_printf("returned from start_test (bank=%d)\n", (int)CURRENT_BANK);
	ldh	a, (__current_bank + 0)
	ld	e, a
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_9
	push	de
	call	_EMU_printf
	add	sp, #4
	pop	bc
00120$:
;src/main.c:171: move_sprite(0, MENU_ARROW_X_FOR_INDEX[CURRENT_INDEX], menu_y);
	ld	a, #<(_MENU_ARROW_X_FOR_INDEX)
	ld	hl, #_CURRENT_INDEX
	add	a, (hl)
	ld	e, a
	ld	a, #>(_MENU_ARROW_X_FOR_INDEX)
	adc	a, #0x00
	ld	d, a
	ld	a, (de)
	ldhl	sp,	#1
;X:/gbc_hacks/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
;X:/gbc_hacks/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	(hl-), a
	ld	de, #_shadow_OAM
	ld	a, (hl+)
	ld	(de), a
	inc	de
	ld	a, (hl)
	ld	(de), a
;src/main.c:172: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:173: delay(100);
	push	bc
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
	pop	bc
	jp	00122$
00126$:
;src/main.c:175: }
	add	sp, #4
	ret
___str_7:
	.ascii "START (bank=%d)"
	.db 0x0a
	.db 0x00
___str_8:
	.ascii "executing test idx => 0x%x"
	.db 0x0a
	.db 0x00
___str_9:
	.ascii "returned from start_test (bank=%d)"
	.db 0x0a
	.db 0x00
	.area _CODE_1
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
__xinit__MENU_ARROW_START_X:
	.db #0x44	; 68	'D'
__xinit__MENU_ARROW_START_Y:
	.db #0x36	; 54	'6'
__xinit__MENU_ARROW_X_FOR_INDEX:
	.db #0x44	; 68	'D'
	.db #0x34	; 52	'4'
	.db #0x36	; 54	'6'
	.db #0x36	; 54	'6'
	.db #0x38	; 56	'8'
	.db #0x3c	; 60
__xinit__MENU_INDEX_MAX:
	.db #0x05	; 5
__xinit__CURRENT_INDEX:
	.db #0x00	; 0
	.area _CABS (ABS)
