#pragma bank 1
#include <gb/gb.h>
#include <gb/emu_debug.h>
#include <gbdk/console.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include "../test_common.h"
#include "../text.h"
#include "../gfx/gblink_bg.h"

const UBYTE test_data_str[0x30] = {
    0x46, 0x49, 0x53, 0x43, 0x48, 0x53, 
    0x2D, 0x44, 0x49, 0x41, 0x47, 0x53, 
    0x2D, 0x56, 0x33, 0x2D, 0x47, 0x42, 
    0x2D, 0x4C, 0x49, 0x4E, 0x4B, 0x2D, 
    0x43, 0x4F, 0x4D, 0x4D, 0x55, 0x4E, 
    0x49, 0x43, 0x41, 0x54, 0x49, 0x4F, 
    0x4E, 0x2D, 0x54, 0x45, 0x53, 0x54, 
    0x2D, 0x50, 0x41, 0x53, 0x53, 0x20
}; 

void show_gblink_background() 
{
	HIDE_BKG;
    set_bkg_palette(1, 1, &gblink_bg_palettes[4]);
    set_bkg_palette(0, 1, &gblink_bg_palettes[0]);
    /* CHR code transfer */
    set_bkg_data(0, gblink_bg_TILE_COUNT, gblink_bg_tiles);
    VBK_REG = 1;
    set_tile_map(0, 0, 20, 18, gblink_bg_map_attributes);
    VBK_REG = 0;
    set_tile_map(0, 0, 20, 18, gblink_bg_map);
    SHOW_BKG;
}

void receive_data_str()
{
	uint8_t recv_y = 5;
	uint8_t recv_x = 0;
	for (int i = 0; i < 0x30; ++i)
    {
        receive_byte();
        /* Wait for IO completion... */
        while (_io_status == IO_RECEIVING);
        if (_io_status == IO_ERROR) {
            text_print_string_bkg(1, 4, "failed to comm...");
            break;
        }
        text_print_char_bkg(recv_x, recv_y, _io_in);
        if (i % 16 == 0) { // _io_in == ' '
        	recv_y++;
        	recv_x = 0;
        } else {
        	recv_x++;
        }
    }
}

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
    for (int i = 0; i < 0x30; ++i)
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

BANKREF(superuser_hold)
int superuser_hold() BANKED
{
    PRINT_FUNC_INFO;
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

BANKREF(superuser_enter_hostmode)
void superuser_enter_hostmode() BANKED
{
    PRINT_FUNC_INFO;
    // Loop forever
    while(1) {
    	cls();
        printf("\n(SUPERUSER)\n\nwaiting for init\n");
        wait_for_start();
        printf("received init!\nsending test str\n");
        delay(100);
        send_data_str();
        delay(5000);
        wait_vbl_done();
    }
}

BANKREF(gblink_test)
int gblink_test() BANKED 
{
	PRINT_FUNC_INFO;
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
			//printf("\n\n\nfailed to comm...\n");
			delay(2000);
			return TEST_FAILED;
		}
		delay(100);
	}
	//printf("\n\n\ninitiated comm...\n");
	text_print_string_bkg(1, 4, "initiated comm...");
	receive_data_str();
	delay(1000);
	return TEST_PASSED;
} 