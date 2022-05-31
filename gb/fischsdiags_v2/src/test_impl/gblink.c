#include <gb/gb.h>
#include <gb/emu_debug.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "../test_common.h"
#include "../text.h"
#include "../gfx/gblink_bg.h"


void show_gblink_background() {
	HIDE_BKG;
    set_bkg_palette(1, 1, &gblink_bg_palettes[4]);
    set_bkg_palette(0, 1, &gblink_bg_palettes[0]);
    /* CHR code transfer */
    set_bkg_data(0x0, gblink_bg_TILE_COUNT, gblink_bg_tiles);
    VBK_REG = 1;
    set_bkg_tiles(0, 0, 20, 18, gblink_bg_map_attributes);
    VBK_REG = 0;
    set_bkg_tiles(0, 0, 20, 18, gblink_bg_map);
    SHOW_BKG;
}


void receive_data_str() {
	uint8_t recv_y = 5;
	uint8_t recv_x = 1;
	for (int i = 0; i < 0x20; ++i)
    {
        receive_byte();
        /* Wait for IO completion... */
        while (_io_status == IO_RECEIVING);
        if (_io_status == IO_ERROR) {
            text_print_string_bkg(1, 4, "failed to comm...");
            break;
        }
        text_print_char_bkg(recv_x, recv_y, _io_in);
        if (_io_in == ' ') {
        	recv_y++;
        	recv_x = 1;
        } else {
        	recv_x++;
        }
    }
}

int gblink_test() {
	PRINT_FUNC_INFO;
	blank_display();
	show_gblink_background();

	// 73 74 72 74
	UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
	for (int i = 0; i < 4; ++i)
	{
		_io_out = start[i];
		send_byte();
		while (_io_status == IO_SENDING) 
		{
			// wait
		}
		if (_io_status == IO_ERROR)
		{
			text_print_string_bkg(1, 4, "failed to comm...");
			delay(2000);
			return TEST_FAILED;
		}
		delay(100);
	}

	text_print_string_bkg(1, 4, "initiated comm...");
	receive_data_str();
	delay(1000);
	return TEST_PASSED;
} 