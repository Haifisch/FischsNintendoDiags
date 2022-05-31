#include <gb/gb.h>
#include <gb/emu_debug.h>

#include "../gfx/button_tiles.h"
#include "../gfx/button_arrow.h"
#include "../text.h"
#include "../test_common.h"

struct PrimaryButtons {
    uint8_t a:1;
    uint8_t b:1;
    uint8_t start:1;
    uint8_t select:1;
    uint8_t up:1;
    uint8_t down:1;
    uint8_t left:1;
    uint8_t right:1;
};

struct PrimaryButtons primaryButtonBits;
uint8_t arrow_center_x = 72;

void next_arrow(uint8_t startIndex) { // UP = 0, RIGHT = 16, DOWN = 32, LEFT = 48
    SPRITES_8x8;
    set_sprite_data(0, BUTTON_ARROW_TILE_COUNT, BUTTON_ARROW);
    uint8_t arrow_tile_idx = startIndex;
    uint8_t arrow_x = arrow_center_x;
    uint8_t arrow_y = 64;
    for (uint8_t i = 0; i < 16; ++i)
    {
        set_sprite_tile(i, arrow_tile_idx);
        arrow_tile_idx += 1;
    }    
    uint8_t arrow_tile = 0;
    for (uint8_t q = 0; q < 4; ++q)
    {
        for (uint8_t t = 0; t < 4; ++t)
        {
            move_sprite(arrow_tile, arrow_x, arrow_y);
            arrow_x += 8;
            arrow_tile++;
        }
        arrow_y += 8;
        arrow_x = arrow_center_x;
    }
    SHOW_SPRITES;
}

void next_button(uint8_t startIndex) {
    SPRITES_8x8;
    set_sprite_data(64, BUTTONS_TILE_COUNT, BUTTONS);
    uint8_t arrow_tile_idx = 64 + startIndex;
    uint8_t arrow_x = arrow_center_x;
    uint8_t arrow_y = 64;
    for (uint8_t i = 16; i < 32; ++i)
    {
        set_sprite_tile(i, arrow_tile_idx);
        arrow_tile_idx += 1;
    }    
    uint8_t arrow_tile = 16;
    for (uint8_t q = 0; q < 4; ++q)
    {
        for (uint8_t t = 0; t < 4; ++t)
        {
            move_sprite(arrow_tile, arrow_x, arrow_y);
            arrow_x += 8;
            arrow_tile++;
        }
        arrow_y += 8;
        arrow_x = arrow_center_x;
    }
    SHOW_SPRITES;
}

void cleanup_arrow_sprites() {
    for (uint8_t q = 0; q < 32; ++q)
    {
        move_sprite(q, 0, 0);
    }
    HIDE_SPRITES;
}

void button_test_blank() {
    blank_display();
    wait_vbl_done();
    text_load_font();
    text_print_string_bkg(3, 2, "Press the button");
    text_print_string_bkg(6, 3, "indicated");
}

void buttons_sequence() {
    uint8_t mid_screen = (DEVICE_SCREEN_WIDTH / 2);
    // A
    button_test_blank();
    next_button(0);
    waitpad(J_A);
    delay(100);
    // B
    next_button(16);
    waitpad(J_B);
    delay(100);
    // S1
    button_test_blank();
    text_print_string_bkg(mid_screen-2, 12, "SELECT");
    next_button(32);
    waitpad(J_SELECT);
    delay(100);
    // S2
    button_test_blank();
    text_print_string_bkg(mid_screen-2, 12, "START");
    next_button(48);
    waitpad(J_START);
    delay(100);
}

int button_test() {
    PRINT_FUNC_INFO;
    uint8_t mid_screen = (DEVICE_SCREEN_WIDTH / 2);
    uint8_t currentSequence = 0;
    uint8_t arrow_index = 0;
    button_test_blank();
    next_arrow(arrow_index);
    wait_vbl_done();
    while (1) {
        if (primaryButtonBits.up == 0) {
            arrow_index = 0;
        } else if (primaryButtonBits.up && primaryButtonBits.right == 0) {
            arrow_index = 16;
        } else if (primaryButtonBits.up && primaryButtonBits.right && primaryButtonBits.down == 0) {
            arrow_index = 32;
        } else if (primaryButtonBits.up && primaryButtonBits.right && primaryButtonBits.down && primaryButtonBits.left == 0) {
            arrow_index = 48;
        }
        if (primaryButtonBits.up && primaryButtonBits.left && primaryButtonBits.down && primaryButtonBits.right) {
            break;
        }
        next_arrow(arrow_index);
        wait_vbl_done();
        if (primaryButtonBits.up == 0) {
            primaryButtonBits.up = ((joypad() & J_UP) ? 1:0);
        }
        if (primaryButtonBits.down == 0) {
            primaryButtonBits.down = ((joypad() & J_DOWN) ? 1:0);
        }
        if (primaryButtonBits.left == 0) {
            primaryButtonBits.left = ((joypad() & J_LEFT) ? 1:0);
        }
        if (primaryButtonBits.right == 0) {
            primaryButtonBits.right = ((joypad() & J_RIGHT) ? 1:0);
        }
        if (primaryButtonBits.select == 0) {
            primaryButtonBits.select = ((joypad() & J_SELECT) ? 1:0);
        }
        if (primaryButtonBits.start == 0) {
            primaryButtonBits.start = ((joypad() & J_START) ? 1:0);
        }
        if (primaryButtonBits.a == 0) {
            primaryButtonBits.a = ((joypad() & J_A) ? 1:0);
        }
        if (primaryButtonBits.b == 0) {
            primaryButtonBits.b = ((joypad() & J_B) ? 1:0);
        }
        waitpadup();
    }
    // button sequence
    cleanup_arrow_sprites();
    buttons_sequence();
    // finally cleanup and exit
    cleanup_arrow_sprites();
    blank_display();
    wait_vbl_done();
    delay(1000);
    return TEST_PASSED;
}