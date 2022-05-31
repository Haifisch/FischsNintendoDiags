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
	.globl _superuser_hold
	.globl _start_test
	.globl _display_menu
	.globl _move_menu_arrow
	.globl _display_menu_arrow
	.globl _display_menu_bg
	.globl _superuser_enter_hostmode
	.globl _send_data_str
	.globl _wait_for_start
	.globl _toggleRumble
	.globl _gblink_test
	.globl _audio_test
	.globl _button_test
	.globl _display_test
	.globl _show_gblink_background
	.globl _ask_user_pass_or_fail
	.globl _blank_display
	.globl _text_load_font
	.globl _mem_test
	.globl _save_test_result
	.globl _check_savemem
	.globl _set_sprite_palette
	.globl _set_bkg_palette
	.globl _initarand
	.globl _puts
	.globl _printf
	.globl _cls
	.globl _EMU_printf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _reset
	.globl _set_interrupts
	.globl _waitpadup
	.globl _joypad
	.globl _delay
	.globl _receive_byte
	.globl _send_byte
	.globl _CURRENT_INDEX
	.globl _MENU_INDEX_MAX
	.globl _MENU_ARROW_X_FOR_INDEX
	.globl _MENU_ARROW_START_Y
	.globl _MENU_ARROW_START_X
	.globl _rng_seed
	.globl _test_data_str
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
	.area _CODE
;src/main.c:31: int toggleRumble()
;	---------------------------------
; Function toggleRumble
; ---------------------------------
_toggleRumble::
;src/main.c:33: return (*(uint8_t*)0x4000 ^ (1 << (3 - 1)));
	ld	a, (#0x4000)
	xor	a, #0x04
	ld	e, a
	ld	d, #0x00
;src/main.c:34: }
	ret
;src/main.c:50: void wait_for_start() 
;	---------------------------------
; Function wait_for_start
; ---------------------------------
_wait_for_start::
	add	sp, #-6
;src/main.c:52: UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
	ldhl	sp,	#0
	ld	a, l
	ld	d, h
	ldhl	sp,	#4
	ld	(hl+), a
	ld	a, d
	ld	(hl-), a
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	ld	(hl), #0x73
	ldhl	sp,	#4
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	inc	bc
	ld	a, #0x74
	ld	(bc), a
	ld	a, (hl+)
	ld	c, a
	ld	a, (hl-)
	ld	b, a
	inc	bc
	inc	bc
	ld	a, #0x72
	ld	(bc), a
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	ld	a, #0x74
	ld	(bc), a
;src/main.c:54: for (int i = 0; i < 4; ++i)
	ld	bc, #0x0000
00110$:
	ld	a, c
	sub	a, #0x04
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00108$
;src/main.c:56: receive_byte();
	push	bc
	call	_receive_byte
	pop	bc
