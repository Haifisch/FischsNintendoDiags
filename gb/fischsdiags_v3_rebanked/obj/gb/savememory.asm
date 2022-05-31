;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module savememory
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl b___func_mem_test
	.globl ___func_mem_test
	.globl _ram_sprite_clear
	.globl _ram_sprite_display
	.globl _ram_sprite_move
	.globl _print_counter
	.globl _init_savemem
	.globl _inc_hiram
	.globl _inc_ram
	.globl _inc_end
	.globl _inc
	.globl b_text_print_string_bkg
	.globl _text_print_string_bkg
	.globl _set_sprite_palette
	.globl _memset
	.globl _memcpy
	.globl _sprintf
	.globl _EMU_printf
	.globl _set_sprite_data
	.globl _hiramcpy
	.globl _delay
	.globl _inc_hiram_var
	.globl _inc_ram_var
	.globl _memTestCounter
	.globl _endData
	.globl _results
	.globl _firstRunByte
	.globl _hiram_buffer
	.globl _ram_buffer
	.globl _save_test_result
	.globl _check_savemem
	.globl b_mem_test
	.globl _mem_test
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_ram_buffer	=	0xd000
_hiram_buffer	=	0xffa0
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
___EMU_PROFILER_INIT:
	.ds 2
_firstRunByte::
	.ds 2
_results::
	.ds 2
_endData::
	.ds 2
_memTestCounter::
	.ds 2
_inc_ram_var::
	.ds 2
_inc_hiram_var::
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
	.area _CODE_1
;src/savememory.c:20: void inc() {
;	---------------------------------
; Function inc
; ---------------------------------
_inc::
;src/savememory.c:21: memTestCounter++;
	ld	hl, #_memTestCounter
	inc	(hl)
	ret	NZ
	inc	hl
	inc	(hl)
;src/savememory.c:22: }
	ret
;src/savememory.c:25: void inc_end() {} 
;	---------------------------------
; Function inc_end
; ---------------------------------
_inc_end::
	ret
