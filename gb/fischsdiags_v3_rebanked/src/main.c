#pragma bank 1
// std
#include <stdint.h>
#include <stdio.h>
#include <rand.h>
// gbdk
#include <gb/emu_debug.h>
#include <gbdk/platform.h>
#include <gbdk/far_ptr.h>
// locals
#include "gfx/menu_background.h"
#include "gfx/menu_arrow.h"
#include "test_common.h"
#include "savememory.h"
#include "text.h"

uint8_t MENU_ARROW_START_X = 68;
uint8_t MENU_ARROW_START_Y = 54;
uint8_t MENU_ARROW_X_FOR_INDEX[6] = { 68, 52, 54, 54, 56, 60 };
uint8_t MENU_INDEX_MAX = 5;
uint8_t CURRENT_INDEX = 0;
uint16_t rng_seed;

BANKREF_EXTERN(button_test)
extern void button_test() BANKED;
BANKREF_EXTERN(display_test)
extern void display_test() BANKED;
BANKREF_EXTERN(mem_test)
extern int mem_test() BANKED;
BANKREF_EXTERN(gblink_test)
extern int gblink_test() BANKED;
BANKREF_EXTERN(superuser_hold)
extern int superuser_hold() BANKED;
BANKREF_EXTERN(superuser_enter_hostmode)
extern void superuser_enter_hostmode() BANKED;
BANKREF_EXTERN(show_gblink_background)
extern void show_gblink_background() BANKED;

int audio_test()
{
    blank_display();
    text_load_font();
    text_print_string_bkg(0, 2, "Playing sound...");
    text_print_string_bkg(0, 6, "Hold any button");
    text_print_string_bkg(0, 7, "to exit.");
    NR52_REG = 0x80;
    NR50_REG = 0x77; 
    NR51_REG = 0xFF;
    while (1) {
        if ((joypad() & J_START) || (joypad() & J_SELECT) || (joypad() & J_A) || (joypad() & J_B) || (joypad() & J_UP) || (joypad() & J_DOWN) || (joypad() & J_LEFT) || (joypad() & J_RIGHT)) {
            break;
        }
        NR10_REG = 0x16;
        NR11_REG = 0x40;
        NR12_REG = 0x58;
        NR13_REG = 0x00;
        NR14_REG = 0xC3;
        delay(500);
    }
    blank_display();
    return ask_user_pass_or_fail();
}

void start_test(uint8_t testIdx)
{
    PRINT_FUNC_INFO;
    uint8_t testResult = 0;
    if (testIdx == 0) {
        // start buttons test
        blank_display();
        button_test();
    } else if (testIdx == 1) {
        // start display test
        display_test();
        testResult = ask_user_pass_or_fail();
    } else if (testIdx == 2) {
        // start memory test
        blank_display();
        text_load_font();
        testResult = mem_test();
    } else if (testIdx == 3) {
        // start audio test
        testResult = audio_test();
    } else if (testIdx == 4) {
        // start gb link test
        blank_display();
        text_load_font();
        testResult = gblink_test();
    } else if (testIdx == 5) {
        // reset
        reset();
    } 
    EMU_printf("test result => %i", testResult);
    save_test_result(testIdx + 1, testResult);
    menu_background_display();
    menu_arrow_display();
}

void double_rumble() {
    RUMBLE_ON;
    delay(200);
    RUMBLE_OFF;
    delay(200);
    RUMBLE_ON;
    delay(200);
    RUMBLE_OFF;
}

void main() 
{
    ENABLE_RAM;
    RUMBLE_ON;
    // vars
    uint8_t menu_y = MENU_ARROW_START_Y;
    rng_seed = DIV_REG;
    // meat n' potatoes
    EMU_printf("START (bank=%d)\n", (int)CURRENT_BANK);
    enable_interrupts();
    set_interrupts(VBL_IFLAG | SIO_IFLAG);
    if (superuser_hold() == 1) {
        RUMBLE_OFF;
        blank_display();
        text_load_font();
        superuser_enter_hostmode();
        return;
    }
    check_savemem();
    HIDE_BKG;
    menu_background_display();
    menu_arrow_display();
    SHOW_BKG;
    // final initialization of our rand seed
    rng_seed |= (uint16_t)DIV_REG << 8;
    initarand(rng_seed);
    RUMBLE_OFF;
    int rumbleDelay = 0;
    int didRumble = 0;
    // looper
    while (1) {
        if (didRumble == 1) {
            if (rumbleDelay > 2) {
                RUMBLE_OFF;
                didRumble = 0;
            } else {
                rumbleDelay += 1;
            }
        }
        if (joypad() & J_UP) {
            waitpadup();
            RUMBLE_ON;
            didRumble = 1;
            if (CURRENT_INDEX > 0) {
                CURRENT_INDEX--;
                menu_y -= 12;
            }
        } else if (joypad() & J_DOWN) {
            waitpadup();
            RUMBLE_ON;
            didRumble = 1;
            if (CURRENT_INDEX < MENU_INDEX_MAX) {
                CURRENT_INDEX++;
                menu_y += 12;
            }
        } else if (joypad() & J_A || joypad() & J_RIGHT) {
            EMU_printf("executing test idx => 0x%x\n", CURRENT_INDEX);
            waitpadup();
            double_rumble();
            start_test(CURRENT_INDEX);
            EMU_printf("returned from start_test (bank=%d)\n", (int)CURRENT_BANK);
        }
        move_sprite(0, MENU_ARROW_X_FOR_INDEX[CURRENT_INDEX], menu_y);
        wait_vbl_done();
        delay(100);
    }
}