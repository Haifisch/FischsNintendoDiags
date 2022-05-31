#include <gb/gb.h>
#include <gb/emu_debug.h>
#include <gbdk/far_ptr.h>

#include "test_common.h"
#include "gfx/menu_background.h"
#include "gfx/blank_display.h"
#include "gfx/passfail_bg.h"
#include "text.h"

void blank_display() {
    PRINT_FUNC_INFO;
    HIDE_SPRITES;
    HIDE_BKG;
    set_bkg_palette(0, 1,  blank_display_palettes);//FAR_OFS(pal_ptr));
    set_bkg_palette(1, 1,  blank_display_palettes);
    set_bkg_palette(2, 1,  blank_display_palettes);
    set_bkg_palette(3, 1,  blank_display_palettes);
    set_bkg_palette(4, 1,  blank_display_palettes);
    set_bkg_palette(5, 1,  blank_display_palettes);
    set_bkg_palette(6, 1,  blank_display_palettes);
    set_bkg_palette(7, 1,  blank_display_palettes);
    set_bkg_data(0, blank_display_TILE_COUNT, blank_display_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, blank_display_map_attributes);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, blank_display_map);
    SHOW_BKG;
    text_load_font();
    set_bkg_palette(0, 1, menu_background_palettes);
    wait_vbl_done();
}

int ask_user_pass_or_fail() {
    blank_display();
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
    blank_display();
    return result;
}