#pragma bank 1

#include <gb/gb.h>
#include <gb/emu_debug.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "gfx/ram_sprite.h"
#include "savememory.h"
#include "text.h"
#include "test_common.h"

UBYTE *firstRunByte = (UBYTE *)0xa000;
TEST_SAVED_RESULTS *results = (TEST_SAVED_RESULTS *)0xa001;
UWORD *endData = (UBYTE *)(0xa001 + sizeof(TEST_SAVED_RESULTS));

uint16_t memTestCounter = 0;

// inc() must be a relocatable function, be careful!
void inc() {
    memTestCounter++;
}

// dummy function, needed to calculate inc() size, must be after it
void inc_end() {} 

// calculate the distance between objects 
#define object_distance(a, b) ((void *)&(b) - (void *)&(a))

// variables at an absolute addresses which are defined by passing parameters to compiler
unsigned char __at _inc_ram   ram_buffer[];
unsigned char __at _inc_hiram hiram_buffer[];

// those are function pointer variables, we can initialize them right here
typedef void (*inc_t)(void);
inc_t inc_ram_var   = (inc_t)ram_buffer;
inc_t inc_hiram_var = (inc_t)hiram_buffer;

// those are defined by passing parameters to the linker, they must be located at the same 
// addresses where ram_buffer and hiram_buffer are located
extern void inc_ram();
extern void inc_hiram();

/* 
    uhhh haifisch sidenote; memcpy probably isn't needed but sort of landed on using it after testing. 
*/
// save a test result
void save_test_result(int testType, int testResult) {
    PRINT_FUNC_INFO;
    //ENABLE_RAM_MBC1; // Enable RAM
    if (testType == 1) {
        if (testResult) {
            memcpy(results->BUTTON_TEST, "OK", 2);
        } else {
            memcpy(results->BUTTON_TEST, "NO", 2);
        }
    } else if (testType == 2) {
        if (testResult) {
            memcpy(results->DISPLAY_TEST, "OK", 2);
        } else {
            memcpy(results->DISPLAY_TEST, "NO", 2);
        }
    } else if (testType == 3) {
        if (testResult) {
            memcpy(results->MEMORY_TEST, "OK", 2);
        } else {
            memcpy(results->MEMORY_TEST, "NO", 2);
        }
    } else if (testType == 4) {
        if (testResult) {
            memcpy(results->AUDIO_TEST, "OK", 2);
        } else {
            memcpy(results->AUDIO_TEST, "NO", 2);
        }
    } else if (testType == 5) {
        if (testResult) {
            memcpy(results->LINK_TEST, "OK", 2);
        } else {
            memcpy(results->LINK_TEST, "NO", 2);
        }
    }
    //DISABLE_RAM_MBC1;
}

// init save memory with defaulting data
void init_savemem() {
    PRINT_FUNC_INFO;
    for (UWORD uwI = 0xa000; uwI <= 0x7FFF; uwI+=2)
    {
        //*(UWORD *)uwI = 0x0000;
        memcpy((UWORD *)uwI, 0x0000, sizeof(UWORD));
    }
    memset(results, 0x0, sizeof(TEST_SAVED_RESULTS));
    memcpy(results->magic, "fsch", 4);
    memcpy(results->BUTTON_TEST_MAGIC, "btn", 3);
    memcpy(results->MEMORY_TEST_MAGIC, "mem", 3);
    memcpy(results->DISPLAY_TEST_MAGIC, "gfx", 3);
    memcpy(results->AUDIO_TEST_MAGIC, "sfx", 3);
    memcpy(results->LINK_TEST_MAGIC, "lnk", 3);
    memcpy(results->BUTTON_TEST, "NO", 2);
    memcpy(results->DISPLAY_TEST, "NO", 2);
    memcpy(results->MEMORY_TEST, "NO", 2);
    memcpy(results->AUDIO_TEST, "NO", 2);
    memcpy(results->LINK_TEST, "NO", 2);

    endData[0] = 0x4141;
    firstRunByte[0] = 1;
}

// called by main everytime
void check_savemem() {
    PRINT_FUNC_INFO;
    //ENABLE_RAM_MBC1;
    if (firstRunByte[0] != 0x35) {
        init_savemem();
    }
    //DISABLE_RAM_MBC1;
}

void print_counter() {
    EMU_printf("counter is %u\n", memTestCounter);
    char buff[16];
    sprintf(buff, "Counter is %u", memTestCounter);
    text_print_string_bkg(2, 5, buff);
}


void ram_sprite_move(uint8_t arrow_x, uint8_t arrow_y) {
    uint8_t arrow_x_offset = arrow_x;
    uint8_t arrow_tile = 0;
    for (uint8_t q = 0; q < 4; ++q)
    {
        for (uint8_t t = 0; t < 8; ++t)
        {
            move_sprite(arrow_tile, arrow_x, arrow_y);
            arrow_x += 8;
            arrow_tile++;
        }
        arrow_y += 8;
        arrow_x = arrow_x_offset;
    }
}


