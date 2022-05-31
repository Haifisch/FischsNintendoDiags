;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module savememory
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _print_counter
	.globl _init_savemem
	.globl _inc_hiram
	.globl _inc_ram
	.globl _inc_end
	.globl _inc
	.globl _text_print_string_bkg
	.globl _memset
	.globl _memcpy
	.globl _sprintf
	.globl _EMU_printf
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
	.area _CODE
;src/savememory.c:17: void inc() {
;	---------------------------------
; Function inc
; ---------------------------------
_inc::
;src/savememory.c:18: memTestCounter++;
	ld	hl, #_memTestCounter
	inc	(hl)
	ret	NZ
	inc	hl
	inc	(hl)
;src/savememory.c:19: }
	ret
;src/savememory.c:22: void inc_end() {} 
;	---------------------------------
; Function inc_end
; ---------------------------------
_inc_end::
	ret
;src/savememory.c:45: void save_test_result(int testType, int testResult) {
;	---------------------------------
; Function save_test_result
; ---------------------------------
_save_test_result::
;src/savememory.c:46: PRINT_FUNC_INFO;
	ld	de, #___str_2
	push	de
	ld	de, #0x002e
	push	de
	ld	de, #___str_1
	push	de
	ld	de, #___str_0
	push	de
	call	_EMU_printf
	add	sp, #8
;src/savememory.c:50: memcpy(results->BUTTON_TEST, "OK", 2);
	ld	hl, #_results
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
;src/savememory.c:48: if (testType == 1) {
	ldhl	sp,	#2
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	NZ, 00128$
;src/savememory.c:50: memcpy(results->BUTTON_TEST, "OK", 2);
	ld	hl, #0x0007
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:49: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
;src/savememory.c:50: memcpy(results->BUTTON_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00102$:
;src/savememory.c:52: memcpy(results->BUTTON_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00128$:
;src/savememory.c:54: } else if (testType == 2) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x02
	or	a, (hl)
	jr	NZ, 00125$
;src/savememory.c:56: memcpy(results->DISPLAY_TEST, "OK", 2);
	ld	hl, #0x000c
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:55: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00105$
;src/savememory.c:56: memcpy(results->DISPLAY_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00105$:
;src/savememory.c:58: memcpy(results->DISPLAY_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00125$:
;src/savememory.c:60: } else if (testType == 3) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x03
	or	a, (hl)
	jr	NZ, 00122$
;src/savememory.c:62: memcpy(results->MEMORY_TEST, "OK", 2);
	ld	hl, #0x0011
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:61: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00108$
;src/savememory.c:62: memcpy(results->MEMORY_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00108$:
;src/savememory.c:64: memcpy(results->MEMORY_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00122$:
;src/savememory.c:66: } else if (testType == 4) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x04
	or	a, (hl)
	jr	NZ, 00119$
;src/savememory.c:68: memcpy(results->AUDIO_TEST, "OK", 2);
	ld	hl, #0x0016
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:67: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00111$
;src/savememory.c:68: memcpy(results->AUDIO_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00111$:
;src/savememory.c:70: memcpy(results->AUDIO_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00119$:
;src/savememory.c:72: } else if (testType == 5) {
	ldhl	sp,	#2
	ld	a, (hl+)
	sub	a, #0x05
	or	a, (hl)
	ret	NZ
;src/savememory.c:74: memcpy(results->LINK_TEST, "OK", 2);
	ld	hl, #0x001b
	add	hl, bc
	ld	c, l
	ld	b, h
;src/savememory.c:73: if (testResult) {
	ldhl	sp,	#5
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00114$
;src/savememory.c:74: memcpy(results->LINK_TEST, "OK", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_3
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
	ret
00114$:
;src/savememory.c:76: memcpy(results->LINK_TEST, "NO", 2);
	ld	de, #0x0002
	push	de
	ld	de, #___str_4
	push	de
	push	bc
	call	_memcpy
	add	sp, #6
;src/savememory.c:80: }
	ret
___str_0:
	.ascii "[DBG] (%s:%d @ %s())"
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
;src/savememory.c:83: void init_savemem() {
;	---------------------------------
; Function init_savemem
; ---------------------------------
_init_savemem::
;src/savememory.c:84: PRINT_FUNC_INFO;
	ld	de, #___str_7
	push	de
	ld	de, #0x0054
	push	de
	ld	de, #___str_6
	push	de
	ld	de, #___str_5
	push	de
	call	_EMU_printf
	add	sp, #8
;src/savememory.c:85: for (UWORD uwI = 0xa000; uwI <= 0x7FFF; uwI+=2)
	ld	bc, #0xa000
00103$:
	ld	a, #0xff
	cp	a, c
	ld	a, #0x7f
	sbc	a, b
	jr	C, 00101$
;src/savememory.c:87: *(UWORD *)uwI = 0x0000;
	ld	e, c
	ld	d, b
	xor	a, a
	ld	(de), a
	inc	de
	ld	(de), a
;src/savememory.c:85: for (UWORD uwI = 0xa000; uwI <= 0x7FFF; uwI+=2)
	inc	bc
	inc	bc
	jr	00103$
00101$:
;src/savememory.c:90: memset(results, 0x0, sizeof(TEST_SAVED_RESULTS));
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
;src/savememory.c:91: memcpy(results->magic, "fsch", 4);
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
;src/savememory.c:92: memcpy(results->BUTTON_TEST_MAGIC, "btn", 3);
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
;src/savememory.c:93: memcpy(results->MEMORY_TEST_MAGIC, "mem", 3);
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
;src/savememory.c:94: memcpy(results->DISPLAY_TEST_MAGIC, "gfx", 3);
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
;src/savememory.c:95: memcpy(results->AUDIO_TEST_MAGIC, "sfx", 3);
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
;src/savememory.c:96: memcpy(results->LINK_TEST_MAGIC, "lnk", 3);
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
;src/savememory.c:97: memcpy(results->BUTTON_TEST, "NO", 2);
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
;src/savememory.c:98: memcpy(results->DISPLAY_TEST, "NO", 2);
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
;src/savememory.c:99: memcpy(results->MEMORY_TEST, "NO", 2);
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
;src/savememory.c:100: memcpy(results->AUDIO_TEST, "NO", 2);
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
;src/savememory.c:101: memcpy(results->LINK_TEST, "NO", 2);
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
;src/savememory.c:103: endData[0] = 0x4141;
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
;src/savememory.c:104: firstRunByte[0] = 1;
	ld	hl, #_firstRunByte
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_firstRunByte + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	ld	(hl), #0x01
;src/savememory.c:105: }
	ret
___str_5:
	.ascii "[DBG] (%s:%d @ %s())"
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
;src/savememory.c:108: void check_savemem() {
;	---------------------------------
; Function check_savemem
; ---------------------------------
_check_savemem::
;src/savememory.c:109: PRINT_FUNC_INFO;
	ld	de, #___str_17
	push	de
	ld	de, #0x006d
	push	de
	ld	de, #___str_16
	push	de
	ld	de, #___str_15
	push	de
	call	_EMU_printf
	add	sp, #8
;src/savememory.c:111: if (firstRunByte[0] != 0x1) {
	ld	hl, #_firstRunByte
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, (bc)
	dec	a
;src/savememory.c:112: init_savemem();
	jp	NZ,_init_savemem
;src/savememory.c:115: }
	ret
___str_15:
	.ascii "[DBG] (%s:%d @ %s())"
	.db 0x00
___str_16:
	.ascii "src/savememory.c"
	.db 0x00
___str_17:
	.ascii "check_savemem"
	.db 0x00
;src/savememory.c:117: void print_counter() {
;	---------------------------------
; Function print_counter
; ---------------------------------
_print_counter::
	add	sp, #-16
;src/savememory.c:118: EMU_printf("counter is %u\n", memTestCounter);
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_18
	push	de
	call	_EMU_printf
	add	sp, #4
;src/savememory.c:120: sprintf(buff, "Counter is %u", memTestCounter);
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
	call	_text_print_string_bkg
;src/savememory.c:122: }
	add	sp, #20
	ret
___str_18:
	.ascii "counter is %u"
	.db 0x0a
	.db 0x00
___str_19:
	.ascii "Counter is %u"
	.db 0x00
;src/savememory.c:124: int mem_test() {
;	---------------------------------
; Function mem_test
; ---------------------------------
_mem_test::
;src/savememory.c:125: PRINT_FUNC_INFO;
	ld	de, #___str_22
	push	de
	ld	de, #0x007d
	push	de
	ld	de, #___str_21
	push	de
	ld	de, #___str_20
	push	de
	call	_EMU_printf
	add	sp, #8
;src/savememory.c:126: if (memTestCounter != 0) {
	ld	hl, #_memTestCounter + 1
	ld	a, (hl-)
	or	a, (hl)
	jr	Z, 00102$
;src/savememory.c:127: memTestCounter = 0;
	xor	a, a
	ld	(hl+), a
	ld	(hl), a
00102$:
;src/savememory.c:131: ENABLE_RAM_MBC1;
	ld	hl, #0x0000
	ld	(hl), #0x0a
;src/savememory.c:133: text_print_string_bkg(TEXT_X_OFFSET, 2, "CHECKING MEMORY");
	ld	de, #___str_23
	push	de
	ld	hl, #0x201
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:134: if (results->magic[0] == 0x66 && results->magic[1] == 0x73 && results->magic[2] == 0x63 && results->magic[3] == 0x68) {
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
;src/savememory.c:135: text_print_string_bkg(TEXT_X_OFFSET, 3, "MAGIC OK");
	ld	de, #___str_24
	push	de
	ld	hl, #0x301
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
	jr	00105$
00104$:
;src/savememory.c:137: text_print_string_bkg(TEXT_X_OFFSET, 3, "BAD MAGIC");
	ld	de, #___str_25
	push	de
	ld	hl, #0x301
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:138: text_print_string_bkg(TEXT_X_OFFSET, 5, "TEST FAILED");
	ld	de, #___str_26
	push	de
	ld	hl, #0x501
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:139: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:141: return TEST_FAILED;
	ld	de, #0x0069
	ret
00105$:
;src/savememory.c:146: hiramcpy((uint8_t)&hiram_buffer, (void *)&inc, (uint8_t)object_distance(inc, inc_end));
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
;src/savememory.c:147: memcpy(&ram_buffer, (void *)&inc, (uint16_t)object_distance(inc, inc_end));
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
;src/savememory.c:150: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call ROM");
	ld	de, #___str_27
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:151: inc();
	call	_inc
;src/savememory.c:152: print_counter();
	call	_print_counter
;src/savememory.c:153: if (memTestCounter != 1) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	dec	a
	or	a, b
	jr	Z, 00110$
;src/savememory.c:154: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_28
	push	de
	ld	hl, #0x601
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:155: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_26
	push	de
	ld	hl, #0x801
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:156: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:157: return TEST_FAILED;
	ld	de, #0x0069
	ret
00110$:
;src/savememory.c:159: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:162: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call RAM indirect");
	ld	de, #___str_29
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:163: inc_ram();
	call	_inc_ram
;src/savememory.c:164: print_counter();
	call	_print_counter
;src/savememory.c:165: if (memTestCounter != 2) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x02
	or	a, b
	jr	Z, 00112$
;src/savememory.c:166: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_28
	push	de
	ld	hl, #0x601
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:167: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_26
	push	de
	ld	hl, #0x801
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:168: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:169: return TEST_FAILED;
	ld	de, #0x0069
	ret
00112$:
;src/savememory.c:171: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:174: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call RAM indirect");
	ld	de, #___str_29
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:175: inc_ram_var();
	ld	hl, #_inc_ram_var
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_inc_ram_var + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	call	___sdcc_call_hl
;src/savememory.c:176: print_counter();
	call	_print_counter
;src/savememory.c:177: if (memTestCounter != 3) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x03
	or	a, b
	jr	Z, 00114$
;src/savememory.c:178: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_28
	push	de
	ld	hl, #0x601
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:179: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_26
	push	de
	ld	hl, #0x801
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:180: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:181: return TEST_FAILED;
	ld	de, #0x0069
	ret
00114$:
;src/savememory.c:183: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:186: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call HIRAM         ");
	ld	de, #___str_30
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:187: inc_hiram();
	call	_inc_hiram
;src/savememory.c:188: print_counter();
	call	_print_counter
;src/savememory.c:189: if (memTestCounter != 4) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x04
	or	a, b
	jr	Z, 00116$
;src/savememory.c:190: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_28
	push	de
	ld	hl, #0x601
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:191: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_26
	push	de
	ld	hl, #0x801
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:192: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:193: return TEST_FAILED;
	ld	de, #0x0069
	ret
00116$:
;src/savememory.c:195: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:198: text_print_string_bkg(TEXT_X_OFFSET, 4, "Call HIRAM indirect");
	ld	de, #___str_31
	push	de
	ld	hl, #0x401
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:199: inc_hiram_var();
	ld	hl, #_inc_hiram_var
	ld	l, (hl)
;	spillPairReg hl
;	spillPairReg hl
	ld	a, (_inc_hiram_var + 1)
	ld	h, a
;	spillPairReg hl
;	spillPairReg hl
	call	___sdcc_call_hl
;src/savememory.c:200: print_counter();
	call	_print_counter
;src/savememory.c:201: if (memTestCounter != 5) {
	ld	hl, #_memTestCounter
	ld	a, (hl+)
	ld	c, a
	ld	b, (hl)
	ld	a, c
	sub	a, #0x05
	or	a, b
	jr	Z, 00118$
;src/savememory.c:202: text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
	ld	de, #___str_28
	push	de
	ld	hl, #0x601
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:203: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
	ld	de, #___str_26
	push	de
	ld	hl, #0x801
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:204: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:205: return TEST_FAILED;
	ld	de, #0x0069
	ret
00118$:
;src/savememory.c:207: delay(1000);
	ld	de, #0x03e8
	push	de
	call	_delay
	pop	hl
;src/savememory.c:209: text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST PASSED");
	ld	de, #___str_32
	push	de
	ld	hl, #0x801
	push	hl
	call	_text_print_string_bkg
	add	sp, #4
;src/savememory.c:210: delay(5000);
	ld	de, #0x1388
	push	de
	call	_delay
	pop	hl
;src/savememory.c:211: return TEST_PASSED;
	ld	de, #0x0025
;src/savememory.c:212: }
	ret
___str_20:
	.ascii "[DBG] (%s:%d @ %s())"
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
	.ascii "TEST FAILED"
	.db 0x00
___str_27:
	.ascii "Call ROM"
	.db 0x00
___str_28:
	.ascii "Bad counter..."
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
	.area _CODE
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
