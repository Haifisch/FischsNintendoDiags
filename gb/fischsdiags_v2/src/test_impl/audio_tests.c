#include <gb/gb.h>
#include <gb/cgb.h>
#include <stdint.h>
#include <stdio.h>
//
#include "../text.h"
#include "../test_common.h"

extern int ask_user_pass_or_fail();

int audio_test() {
	blank_display();
	text_print_string_bkg(0, 2, "Playing sound...");
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
		delay(1000);
	}

	return ask_user_pass_or_fail();
}