;src/main.c:58: while (_io_status == IO_RECEIVING);
00101$:
	ld	a, (#__io_status)
	sub	a, #0x02
	jr	Z, 00101$
;src/main.c:59: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/main.c:60: printf("i/o error!\n");
	ld	de, #___str_1
	push	de
	call	_puts
	pop	hl
;src/main.c:61: break;
	jr	00108$
00105$:
;src/main.c:63: if (_io_in == start[i]) {
	ldhl	sp,	#4
	ld	a,	(hl+)
	ld	h, (hl)
	ld	l, a
	add	hl, bc
	ld	e, l
	ld	d, h
	ld	a, (de)
	ld	e, a
	ld	a, (#__io_in)
	sub	a, e
	jr	NZ, 00111$
;src/main.c:64: printf("%c", _io_in);
	ld	hl, #__io_in
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_2
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00111$:
;src/main.c:54: for (int i = 0; i < 4; ++i)
	inc	bc
	jr	00110$
00108$:
;src/main.c:67: printf("\n"); 
	ld	de, #___str_4
	push	de
	call	_puts
	pop	hl
;src/main.c:68: }
	add	sp, #6
	ret
_test_data_str:
	.db #0x46	; 70	'F'
	.db #0x49	; 73	'I'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x48	; 72	'H'
	.db #0x53	; 83	'S'
	.db #0x44	; 68	'D'
	.db #0x49	; 73	'I'
	.db #0x41	; 65	'A'
	.db #0x47	; 71	'G'
	.db #0x53	; 83	'S'
	.db #0x43	; 67	'C'
	.db #0x4f	; 79	'O'
	.db #0x4d	; 77	'M'
	.db #0x4d	; 77	'M'
	.db #0x54	; 84	'T'
	.db #0x45	; 69	'E'
	.db #0x53	; 83	'S'
	.db #0x54	; 84	'T'
	.db #0x44	; 68	'D'
	.db #0x41	; 65	'A'
	.db #0x54	; 84	'T'
	.db #0x41	; 65	'A'
	.db #0x4c	; 76	'L'
	.db #0x49	; 73	'I'
	.db #0x4e	; 78	'N'
	.db #0x4b	; 75	'K'
___str_1:
	.ascii "i/o error!"
	.db 0x00
___str_2:
	.ascii "%c"
	.db 0x00
___str_4:
	.db 0x00
;src/main.c:70: void send_data_str() 
;	---------------------------------
; Function send_data_str
; ---------------------------------
_send_data_str::
	dec	sp
;src/main.c:72: for (int i = 0; i < 0x20; ++i)
	ld	bc, #0x0000
00111$:
	ld	a, c
	sub	a, #0x20
	ld	a, b
	rla
	ccf
	rra
	sbc	a, #0x80
	jr	NC, 00109$
;src/main.c:74: _io_out = test_data_str[i];
	ld	hl, #_test_data_str
	add	hl, bc
	ld	a, (hl)
	ld	(#__io_out),a
;src/main.c:75: send_byte();
	push	bc
	call	_send_byte
	pop	bc
;src/main.c:76: while(_io_status == IO_SENDING);
00101$:
	ld	a, (#__io_status)
	dec	a
	jr	Z, 00101$
;src/main.c:77: if (_io_status == IO_ERROR) {
	ld	a, (#__io_status)
	sub	a, #0x04
	jr	NZ, 00105$
;src/main.c:78: printf("i/o error!\n");
	ld	de, #___str_6
	push	de
	call	_puts
	pop	hl
;src/main.c:79: break;
	jr	00109$
00105$:
;src/main.c:81: if (test_data_str[i] == 0x20) {
	ld	hl, #_test_data_str
	add	hl, bc
	ld	a, (hl)
	ldhl	sp,#0
	ld	(hl), a
	ld	a, (hl)
	sub	a, #0x20
	jr	NZ, 00107$
;src/main.c:82: printf("\n");
	push	bc
	ld	de, #___str_8
	push	de
	call	_puts
	pop	hl
	pop	bc
	jr	00108$
00107$:
;src/main.c:84: printf("%c", test_data_str[i]);
	ldhl	sp,	#0
	ld	e, (hl)
	ld	d, #0x00
	push	bc
	push	de
	ld	de, #___str_9
	push	de
	call	_printf
	add	sp, #4
	pop	bc
00108$:
;src/main.c:86: delay(100);
	push	bc
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
	pop	bc
;src/main.c:72: for (int i = 0; i < 0x20; ++i)
	inc	bc
	jr	00111$
00109$:
;src/main.c:88: printf("\n"); 
	ld	de, #___str_8
	push	de
	call	_puts
	pop	hl
;src/main.c:89: }
	inc	sp
	ret
___str_6:
	.ascii "i/o error!"
	.db 0x00
___str_8:
	.db 0x00
___str_9:
	.ascii "%c"
	.db 0x00
;src/main.c:91: void superuser_enter_hostmode() 
;	---------------------------------
; Function superuser_enter_hostmode
; ---------------------------------
_superuser_enter_hostmode::
;src/main.c:93: PRINT_FUNC_INFO;
	ld	de, #___str_13
	push	de
	ld	de, #0x005d
	push	de
	ld	de, #___str_12
	push	de
	ld	de, #___str_11
	push	de
	call	_EMU_printf
	add	sp, #8
;src/main.c:94: blank_display();
	call	_blank_display
;src/main.c:95: show_gblink_background();
	call	_show_gblink_background
;src/main.c:96: text_load_font();
	call	_text_load_font
;src/main.c:97: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:99: while(1) {
00102$:
;src/main.c:100: cls();
	call	_cls
;src/main.c:101: printf("\n\nwaiting for init\n");
	ld	de, #___str_15
	push	de
	call	_puts
	pop	hl
;src/main.c:102: wait_for_start();
	call	_wait_for_start
;src/main.c:103: printf("received init!\nsending big string\n");
	ld	de, #___str_17
	push	de
	call	_puts
	pop	hl
;src/main.c:104: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;src/main.c:105: send_data_str();
	call	_send_data_str
;src/main.c:106: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/main.c:107: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:109: }
	jr	00102$
___str_11:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_12:
	.ascii "src/main.c"
	.db 0x00
___str_13:
	.ascii "superuser_enter_hostmode"
	.db 0x00
___str_15:
	.db 0x0a
	.db 0x0a
	.ascii "waiting for init"
	.db 0x00
___str_17:
	.ascii "received init!"
	.db 0x0a
	.ascii "sending big string"
	.db 0x00
;src/main.c:112: void display_menu_bg()  {
;	---------------------------------
; Function display_menu_bg
; ---------------------------------
_display_menu_bg::
;src/main.c:113: PRINT_FUNC_INFO;
	ld	de, #___str_20
	push	de
	ld	de, #0x0071
	push	de
	ld	de, #___str_19
	push	de
	ld	de, #___str_18
	push	de
	call	_EMU_printf
	add	sp, #8
;src/main.c:114: HIDE_BKG;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfe
	ldh	(_LCDC_REG + 0), a
;src/main.c:115: set_bkg_palette(0, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:116: set_bkg_palette(1, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	hl, #0x101
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:117: set_bkg_palette(2, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	hl, #0x102
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:118: set_bkg_palette(3, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	hl, #0x103
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:119: set_bkg_palette(4, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	hl, #0x104
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:120: set_bkg_palette(5, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	hl, #0x105
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:121: set_bkg_palette(6, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	hl, #0x106
	push	hl
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:122: set_bkg_palette(7, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	ld	a, #0x01
	push	af
	inc	sp
	ld	a, #0x07
	push	af
	inc	sp
	call	_set_bkg_palette
	add	sp, #4
;src/main.c:123: PRINT_BANK_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_21
	push	de
	call	_EMU_printf
	add	sp, #4
;src/main.c:124: set_bkg_data(0, menu_background_TILE_COUNT, menu_background_tiles);
	ld	de, #_menu_background_tiles
	push	de
	ld	hl, #0x7500
	push	hl
	call	_set_bkg_data
	add	sp, #4
;src/main.c:125: VBK_REG = 1;
	ld	a, #0x01
	ldh	(_VBK_REG + 0), a
;src/main.c:126: set_bkg_tiles(0, 0, 20, 18, menu_background_map_attributes);
	ld	de, #_menu_background_map_attributes
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:127: VBK_REG = 0;
	xor	a, a
	ldh	(_VBK_REG + 0), a
;src/main.c:128: set_bkg_tiles(0, 0, 20, 18, menu_background_map);
	ld	de, #_menu_background_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;src/main.c:129: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;src/main.c:130: }
	ret
___str_18:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_19:
	.ascii "src/main.c"
	.db 0x00
___str_20:
	.ascii "display_menu_bg"
	.db 0x00
___str_21:
	.ascii "[DBG] bank => %d"
	.db 0x00
;src/main.c:133: void display_menu_arrow() {
;	---------------------------------
; Function display_menu_arrow
; ---------------------------------
_display_menu_arrow::
;src/main.c:134: PRINT_FUNC_INFO;
	ld	de, #___str_24
	push	de
	ld	de, #0x0086
	push	de
	ld	de, #___str_23
	push	de
	ld	de, #___str_22
	push	de
	call	_EMU_printf
	add	sp, #8
;src/main.c:135: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/main.c:136: set_sprite_palette(0, 1, menu_background_palettes);
	ld	de, #_menu_background_palettes
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_palette
	add	sp, #4
;src/main.c:137: set_sprite_data(0, 8, menu_arrow_tiles);
	ld	de, #_menu_arrow_tiles
	push	de
	ld	hl, #0x800
	push	hl
	call	_set_sprite_data
	add	sp, #4
;X:/gbc_hacks/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;src/main.c:139: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/main.c:140: }
	ret
___str_22:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_23:
	.ascii "src/main.c"
	.db 0x00
___str_24:
	.ascii "display_menu_arrow"
	.db 0x00
;src/main.c:142: void move_menu_arrow(uint8_t menu_x, uint8_t menu_y) 
;	---------------------------------
; Function move_menu_arrow
; ---------------------------------
_move_menu_arrow::
;src/main.c:144: move_sprite(0, menu_x, menu_y);
	ldhl	sp,	#3
	ld	a, (hl-)
	ld	b, a
	ld	c, (hl)
;X:/gbc_hacks/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;X:/gbc_hacks/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;src/main.c:144: move_sprite(0, menu_x, menu_y);
;src/main.c:145: }
	ret
;src/main.c:147: void display_menu()  
;	---------------------------------
; Function display_menu
; ---------------------------------
_display_menu::
;src/main.c:149: PRINT_FUNC_INFO;
	ld	de, #___str_27
	push	de
	ld	de, #0x0095
	push	de
	ld	de, #___str_26
	push	de
	ld	de, #___str_25
	push	de
	call	_EMU_printf
	add	sp, #8
;src/main.c:153: display_menu_bg();
	call	_display_menu_bg
;src/main.c:154: display_menu_arrow();
	call	_display_menu_arrow
;src/main.c:155: text_load_font();
;src/main.c:156: }
	jp	_text_load_font
___str_25:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_26:
	.ascii "src/main.c"
	.db 0x00
___str_27:
	.ascii "display_menu"
	.db 0x00
;src/main.c:158: void start_test(uint8_t testIdx) 
;	---------------------------------
; Function start_test
; ---------------------------------
_start_test::
;src/main.c:160: PRINT_FUNC_INFO;
	ld	de, #___str_30
	push	de
	xor	a, a
	and	a
	push	af
	ld	de, #___str_29
	push	de
	ld	de, #___str_28
	push	de
	call	_EMU_printf
	add	sp, #8
;src/main.c:161: uint8_t testResult = 0;
	ld	e, #0x00
;src/main.c:162: if (testIdx == 0) {
	ldhl	sp,	#2
	ld	a, (hl)
	or	a, a
	jr	NZ, 00116$
;src/main.c:164: testResult = button_test();
	call	_button_test
	jr	00117$
00116$:
;src/main.c:165: } else if (testIdx == 1) {
	ldhl	sp,	#2
	ld	a, (hl)
	dec	a
	jr	NZ, 00113$
;src/main.c:167: display_test();
	call	_display_test
;src/main.c:168: testResult = ask_user_pass_or_fail();
	call	_ask_user_pass_or_fail
	jr	00117$
00113$:
;src/main.c:169: } else if (testIdx == 2) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x02
	jr	NZ, 00110$
;src/main.c:171: blank_display();
	call	_blank_display
;src/main.c:172: testResult = mem_test();
	call	_mem_test
	jr	00117$
00110$:
;src/main.c:173: } else if (testIdx == 3) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x03
	jr	NZ, 00107$
;src/main.c:175: testResult = audio_test();
	call	_audio_test
	jr	00117$
00107$:
;src/main.c:176: } else if (testIdx == 4) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x04
	jr	NZ, 00104$
;src/main.c:178: testResult = gblink_test();
	call	_gblink_test
	jr	00117$
00104$:
;src/main.c:179: } else if (testIdx == 5) {
	ldhl	sp,	#2
	ld	a, (hl)
	sub	a, #0x05
	jr	NZ, 00117$
;src/main.c:181: reset();
	push	de
	call	_reset
	pop	de
00117$:
;src/main.c:183: EMU_printf("test result => %x", testResult);
	ld	d, #0x00
	push	de
	push	de
	ld	bc, #___str_31
	push	bc
	call	_EMU_printf
	add	sp, #4
	pop	de
;src/main.c:184: save_test_result(testIdx + 1, testResult);
	ldhl	sp,	#2
	ld	c, (hl)
	ld	b, #0x00
	inc	bc
	push	de
	push	bc
	call	_save_test_result
	add	sp, #4
;src/main.c:185: display_menu();
;src/main.c:186: }
	jp	_display_menu
___str_28:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_29:
	.ascii "src/main.c"
	.db 0x00
___str_30:
	.ascii "start_test"
	.db 0x00
___str_31:
	.ascii "test result => %x"
	.db 0x00
;src/main.c:188: int superuser_hold()
;	---------------------------------
; Function superuser_hold
; ---------------------------------
_superuser_hold::
;src/main.c:190: PRINT_FUNC_INFO;
	ld	de, #___str_34
	push	de
	ld	de, #0x00be
	push	de
	ld	de, #___str_33
	push	de
	ld	de, #___str_32
	push	de
	call	_EMU_printf
	add	sp, #8
;src/main.c:193: int isSuper = 0;
	ld	bc, #0x0000
;src/main.c:195: while (delayInc > 0) {
	ld	hl, #0x0002
00105$:
	ld	e, h
	xor	a, a
	ld	d, a
	cp	a, l
	sbc	a, h
	bit	7, e
	jr	Z, 00130$
	bit	7, d
	jr	NZ, 00131$
	cp	a, a
	jr	00131$
00130$:
	bit	7, d
	jr	Z, 00131$
	scf
00131$:
	jr	NC, 00107$
;src/main.c:199: if (joypad() & J_START && joypad() & J_SELECT) {
	push	hl
	call	_joypad
	ld	a, e
	pop	hl
	rlca
	jr	NC, 00102$
	push	hl
	call	_joypad
	pop	hl
	bit	6, e
	jr	Z, 00102$
;src/main.c:200: isSuper = 1;
	ld	bc, #0x0001
;src/main.c:201: printf("you are super.\n");
	push	bc
	ld	de, #___str_36
	push	de
	call	_puts
	pop	hl
	pop	bc
;src/main.c:202: waitpadup();
	call	_waitpadup
;src/main.c:203: break;
	jr	00107$
00102$:
;src/main.c:205: isSuper = 0;
;src/main.c:207: delayInc--;
	dec	hl
	ld	bc, #0x0000
;src/main.c:208: delay(1000);
	push	hl
	push	bc
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
	pop	bc
	pop	hl
	jr	00105$
00107$:
;src/main.c:210: return isSuper;
	ld	e, c
	ld	d, b
;src/main.c:211: }
	ret
___str_32:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_33:
	.ascii "src/main.c"
	.db 0x00
___str_34:
	.ascii "superuser_hold"
	.db 0x00
___str_36:
	.ascii "you are super."
	.db 0x00
;src/main.c:214: void main(void)
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
;src/main.c:216: ENABLE_RAM;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;X:/gbc_hacks/gbdk/include/gb/gb.h:655: __asm__("ei");
	ei
;src/main.c:218: PRINT_FUNC_INFO;
	ld	de, #___str_39
	push	de
	ld	de, #0x00da
	push	de
	ld	de, #___str_38
	push	de
	ld	de, #___str_37
	push	de
	call	_EMU_printf
	add	sp, #8
;src/main.c:219: rng_seed = DIV_REG;
	ldh	a, (_DIV_REG + 0)
	ld	hl, #_rng_seed
	ld	(hl+), a
	ld	(hl), #0x00
;src/main.c:220: uint8_t menu_y = MENU_ARROW_START_Y;
	ld	a, (#_MENU_ARROW_START_Y)
	ldhl	sp,	#0
	ld	(hl), a
;src/main.c:221: set_interrupts(VBL_IFLAG | SIO_IFLAG);
	ld	a, #0x09
	push	af
	inc	sp
	call	_set_interrupts
	inc	sp
;src/main.c:222: if (superuser_hold() == 1) {
	call	_superuser_hold
	ld	a, e
	dec	a
	or	a, d
	jr	NZ, 00102$
;src/main.c:223: superuser_enter_hostmode();
	call	_superuser_enter_hostmode
00102$:
;src/main.c:225: check_savemem();
	call	_check_savemem
;src/main.c:226: wait_vbl_done();
	call	_wait_vbl_done
;src/main.c:227: delay(500);
	ld	de, #0x01f4
	push	de
	call	_delay
	pop	hl
;src/main.c:228: display_menu();
	call	_display_menu
;src/main.c:229: rng_seed |= (uint16_t)DIV_REG << 8;
	ldh	a, (_DIV_REG + 0)
	ld	c, a
	xor	a, a
	ld	hl, #_rng_seed
	or	a, (hl)
	ld	(hl+), a
	ld	a, c
	or	a, (hl)
;src/main.c:230: initarand(rng_seed);
	ld	(hl-), a
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	call	_initarand
	pop	hl
;src/main.c:232: while(1) {
00117$:
;src/main.c:233: if (joypad() & J_UP) {
	call	_joypad
;src/main.c:237: menu_y -= 12;
	ldhl	sp,	#0
	ld	b, (hl)
;src/main.c:233: if (joypad() & J_UP) {
	bit	2, e
	jr	Z, 00114$
;src/main.c:234: waitpadup();
	call	_waitpadup
;src/main.c:235: if (CURRENT_INDEX > 0) {
	ld	hl, #_CURRENT_INDEX
	ld	a, (hl)
	or	a, a
	jr	Z, 00104$
;src/main.c:236: CURRENT_INDEX--;
	dec	(hl)
;src/main.c:237: menu_y -= 12;
	ld	a, b
	add	a, #0xf4
	ldhl	sp,	#0
	ld	(hl), a
00104$:
;src/main.c:239: toggleRumble();
	call	_toggleRumble
	jr	00115$
00114$:
;src/main.c:240: } else if (joypad() & J_DOWN) {
	call	_joypad
	bit	3, e
	jr	Z, 00111$
;src/main.c:241: waitpadup();
	call	_waitpadup
;src/main.c:242: if (CURRENT_INDEX < MENU_INDEX_MAX) {
	ld	a, (#_CURRENT_INDEX)
	ld	hl, #_MENU_INDEX_MAX
	sub	a, (hl)
	jr	NC, 00115$
;src/main.c:243: CURRENT_INDEX++;
	ld	hl, #_CURRENT_INDEX
	inc	(hl)
;src/main.c:244: menu_y += 12;
	ld	a, b
	add	a, #0x0c
	ldhl	sp,	#0
	ld	(hl), a
	jr	00115$
00111$:
;src/main.c:247: } else if (joypad() & J_A || joypad() & J_LEFT) {
	call	_joypad
	bit	4, e
	jr	NZ, 00107$
	call	_joypad
	bit	1, e
	jr	Z, 00115$
00107$:
;src/main.c:248: EMU_printf("executing test idx => 0x%x\n", CURRENT_INDEX);
	ld	hl, #_CURRENT_INDEX
	ld	c, (hl)
	ld	b, #0x00
	push	bc
	ld	de, #___str_40
	push	de
	call	_EMU_printf
	add	sp, #4
;src/main.c:249: waitpadup();
	call	_waitpadup
;src/main.c:250: start_test(CURRENT_INDEX);
	ld	a, (#_CURRENT_INDEX)
	push	af
	inc	sp
	call	_start_test
	inc	sp
00115$:
;src/main.c:254: move_menu_arrow(MENU_ARROW_X_FOR_INDEX[CURRENT_INDEX], menu_y);
	ld	a, #<(_MENU_ARROW_X_FOR_INDEX)
	ld	hl, #_CURRENT_INDEX
	add	a, (hl)
	ld	c, a
	ld	a, #>(_MENU_ARROW_X_FOR_INDEX)
	adc	a, #0x00
	ld	b, a
	ld	a, (bc)
	ldhl	sp,	#0
	ld	h, (hl)
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	_move_menu_arrow
	pop	hl
;src/main.c:255: wait_vbl_done();
	call	_wait_vbl_done
	jp	00117$
;src/main.c:258: }
	inc	sp
	ret
___str_37:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_38:
	.ascii "src/main.c"
	.db 0x00
___str_39:
	.ascii "main"
	.db 0x00
___str_40:
	.ascii "executing test idx => 0x%x"
	.db 0x0a
	.db 0x00
	.area _CODE
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
