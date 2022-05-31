#include <nds.h>
#include <gl2d.h>
#include <stdio.h>
#include <maxmod9.h>
#include "audiotests.h"
#include "soundbank.h"
#include "soundbank_bin.h"
#include "playingaudio.h"

int audio_test_begin(void) {
	videoSetMode(MODE_3_2D);
	vramSetBankA(VRAM_A_MAIN_BG);
	vramSetBankE(VRAM_E_TEX_PALETTE);
	int bg3 = bgInit(3, BgType_Bmp8, BgSize_B8_256x256, 0, 0);
	dmaCopy(playingaudioBitmap, bgGetGfxPtr(bg3), 256*256);
	dmaCopy(playingaudioPal, BG_PALETTE, 256*2);

	mmInitDefaultMem((mm_addr)soundbank_bin);
	// load the module
	mmLoad( MOD_FLATOUTLIES );
	// Start playing module
	mmStart( MOD_FLATOUTLIES, MM_PLAY_LOOP );
	do {
		swiWaitForVBlank();
		scanKeys();
		if(keysDown() & KEY_START) break;
	} while(1);
	mmStop();
	return 0;
}