;src/savememory.c:48: void save_test_result(int testType, int testResult) {
;	---------------------------------
; Function save_test_result
; ---------------------------------
_save_test_result::
;src/savememory.c:49: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_2
	push	de
	ld	de, #0x0031
	push	de
	ld	de, #___str_1
	push	de
	ld	de, #___str_0
	push	de
	call	_EMU_printf
	add	sp, #10
;src/savememory.c:53: memcpy(results->BUTTON_TEST, "OK", 2);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/savememory.c:51: if (testType == 1) {
	ldhl	sp,	#2
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	NZ, 00128$
;src/savememory.c:53: memcpy(results->BUTTON_TEST, "OK", 2);
	ld	hl, #0x0007
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:52: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
;src/savememory.c:53: memcpy(results->BUTTON_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00102$:
;src/savememory.c:55: memcpy(results->BUTTON_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00128$:
;src/savememory.c:57: } else if (testType == 2) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x02
	or	a, (hl)
	jr	NZ, 00125$
;src/savememory.c:59: memcpy(results->DISPLAY_TEST, "OK", 2);
	ld	hl, #0x000c
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:58: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00105$
;src/savememory.c:59: memcpy(results->DISPLAY_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00105$:
;src/savememory.c:61: memcpy(results->DISPLAY_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00125$:
;src/savememory.c:63: } else if (testType == 3) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x03
	or	a, (hl)
	jr	NZ, 00122$
;src/savememory.c:65: memcpy(results->MEMORY_TEST, "OK", 2);
	ld	hl, #0x0011
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:64: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00108$
;src/savememory.c:65: memcpy(results->MEMORY_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00108$:
;src/savememory.c:67: memcpy(results->MEMORY_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00122$:
;src/savememory.c:69: } else if (testType == 4) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x04
	or	a, (hl)
	jr	NZ, 00119$
;src/savememory.c:71: memcpy(results->AUDIO_TEST, "OK", 2);
	ld	hl, #0x0016
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:70: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00111$
;src/savememory.c:71: memcpy(results->AUDIO_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00111$:
;src/savememory.c:73: memcpy(results->AUDIO_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00119$:
;src/savememory.c:75: } else if (testType == 5) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x05
	or	a, (hl)
	ret	NZ
;src/savememory.c:77: memcpy(results->LINK_TEST, "OK", 2);
	ld	hl, #0x001b
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:76: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00114$
;src/savememory.c:77: memcpy(results->LINK_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00114$:
;src/savememory.c:79: memcpy(results->LINK_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
;src/savememory.c:83: }
	ret
___str_0:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_1:
	.ascii "src/savememory.c"
	.db 0x00
___str_2:
	.ascii "save_test_result"
	.db 0x00
___str_3:
	.ascii "OK"
	.db 0x00
___str_4:
	.ascii "NO"
	.db 0x00
;src/savememory.c:86: void init_savemem() {
;	---------------------------------
; Function init_savemem
; ---------------------------------
_init_savemem::
;src/savememory.c:87: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_7
	push	de
	ld	de, #0x0057
	push	de
	ld	de, #___str_6
	push	de
	ld	de, #___str_5
	push	de
	call	_EMU_printf
	add	sp, #10
;src/savememory.c:88: for (UWORD uwI = 0xa000; uwI <= 0x7FFF; uwI+=2)
	ld	bc, #0xa000
00103$:
	ld	a, #0xff
	cp	a, c
	ld	a, #0x7f
	sbc	a, b
	jr	C, 00101$
;src/savememory.c:91: memcpy((UWORD *)uwI, 0x0000, sizeof(UWORD));
	ld	e, c
	ld	d, b
	ld	hl, #0x0002
	push	hl
	ld	l, h
	push	hl
	push	de
	call	_memcpy
	add	sp, #6
;src/savememory.c:88: for (UWORD uwI = 0xa000; uwI <= 0x7FFF; uwI+=2)
	inc	bc
	inc	bc
	jr	00103$
00101$:
;src/savememory.c:93: memset(results, 0x0, sizeof(TEST_SAVED_RESULTS));
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x001d
	push	de
	ld	de, #0x0000
	push	de
	push	bc
	call	_memset
	add	sp, #6
;src/savememory.c:94: memcpy(results->magic, "fsch", 4);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	de, #0x0004
	push	de
	ld	de, #___str_8
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
;src/savememory.c:95: memcpy(results->BUTTON_TEST_MAGIC, "btn", 3);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	inc	bc
	inc	bc
	inc	bc
	inc	bc
	ld	de, #0x0003
	push	de
	ld	de, #___str_9
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
;src/savememory.c:96: memcpy(results->MEMORY_TEST_MAGIC, "mem", 3);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000e
	add	hl, bc
	ld	de, #0x0003
	push	de
	ld	de, #___str_10
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:97: memcpy(results->DISPLAY_TEST_MAGIC, "gfx", 3);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0009
	add	hl, bc
	ld	de, #0x0003
	push	de
	ld	de, #___str_11
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:98: memcpy(results->AUDIO_TEST_MAGIC, "sfx", 3);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0013
	add	hl, bc
	ld	de, #0x0003
	push	de
	ld	de, #___str_12
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:99: memcpy(results->LINK_TEST_MAGIC, "lnk", 3);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0018
	add	hl, bc
	ld	de, #0x0003
	push	de
	ld	de, #___str_13
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:100: memcpy(results->BUTTON_TEST, "NO", 2);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0007
	add	hl, bc
	ld	de, #0x0002
	push	de
	ld	de, #___str_14
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:101: memcpy(results->DISPLAY_TEST, "NO", 2);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x000c
	add	hl, bc
	ld	de, #0x0002
	push	de
	ld	de, #___str_14
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:102: memcpy(results->MEMORY_TEST, "NO", 2);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0011
	add	hl, bc
	ld	de, #0x0002
	push	de
	ld	de, #___str_14
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:103: memcpy(results->AUDIO_TEST, "NO", 2);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x0016
	add	hl, bc
	ld	de, #0x0002
	push	de
	ld	de, #___str_14
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:104: memcpy(results->LINK_TEST, "NO", 2);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	hl, #0x001b
	add	hl, bc
	ld	de, #0x0002
	push	de
	ld	de, #___str_14
	push	de
	push	hl
	call	_memcpy
	add	sp, #6
;src/savememory.c:106: endData[0] = 0x4141;
	ld	hl, #_endData
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_endData + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	a, #0x41
	ld	(hl+), a
	ld	(hl), #0x41
;src/savememory.c:107: firstRunByte[0] = 1;
	ld	hl, #_firstRunByte
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_firstRunByte + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(hl), #0x01
;src/savememory.c:108: }
	ret
___str_5:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_6:
	.ascii "src/savememory.c"
	.db 0x00
___str_7:
	.ascii "init_savemem"
	.db 0x00
___str_8:
	.ascii "fsch"
	.db 0x00
___str_9:
	.ascii "btn"
	.db 0x00
___str_10:
	.ascii "mem"
	.db 0x00
___str_11:
	.ascii "gfx"
	.db 0x00
___str_12:
	.ascii "sfx"
	.db 0x00
___str_13:
	.ascii "lnk"
	.db 0x00
___str_14:
	.ascii "NO"
	.db 0x00
;src/savememory.c:111: void check_savemem() {
;	---------------------------------
; Function check_savemem
; ---------------------------------
_check_savemem::
;src/savememory.c:112: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_17
	push	de
	ld	de, #0x0070
	push	de
	ld	de, #___str_16
	push	de
	ld	de, #___str_15
	push	de
	call	_EMU_printf
	add	sp, #10
;src/savememory.c:114: if (firstRunByte[0] != 0x35) {
	ld	hl, #_firstRunByte
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	sub	a, #0x35
;src/savememory.c:115: init_savemem();
	jp	NZ,_init_savemem
;src/savememory.c:118: }
	ret
___str_15:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_16:
	.ascii "src/savememory.c"
	.db 0x00
___str_17:
	.ascii "check_savemem"
	.db 0x00
;src/savememory.c:120: void print_counter() {
;	---------------------------------
; Function print_counter
; ---------------------------------
_print_counter::
	add	sp, #-16
;src/savememory.c:121: EMU_printf("counter is %u\n", memTestCounter);
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_18
	push	de
	call	_EMU_printf
	add	sp, #4
;src/savememory.c:123: sprintf(buff, "Counter is %u", memTestCounter);
	ldhl	sp,	#0
	ld	c, l
	ld	b, h
	ld	e, c
	ld	d, b
	push	bc
	ld	hl, #_memTestCounter
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_memTestCounter + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	ld	hl, #___str_19
	push	hl
	push	de
	call	_sprintf
	add	sp, #6
	ld	hl, #0x502
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
;src/savememory.c:125: }
	add	sp, #20
	ret
___str_18:
	.ascii "counter is %u"
	.db 0x0a
	.db 0x00
___str_19:
	.ascii "Counter is %u"
	.db 0x00
;src/savememory.c:128: void ram_sprite_move(uint8_t arrow_x, uint8_t arrow_y) {
;	---------------------------------
; Function ram_sprite_move
; ---------------------------------
_ram_sprite_move::
	add	sp, #-8
;src/savememory.c:129: uint8_t arrow_x_offset = arrow_x;
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#2
	ld	(hl), a
;src/savememory.c:130: uint8_t arrow_tile = 0;
	ldhl	sp,	#7
;src/savememory.c:131: for (uint8_t q = 0; q < 4; ++q)
	xor	a, a
	ld	(hl-), a
	dec	hl
	ld	(hl), #0x00
00108$:
	ldhl	sp,	#5
	ld	a, (hl)
	sub	a, #0x04
	jr	NC, 00110$
;src/savememory.c:133: for (uint8_t t = 0; t < 8; ++t)
	ldhl	sp,	#11
	ld	a, (hl)
	ldhl	sp,	#3
	ld	(hl), a
	ldhl	sp,	#7
	ld	a, (hl-)
	ld	(hl+), a
	ld	(hl), #0x00
00105$:
	ldhl	sp,	#7
	ld	a, (hl)
	sub	a, #0x08
	jr	NC, 00116$
;src/savememory.c:135: move_sprite(arrow_tile, arrow_x, arrow_y);
	ldhl	sp,	#10
	ld	a, (hl)
	ldhl	sp,	#4
;X:/gbc_hacks/gbdk/include/gb/gb.h:1520: OAM_item_t * itm = &shadow_OAM[nb];
	ld	(hl+), a
	inc	hl
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	ld	c, l
	ld	b, h
;X:/gbc_hacks/gbdk/include/gb/gb.h:1521: itm->y=y, itm->x=x;
	ldhl	sp,	#3
	ld	a, (hl+)
	ld	(bc), a
	inc	bc
	inc	sp
	inc	sp
	ld	e, c
	ld	d, b
	push	de
	ld	a, (hl)
	ld	(de), a
;src/savememory.c:136: arrow_x += 8;
	ld	a, (hl)
	add	a, #0x08
	ldhl	sp,	#10
	ld	(hl), a
;src/savememory.c:137: arrow_tile++;
	ldhl	sp,	#6
	inc	(hl)
;src/savememory.c:133: for (uint8_t t = 0; t < 8; ++t)
	inc	hl
	inc	(hl)
	jr	00105$
00116$:
	ldhl	sp,	#6
	ld	a, (hl+)
	ld	(hl), a
;src/savememory.c:139: arrow_y += 8;
	ldhl	sp,	#11
	ld	a, (hl)
	add	a, #0x08
	ld	(hl), a
;src/savememory.c:140: arrow_x = arrow_x_offset;
	ldhl	sp,	#2
	ld	a, (hl)
	ldhl	sp,	#10
	ld	(hl), a
;src/savememory.c:131: for (uint8_t q = 0; q < 4; ++q)
	ldhl	sp,	#5
	inc	(hl)
	jr	00108$
00110$:
;src/savememory.c:142: }
	add	sp, #8
	ret
;src/savememory.c:145: void ram_sprite_display() 
;	---------------------------------
; Function ram_sprite_display
; ---------------------------------
_ram_sprite_display::
	add	sp, #-8
;src/savememory.c:147: SPRITES_8x8;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfb
	ldh	(_LCDC_REG + 0), a
;src/savememory.c:148: palette_color_t ram_sprite_palettes[4] = {
	ldhl	sp,	#0
	ld	c,l
	ld	b,h
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
	ld	l, c
;	spillPairReg hl
;	spillPairReg hl
	ld	h, b
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	inc	hl
	xor	a, a
	ld	(hl+), a
	ld	(hl), #0x5c
	ld	hl, #0x0004
	add	hl, bc
	ld	a, #0x1f
	ld	(hl+), a
	ld	(hl), #0x00
	ld	hl, #0x0006
	add	hl, bc
	ld	a, #0xff
	ld	(hl+), a
	ld	(hl), #0x7f
;src/savememory.c:151: set_sprite_palette(0, 1, ram_sprite_palettes);
	push	bc
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_palette
	add	sp, #4
;src/savememory.c:152: set_sprite_data(0, RAM_SPRITE_TILE_COUNT, RAM_SPRITE);
	ld	de, #_RAM_SPRITE
	push	de
	ld	hl, #0x2000
	push	hl
	call	_set_sprite_data
	add	sp, #4
;src/savememory.c:154: uint8_t arrow_tile_idx = 0;
;src/savememory.c:156: for (uint8_t i = 0; i < 32; ++i)
	ld	bc, #0x0
00104$:
	ld	a, b
	sub	a, #0x20
	jr	NC, 00106$
;X:/gbc_hacks/gbdk/include/gb/gb.h:1447: shadow_OAM[nb].tile=tile;
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
	inc	hl
	inc	hl
	ld	(hl), c
;src/savememory.c:159: arrow_tile_idx += 1;
	inc	c
;src/savememory.c:156: for (uint8_t i = 0; i < 32; ++i)
	inc	b
	jr	00104$
00106$:
;src/savememory.c:161: }
	add	sp, #8
	ret
;src/savememory.c:163: void ram_sprite_clear() 
;	---------------------------------
; Function ram_sprite_clear
; ---------------------------------
_ram_sprite_clear::
;src/savememory.c:166: for (uint8_t q = 0; q < 32; ++q)
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x20
	jr	NC, 00101$
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
;src/savememory.c:166: for (uint8_t q = 0; q < 32; ++q)
	inc	c
	jr	00104$
00101$:
;src/savememory.c:170: HIDE_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	and	a, #0xfd
	ldh	(_LCDC_REG + 0), a
;src/savememory.c:171: }
	ret
;src/savememory.c:173: BANKREF(mem_test)
;	---------------------------------
; Function __func_mem_test
; ---------------------------------
	b___func_mem_test	= 1
___func_mem_test::
	.local b___func_mem_test 
	___bank_mem_test = b___func_mem_test 
	.globl ___bank_mem_test 
;src/savememory.c:174: int mem_test() BANKED {
;	---------------------------------
; Function mem_test
; ---------------------------------
	b_mem_test	= 1
_mem_test::
;src/savememory.c:175: PRINT_FUNC_INFO;
	ldh	a, (__current_bank + 0)
	ld	c, a
	ld	b, #0x00
	push	bc
	ld	de, #___str_22
	push	de
	ld	de, #0x00af
	push	de
	ld	de, #___str_21
	push	de
	ld	de, #___str_20
	push	de
	call	_EMU_printf
	add	sp, #10
;src/savememory.c:179: ram_sprite_display();
	call	_ram_sprite_display
;src/savememory.c:180: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x6048
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:181: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;src/savememory.c:183: if (memTestCounter != 0) {
	ld	hl, #_memTestCounter + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
;src/savememory.c:184: memTestCounter = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00102$:
;src/savememory.c:190: text_print_string_bkg(TEXT_X_OFFSET, 2, "CHECKING MEMORY");
	ld	de, #___str_23
	push	de
	ld	hl, #0x201
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:191: if (results->magic[0] == 0x66 && results->magic[1] == 0x73 && results->magic[2] == 0x63 && results->magic[3] == 0x68) {
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	sub	a, #0x66
	jr	NZ, 00104$
	dec	hl
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	e, c
	ld	d, b
	inc	de
	ld	a, (de)
	sub	a, #0x73
	jr	NZ, 00104$
	ld	e, c
	ld	d, b
	inc	de
	inc	de
	ld	a, (de)
	sub	a, #0x63
	jr	NZ, 00104$
	inc	bc
	inc	bc
	inc	bc
	ld	a, (bc)
	sub	a, #0x68
	jr	NZ, 00104$
;src/savememory.c:192: text_print_string_bkg(TEXT_X_OFFSET, 3, "MAGIC OK");
	ld	de, #___str_24
	push	de
	ld	hl, #0x301
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
	jr	00105$
00104$:
;src/savememory.c:194: text_print_string_bkg(TEXT_X_OFFSET, 3, "BAD MAGIC");
	ld	de, #___str_25
	push	de
	ld	hl, #0x301
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
00105$:
;src/savememory.c:198: hiramcpy((uint8_t)&hiram_buffer, (void *)&inc, (uint8_t)object_distance(inc, inc_end));
	ld	a, #<(_inc_end)
	ld	bc, #_inc
	ld	e, c
	sub	a, e
	ld	d, a
	ld	a, #<(_hiram_buffer)
	push	de
	inc	sp
	push	bc
	push	af
	inc	sp
	call	_hiramcpy
	add	sp, #4
;src/savememory.c:199: memcpy(&ram_buffer, (void *)&inc, (uint16_t)object_distance(inc, inc_end));
	ld	a, #<(_inc_end)
	ld	d, #>(_inc_end)
	ld	bc, #_inc
	sub	a, c
	ld	e, a
	ld	a, d
	sbc	a, b
	ld	d, a
	push	de
	push	bc
	ld	de, #_ram_buffer
	push	de
	call	_memcpy
	add	sp, #6
;src/savememory.c:202: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call ROM");
	ld	de, #___str_26
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:203: inc();
	call	_inc
;src/savememory.c:204: print_counter();
	call	_print_counter
;src/savememory.c:205: if (memTestCounter != 1) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	dec	a
	or	a, b
	jr	Z, 00110$
;src/savememory.c:206: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_27
	push	de
	ld	hl, #0x601
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:207: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_28
	push	de
	ld	hl, #0x801
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:208: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:209: return TEST_FAILED;
	ld	de, #0x0069
	ret
00110$:
;src/savememory.c:213: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x7028
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:214: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:217: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call RAM indirect");
	ld	de, #___str_29
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:218: inc_ram();
	call	_inc_ram
;src/savememory.c:219: print_counter();
	call	_print_counter
;src/savememory.c:220: if (memTestCounter != 2) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x02
	or	a, b
	jr	Z, 00112$
;src/savememory.c:221: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_27
	push	de
	ld	hl, #0x601
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:222: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_28
	push	de
	ld	hl, #0x801
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:223: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:224: return TEST_FAILED;
	ld	de, #0x0069
	ret
00112$:
;src/savememory.c:228: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x7818
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:229: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:232: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call RAM indirect");
	ld	de, #___str_29
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:233: inc_ram_var();
	ld	hl, #_inc_ram_var
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_inc_ram_var + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	call	___sdcc_call_hl
;src/savememory.c:234: print_counter();
	call	_print_counter
;src/savememory.c:235: if (memTestCounter != 3) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x03
	or	a, b
	jr	Z, 00114$
;src/savememory.c:236: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_27
	push	de
	ld	hl, #0x601
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:237: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_28
	push	de
	ld	hl, #0x801
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:238: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:239: return TEST_FAILED;
	ld	de, #0x0069
	ret
00114$:
;src/savememory.c:243: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x6828
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:244: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:247: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call HIRAM         ");
	ld	de, #___str_30
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:248: inc_hiram();
	call	_inc_hiram
;src/savememory.c:249: print_counter();
	call	_print_counter
;src/savememory.c:250: if (memTestCounter != 4) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x04
	or	a, b
	jr	Z, 00116$
;src/savememory.c:251: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_27
	push	de
	ld	hl, #0x601
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:252: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_28
	push	de
	ld	hl, #0x801
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:253: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:254: return TEST_FAILED;
	ld	de, #0x0069
	ret
00116$:
;src/savememory.c:258: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x6038
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:259: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:262: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call HIRAM indirect");
	ld	de, #___str_31
	push	de
	ld	hl, #0x401
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:263: inc_hiram_var();
	ld	hl, #_inc_hiram_var
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_inc_hiram_var + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	call	___sdcc_call_hl
;src/savememory.c:264: print_counter();
	call	_print_counter
;src/savememory.c:265: if (memTestCounter != 5) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x05
	or	a, b
	jr	Z, 00118$
;src/savememory.c:266: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_27
	push	de
	ld	hl, #0x601
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:267: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_28
	push	de
	ld	hl, #0x801
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:268: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:269: return TEST_FAILED;
	ld	de, #0x0069
	ret
00118$:
;src/savememory.c:273: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x7040
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:274: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:275: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST PASSED");
	ld	de, #___str_32
	push	de
	ld	hl, #0x801
	push	hl
	ld	e, #b_text_print_string_bkg
	ld	hl, #_text_print_string_bkg
	call	___sdcc_bcall_ehl
	add	sp, #4
;src/savememory.c:278: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x7848
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:279: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:282: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x7040
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:283: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:286: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x6060
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:287: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:290: ram_sprite_move(arrow_x, arrow_y);
	ld	hl, #0x5850
	push	hl
	call	_ram_sprite_move
	pop	hl
;src/savememory.c:291: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:292: ram_sprite_clear();
	call	_ram_sprite_clear
;src/savememory.c:293: return TEST_PASSED;
	ld	de, #0x0025
;src/savememory.c:294: }
	ret
___str_20:
	.ascii "[DBG] %s:%d @ %s() bank: %d"
	.db 0x00
___str_21:
	.ascii "src/savememory.c"
	.db 0x00
___str_22:
	.ascii "mem_test"
	.db 0x00
___str_23:
	.ascii "CHECKING MEMORY"
	.db 0x00
___str_24:
	.ascii "MAGIC OK"
	.db 0x00
___str_25:
	.ascii "BAD MAGIC"
	.db 0x00
___str_26:
	.ascii "Call ROM"
	.db 0x00
___str_27:
	.ascii "Bad counter..."
	.db 0x00
___str_28:
	.ascii "TEST FAILED"
	.db 0x00
___str_29:
	.ascii "Call RAM indirect"
	.db 0x00
___str_30:
	.ascii "Call HIRAM         "
	.db 0x00
___str_31:
	.ascii "Call HIRAM indirect"
	.db 0x00
___str_32:
	.ascii "TEST PASSED"
	.db 0x00
	.area _CODE_1
	.area _INITIALIZER
__xinit____EMU_PROFILER_INIT:
	.dw _EMU_profiler_message
__xinit__firstRunByte:
	.dw #0xa000
__xinit__results:
	.dw #0xa001
__xinit__endData:
	.dw #0xa01e
__xinit__memTestCounter:
	.dw #0x0000
__xinit__inc_ram_var:
	.dw _ram_buffer
__xinit__inc_hiram_var:
	.dw _hiram_buffer
	.area _CABS (ABS)
