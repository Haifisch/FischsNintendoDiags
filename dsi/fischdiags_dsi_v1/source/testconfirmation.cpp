#include <nds.h>
#include <gl2d.h>
#include <stdio.h>
#include "testconfirmation.h"
#include "passfailbg.h"
#include "passfailbuttons.h"

enum TestButtonState
{
	GoodIdle = 0,
	GoodPressed = 1,
	BadIdle = 2,
	BadPressed = 3
};

typedef struct
{
	int x;
	int y;

	u16* sprite_gfx_mem;
	u8*  frame_gfx;

	int state;
	int anim_frame;
} TestButtonSprite;


void animateTestButtonSprite(TestButtonSprite *sprite, TestButtonState buttonState)
{
	//int frame = sprite->anim_frame + sprite->state;
	u8* offset = sprite->frame_gfx + buttonState * 64*32;
	dmaCopy(offset, sprite->sprite_gfx_mem, 64*32);
	//sprite->gfx_frame = sprite->anim_frame + sprite->state * 2;
}

void initTestButtonSprite(TestButtonSprite *sprite, u8* gfx) {
	//sprite->sprite_gfx_mem = oamAllocateGfx(&oamSub, SpriteSize_64x32, SpriteColorFormat_256Color);
	//sprite->frame_gfx = (u8*)gfx;
	sprite->sprite_gfx_mem = oamAllocateGfx(&oamSub, SpriteSize_64x32, SpriteColorFormat_256Color);
	sprite->frame_gfx = (u8*)gfx;
}

int show_test_confirmation_screen(void) {
	lcdMainOnTop();
	//videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_5_2D);
    //vramSetBankA(VRAM_A_MAIN_BG);
  	vramSetBankC(VRAM_C_SUB_BG);
  	vramSetBankD(VRAM_D_SUB_SPRITE);
    vramSetBankE(VRAM_E_TEX_PALETTE);
    vramSetBankG(VRAM_G_SPRITE_EXT_PALETTE);

    TestButtonSprite goodSprite = { 32, 108 };
    TestButtonSprite badSprite = { 160, 108 };

    oamInit(&oamSub, SpriteMapping_1D_128, false);

    initTestButtonSprite(&goodSprite, (u8*)passfailbuttonsTiles);
    initTestButtonSprite(&badSprite, (u8*)passfailbuttonsTiles);
    badSprite.state = 1;
    badSprite.anim_frame = 1;
	// sprite palettes
	dmaCopy(passfailbuttonsPal, SPRITE_PALETTE_SUB, 512);

	// setup bg
	//int bg3 = bgInit(3, BgType_Bmp16, BgSize_B8_256x256, 0, 0);
	int bg4 = bgInitSub(3, BgType_Bmp16, BgSize_B8_256x256, 0, 0); // wtf how is this working
	//dmaCopy(passfailbgBitmap, bgGetGfxPtr(bg3), 256*192);
	dmaCopy(passfailbgBitmap, bgGetGfxPtr(bg4), 256*192);
	//dmaCopy(passfailbgPal, BG_PALETTE, 256*2);
	dmaCopy(passfailbgPal, BG_PALETTE_SUB, 256*2);
	touchPosition touch;
	TestButtonState goodButtonState = GoodIdle;
	TestButtonState badButtonState = BadIdle;
	int frame = 0;
	bool returnRefresh = false;
	int returnValue = 1;
	while (1) {
		frame += 1;
		animateTestButtonSprite(&goodSprite, goodButtonState);
		animateTestButtonSprite(&badSprite, badButtonState);
		oamSet(&oamSub, 0, goodSprite.x, goodSprite.y, 0, 0, SpriteSize_64x32, SpriteColorFormat_256Color, goodSprite.sprite_gfx_mem, -1, false, false, false, false, false);
		oamSet(&oamSub, 1, badSprite.x, badSprite.y, 0, 0, SpriteSize_64x32, SpriteColorFormat_256Color, badSprite.sprite_gfx_mem, -1, false, false, false, false, false);
		swiWaitForVBlank();
		scanKeys();

		if (returnRefresh) {
			swiDelay(100);
		} else {
			if (keysHeld() & KEY_TOUCH && returnRefresh == false) {
				touchRead(&touch);
				if ((touch.px < (goodSprite.x + 64) && touch.px > goodSprite.x) && (touch.py < (goodSprite.y + 32) && touch.py > goodSprite.y)) {
					goodButtonState = GoodPressed;
					returnRefresh = true;
					frame = 0; // wait 60ish frames before we leave so we visually can present the touchdown event
					returnValue = 0;
				}
				if ((touch.px < (badSprite.x + 64) && touch.px > badSprite.x) && (touch.py < (badSprite.y + 32) && touch.py > badSprite.y)) {
					badButtonState = BadPressed;
					returnRefresh = true;
					frame = 0; // wait 60ish frames before we leave so we visually can present the touchdown event
					returnValue = -1;
				}
			}
		}

		if (keysDown() & KEY_START) {
			returnValue = -1;
			break;
		}
		oamUpdate(&oamSub);
		if (frame > 80 && returnRefresh) {
			swiDelay(300);
			break;
		} else if (frame > 60 && returnRefresh) {
			goodButtonState = GoodIdle;
			badButtonState = BadIdle;
		}
	}
	return returnValue;
}