void ram_sprite_display() 
{
    SPRITES_8x8;
    palette_color_t ram_sprite_palettes[4] = {
        RGB8(0, 0, 0), RGB8(0, 0, 190), RGB8(255, 0, 0), RGB8(255, 255, 255)
    };
    set_sprite_palette(0, 1, ram_sprite_palettes);
    set_sprite_data(0, RAM_SPRITE_TILE_COUNT, RAM_SPRITE);

    uint8_t arrow_tile_idx = 0;
    
    for (uint8_t i = 0; i < 32; ++i)
    {
        set_sprite_tile(i, arrow_tile_idx);
        arrow_tile_idx += 1;
    }
}

void ram_sprite_clear() 
{
    // cleanup 
    for (uint8_t q = 0; q < 32; ++q)
    {
        move_sprite(q, 0, 0);
    }
    HIDE_SPRITES;
}

BANKREF(mem_test)
int mem_test() BANKED {
    PRINT_FUNC_INFO;
    // init ram card sprite
    uint8_t arrow_x = 72;
    uint8_t arrow_y = 96;
    ram_sprite_display();
    ram_sprite_move(arrow_x, arrow_y);
    SHOW_SPRITES;
    // counter for the mem test
    if (memTestCounter != 0) {
        memTestCounter = 0;
    }
    // check save memory magic, usually this would only fail on carts with no save memory or some other wild issue with the gb(c) is happening.
    // save memory for this rom gets initialized by check_savemem if check_savemem 
    int TEXT_X_OFFSET = 1;
    uint8_t mid_screen = (DEVICE_SCREEN_WIDTH / 2);
    text_print_string_bkg(TEXT_X_OFFSET, 2, "CHECKING MEMORY");
    if (results->magic[0] == 0x66 && results->magic[1] == 0x73 && results->magic[2] == 0x63 && results->magic[3] == 0x68) {
        text_print_string_bkg(TEXT_X_OFFSET, 3, "MAGIC OK");
    } else {
        text_print_string_bkg(TEXT_X_OFFSET, 3, "BAD MAGIC");
    }

    // copy inc() function to it's new destinations: hiram_buffer and ram_buffer
    hiramcpy((uint8_t)&hiram_buffer, (void *)&inc, (uint8_t)object_distance(inc, inc_end));
    memcpy(&ram_buffer, (void *)&inc, (uint16_t)object_distance(inc, inc_end));

    // Call function in ROM
    text_print_string_bkg(TEXT_X_OFFSET, 4, "Call ROM");
    inc();
    print_counter();
    if (memTestCounter != 1) {
        text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
        text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
        delay(5000);
        return TEST_FAILED;
    }
    arrow_x -= 32;
    arrow_y += 16;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);

    // Call function in RAM using link-time address
    text_print_string_bkg(TEXT_X_OFFSET, 4, "Call RAM indirect");
    inc_ram();
    print_counter();
    if (memTestCounter != 2) {
        text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
        text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
        delay(5000);
        return TEST_FAILED;
    }
    arrow_x -= 16;
    arrow_y += 8;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);

    // Call function in RAM using pointer-to-function variable
    text_print_string_bkg(TEXT_X_OFFSET, 4, "Call RAM indirect");
    inc_ram_var();
    print_counter();
    if (memTestCounter != 3) {
        text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
        text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
        delay(5000);
        return TEST_FAILED;
    }
    arrow_x += 16;
    arrow_y -= 16;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);

    // Call function in HIRAM using link-time address
    text_print_string_bkg(TEXT_X_OFFSET, 4, "Call HIRAM         ");
    inc_hiram();
    print_counter();
    if (memTestCounter != 4) {
        text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
        text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
        delay(5000);
        return TEST_FAILED;
    }
    arrow_x += 16;
    arrow_y -= 8;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);

    // Call function in HIRAM using pointer-to-function variable
    text_print_string_bkg(TEXT_X_OFFSET, 4, "Call HIRAM indirect");
    inc_hiram_var();
    print_counter();
    if (memTestCounter != 5) {
        text_print_string_bkg(TEXT_X_OFFSET, 6, "Bad counter...");
        text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST FAILED");
        delay(5000);
        return TEST_FAILED;
    }
    arrow_x += 8;
    arrow_y += 16;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);
    text_print_string_bkg(TEXT_X_OFFSET, 8, "TEST PASSED");
    arrow_x += 8;
    arrow_y += 8;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);
    arrow_x -= 8;
    arrow_y -= 8;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);
    arrow_x += 32;
    arrow_y -= 16;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);
    arrow_x -= 16;
    arrow_y -= 8;
    ram_sprite_move(arrow_x, arrow_y);
    delay(1000);
    ram_sprite_clear();
    return TEST_PASSED;
}