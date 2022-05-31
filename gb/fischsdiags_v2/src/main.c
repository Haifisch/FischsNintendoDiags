// gb/gbdk
#include <gb/gb.h>
#include <gb/emu_debug.h>
#include <gbdk/console.h>
#include <gbdk/far_ptr.h>

// std
#include <stdint.h>
#include <stdio.h>
#include <rand.h>

// local
#include "savememory.h"
#include "test_common.h"
#include "gfx/menu_background.h"
#include "gfx/menu_arrow.h"
#include "text.h"

//
// i dont wanna make a .h for these, very lazy
extern void blank_display();
extern int ask_user_pass_or_fail();

extern void show_gblink_background();
// tests
extern void display_test();
extern int button_test();
extern int audio_test();
extern int gblink_test();

int toggleRumble()
{
    return (*(uint8_t*)0x4000 ^ (1 << (3 - 1)));
}

//
//
// MAIN FUNCTIONS
//
//
uint8_t MENU_ARROW_START_X = 68;
uint8_t MENU_ARROW_START_Y = 54;
uint8_t MENU_ARROW_X_FOR_INDEX[6] = { 68, 52, 54, 54, 56, 60 };
uint8_t MENU_INDEX_MAX = 5;
uint8_t CURRENT_INDEX = 0;
uint16_t rng_seed;

const UBYTE test_data_str[27] = {0x46, 0x49, 0x53, 0x43, 0x48, 0x53, 0x44, 0x49, 0x41, 0x47, 0x53, 0x43, 0x4F, 0x4D, 0x4D, 0x54, 0x45, 0x53, 0x54, 0x44, 0x41, 0x54, 0x41, 0x4C, 0x49, 0x4E, 0x4B}; 

void wait_for_start() 
{
    UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
    // 73 74 72 74
    for (int i = 0; i < 4; ++i)
    {
        receive_byte();
        /* Wait for IO completion... */
        while (_io_status == IO_RECEIVING);
        if (_io_status == IO_ERROR) {
            printf("i/o error!\n");
            break;
        }
        if (_io_in == start[i]) {
            printf("%c", _io_in);
        }
    }
    printf("\n"); 
}

void send_data_str() 
{
    for (int i = 0; i < 0x20; ++i)
    {
        _io_out = test_data_str[i];
        send_byte();
        while(_io_status == IO_SENDING);
        if (_io_status == IO_ERROR) {
            printf("i/o error!\n");
            break;
        }
        if (test_data_str[i] == 0x20) {
            printf("\n");
        } else {
            printf("%c", test_data_str[i]);
        }
        delay(100);
    }
    printf("\n"); 
}

// display bg
void display_menu_bg()  {
    PRINT_FUNC_INFO;
    HIDE_BKG;
    set_bkg_palette(0, 1, menu_background_palettes);
    set_bkg_palette(1, 1, menu_background_palettes);
    set_bkg_palette(2, 1, menu_background_palettes);
    set_bkg_palette(3, 1, menu_background_palettes);
    set_bkg_palette(4, 1, menu_background_palettes);
    set_bkg_palette(5, 1, menu_background_palettes);
    set_bkg_palette(6, 1, menu_background_palettes);
    set_bkg_palette(7, 1, menu_background_palettes);
    PRINT_BANK_INFO;
    set_bkg_data(0, menu_background_TILE_COUNT, menu_background_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, menu_background_map_attributes);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, menu_background_map);
    SHOW_BKG;
}

// display menu arrow
void display_menu_arrow() {
    PRINT_FUNC_INFO;
    SPRITES_8x8;
    set_sprite_palette(0, 1, menu_background_palettes);
    set_sprite_data(0, 8, menu_arrow_tiles);
    set_sprite_tile(0, 0);
    SHOW_SPRITES;
}

void move_menu_arrow(uint8_t menu_x, uint8_t menu_y) 
{
    move_sprite(0, menu_x, menu_y);
}

void display_menu()  
{
    PRINT_FUNC_INFO;
    //PRINT_BANK_INFO;
    //blank_display();
    //wait_vbl_done();
    display_menu_bg();
    display_menu_arrow();
    text_load_font();
}

void start_test(uint8_t testIdx) 
{
    PRINT_FUNC_INFO;
    uint8_t testResult = 0;
    if (testIdx == 0) {
        // start buttons test
        testResult = button_test();
    } else if (testIdx == 1) {
        // start display test
        display_test();
        testResult = ask_user_pass_or_fail();
    } else if (testIdx == 2) {
        // start memory test
        blank_display();
        testResult = mem_test();
    } else if (testIdx == 3) {
        // start audio test
        testResult = audio_test();
    } else if (testIdx == 4) {
        // start gb link test
        testResult = gblink_test();
    } else if (testIdx == 5) {
        // reset
        reset();
    } 
    EMU_printf("test result => %x", testResult);
    save_test_result(testIdx + 1, testResult);
    display_menu();
}

int superuser_hold()
{
    PRINT_FUNC_INFO;
    //blank_display();
    //wait_vbl_done();
    int isSuper = 0;
    int delayInc = 2;
    while (delayInc > 0) {
        //cls();
        //printf("\n\nhold keys to enter\nsuperuser mode...\n");
        //printf("%d\n", delayInc);
        if (joypad() & J_START && joypad() & J_SELECT) {
            isSuper = 1;
            printf("you are super.\n");
            waitpadup();
            break;
        } else  {
            isSuper = 0;
        }
        delayInc--;
        delay(1000);
    }
    return isSuper;
}

void superuser_enter_hostmode() 
{
    PRINT_FUNC_INFO;
    blank_display();
    show_gblink_background();
    text_load_font();
    wait_vbl_done();
    // Loop forever
    while(1) {
        cls();
        printf("\n\nwaiting for init\n");
        wait_for_start();
        printf("received init!\nsending big string\n");
        delay(100);
        send_data_str();
        delay(5000);
        wait_vbl_done();
    }
}

// main, main, mane.
void main(void)
{   
    ENABLE_RAM;
    enable_interrupts();
    PRINT_FUNC_INFO;
    rng_seed = DIV_REG;
    uint8_t menu_y = MENU_ARROW_START_Y;
    set_interrupts(VBL_IFLAG | SIO_IFLAG);
    if (superuser_hold() == 1) {
        superuser_enter_hostmode();
    }
    check_savemem();
    wait_vbl_done();
    delay(500);
    display_menu();
    rng_seed |= (uint16_t)DIV_REG << 8;
    initarand(rng_seed);
    // looper
    while(1) {
        if (joypad() & J_UP) {
            waitpadup();
            if (CURRENT_INDEX > 0) {
                CURRENT_INDEX--;
                menu_y -= 12;
            }
            toggleRumble();
        } else if (joypad() & J_DOWN) {
            waitpadup();
            if (CURRENT_INDEX < MENU_INDEX_MAX) {
                CURRENT_INDEX++;
                menu_y += 12;
            }
            
        } else if (joypad() & J_A || joypad() & J_LEFT) {
            EMU_printf("executing test idx => 0x%x\n", CURRENT_INDEX);
            waitpadup();
            start_test(CURRENT_INDEX);
        } else {

        }
        //move_menu_arrow(MENU_ARROW_X_FOR_INDEX[CURRENT_INDEX], menu_y);
        move_sprite(0, MENU_ARROW_X_FOR_INDEX[CURRENT_INDEX], menu_y);
        wait_vbl_done();
        //delay(100);
    }
}
