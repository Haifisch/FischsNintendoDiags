#pragma bank 2
#include <gb/gb.h>
#include <gb/cgb.h>
#include <gb/emu_debug.h>
#include <gbdk/far_ptr.h>
#include <stdint.h>
#include <stdio.h>
//
#include "../gfx/colorbars_leftright.h"
#include "../gfx/colorbars_rightleft.h"
#include "../gfx/bar_c.h"
#include "../gfx/checkerboard_32x32.h"
#include "../gfx/scroll_pattern.h"
#include "../gfx/alert_pattern.h"
#include "../test_common.h"

uint16_t bar_p[] =
{
  bar_cCGBPal0c0,bar_cCGBPal0c1,bar_cCGBPal0c2,bar_cCGBPal0c3,
  bar_cCGBPal1c0,bar_cCGBPal1c1,bar_cCGBPal1c2,bar_cCGBPal1c3,
  bar_cCGBPal2c0,bar_cCGBPal2c1,bar_cCGBPal2c2,bar_cCGBPal2c3,
  bar_cCGBPal3c0,bar_cCGBPal3c1,bar_cCGBPal3c2,bar_cCGBPal3c3,
  bar_cCGBPal4c0,bar_cCGBPal4c1,bar_cCGBPal4c2,bar_cCGBPal4c3,
  bar_cCGBPal5c0,bar_cCGBPal5c1,bar_cCGBPal5c2,bar_cCGBPal5c3,
  bar_cCGBPal6c0,bar_cCGBPal6c1,bar_cCGBPal6c2,bar_cCGBPal6c3,
  bar_cCGBPal7c0,bar_cCGBPal7c1,bar_cCGBPal7c2,bar_cCGBPal7c3
};

unsigned char bar_a[] =
{
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1,
  7,7,7,6,6,6,5,5,5,4,4,4,3,3,3,2,2,2,1,1
};

unsigned char bar_b[] =
{
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7,
  1,1,1,2,2,2,3,3,3,4,4,4,5,5,5,6,6,6,7,7
};

void display_colorbar_left_to_right()  
{
    PRINT_FUNC_INFO;
    HIDE_BKG;
    set_bkg_palette(7, 1, &bar_p[0]);
    set_bkg_palette(6, 1, &bar_p[4]);
    set_bkg_palette(5, 1, &bar_p[8]);
    set_bkg_palette(4, 1, &bar_p[12]);
    set_bkg_palette(3, 1, &bar_p[16]);
    set_bkg_palette(2, 1, &bar_p[20]);
    set_bkg_palette(1, 1, &bar_p[24]);
    set_bkg_palette(0, 1, &bar_p[28]);
    set_bkg_data(0x0, 32, bar_c);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, bar_a);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, ColorbarsLeftToRight);
    SHOW_BKG;
}

void display_colorbar_right_to_left()
{
    PRINT_FUNC_INFO;
    HIDE_BKG;
    set_bkg_data(0x0, 32, bar_c);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, bar_b);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, ColorbarsRightToLeft);
    SHOW_BKG;
}

void display_checkerboard()  
{
    PRINT_FUNC_INFO;
    HIDE_BKG;
    set_bkg_palette(7, 1, checkerboard_32x32_palettes);
    set_bkg_palette(6, 1, checkerboard_32x32_palettes);
    set_bkg_palette(5, 1, checkerboard_32x32_palettes);
    set_bkg_palette(4, 1, checkerboard_32x32_palettes);
    set_bkg_palette(3, 1, checkerboard_32x32_palettes);
    set_bkg_palette(2, 1, checkerboard_32x32_palettes);
    set_bkg_palette(1, 1, checkerboard_32x32_palettes);
    set_bkg_palette(0, 1, checkerboard_32x32_palettes);
    set_bkg_data(0x0, checkerboard_32x32_TILE_COUNT, checkerboard_32x32_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, checkerboard_32x32_map_attributes);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, checkerboard_32x32_map);
    SHOW_BKG;
}


void display_alert_image_pattern() {
    PRINT_FUNC_INFO;
    HIDE_BKG;
    set_bkg_palette(7, 1, alert_pattern_palettes);
    set_bkg_palette(6, 1, alert_pattern_palettes);
    set_bkg_palette(5, 1, alert_pattern_palettes);
    set_bkg_palette(4, 1, alert_pattern_palettes);
    set_bkg_palette(3, 1, alert_pattern_palettes);
    set_bkg_palette(2, 1, alert_pattern_palettes);
    set_bkg_palette(1, 1, alert_pattern_palettes);
    set_bkg_palette(0, 1, alert_pattern_palettes);
    set_bkg_data(0x0, alert_pattern_TILE_COUNT, alert_pattern_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, alert_pattern_map_attributes);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, alert_pattern_map);
    SHOW_BKG;
}

void display_scroll_pattern() {
    PRINT_FUNC_INFO;
    HIDE_BKG;
    set_bkg_palette(7, 1, scroll_pattern_palettes);
    set_bkg_palette(6, 1, scroll_pattern_palettes);
    set_bkg_palette(5, 1, scroll_pattern_palettes);
    set_bkg_palette(4, 1, scroll_pattern_palettes);
    set_bkg_palette(3, 1, scroll_pattern_palettes);
    set_bkg_palette(2, 1, scroll_pattern_palettes);
    set_bkg_palette(1, 1, scroll_pattern_palettes);
    set_bkg_palette(0, 1, scroll_pattern_palettes);
    set_bkg_data(0x0, scroll_pattern_TILE_COUNT, scroll_pattern_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, scroll_pattern_map_attributes);
    set_bkg_tiles(0, 18, 20, 17, scroll_pattern_map_attributes);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, scroll_pattern_map);
    set_bkg_tiles(0, 18, 20, 17, scroll_pattern_map);
    SHOW_BKG;
}

void do_scroll_pattern_animation() {
    PRINT_FUNC_INFO;
    uint8_t scrollTick = 0;
    while (scrollTick < 120) {
        scroll_bkg(0, 1);
        scrollTick++;
        delay(100);
    }
}

void display_test() BANKED
{
    PRINT_FUNC_INFO;
    HIDE_SPRITES;
    blank_display();
    PRINT_BANK_INFO;
    //delay(2000);
    // colorbars left to right
    display_colorbar_left_to_right();
    PRINT_BANK_INFO;
    delay(2000);
    // colorbars right to left
    display_colorbar_right_to_left();
    delay(2000);
    // checkerboard
    display_checkerboard();
    delay(2000);
    // alert image pattern
    display_alert_image_pattern();
    delay(2000);
    // scroll pattern
    display_scroll_pattern();
    delay(100);
    do_scroll_pattern_animation();
    move_bkg(0, 0);
}