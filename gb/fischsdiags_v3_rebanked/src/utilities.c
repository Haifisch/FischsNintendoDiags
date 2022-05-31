#pragma bank 2

#include <gb/gb.h>
#include <gb/emu_debug.h>
#include <gbdk/far_ptr.h>

#include "test_common.h"
#include "gfx/passfail_bg.h"

void blank_display() BANKED
{
    PRINT_FUNC_INFO;
    HIDE_SPRITES;
    HIDE_BKG;
    uint8_t blank_display_tiles[16];
    unsigned char blank_display_map_and_attr[360];
    int i = 0;
    for (i = 0; i < 16; ++i)
    {
        blank_display_tiles[i] = 0x0;
    }

    for (i = 0; i < 360; ++i)
    {
        blank_display_map_and_attr[i] = 0x0;
    }
    set_default_palette();
    set_bkg_data(0, 1, blank_display_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, blank_display_map_and_attr);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, blank_display_map_and_attr);
    SHOW_BKG;
}

int ask_user_pass_or_fail() BANKED
{
    PRINT_FUNC_INFO;
    HIDE_SPRITES;
    HIDE_BKG;
    set_bkg_palette(0, 1, passfail_bg_palettes);
    set_bkg_palette(1, 1, passfail_bg_palettes);
    set_bkg_palette(2, 1, passfail_bg_palettes);
    set_bkg_palette(3, 1, passfail_bg_palettes);
    set_bkg_palette(4, 1, passfail_bg_palettes);
    set_bkg_palette(5, 1, passfail_bg_palettes);
    set_bkg_palette(6, 1, passfail_bg_palettes);
    set_bkg_palette(7, 1, passfail_bg_palettes);
    set_bkg_data(0, passfail_bg_TILE_COUNT, passfail_bg_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, passfail_bg_map_attributes);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, passfail_bg_map);
    SHOW_BKG;
    int result; 
    while (1) {
        if (joypad() & J_A) {
            result = TEST_PASSED;
            waitpadup();
            break;
        } else if (joypad() & J_B) {
            result = TEST_FAILED;
            waitpadup();
            break;
        }
        
    }
    return result;
}