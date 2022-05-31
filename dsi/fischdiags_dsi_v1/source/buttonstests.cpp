#include <nds.h>
#include <gl2d.h>
#include <stdio.h>
#include "buttonstests.h"
#include "buttontestsbg.h"
#include "directionbuttonpad.h"
#include "touchpadx.h"
#include "touchpadbg.h"
#include "buttontest_sprites.h"
#include "buttontest_bg.h"

glImage  ButtonTestBgTiles[(256/8) * (256/8)];

glImage  TouchpadBgTiles[(256/8) * (256/8)];
glImage  XTestTile[1];

typedef struct 
{
	int x;
	int y;
	int mapId;
	u16* sprite_gfx_mem;
	u8*  frame_gfx;
	int state;
	int anim_frame;
}ButtonSprite;

typedef struct {
	int DPAD;
	int XYAB;
	bool RB;
	bool LB;
}ButtonStatus;


typedef struct 
{
	int x;
	int y;
	u16* sprite_gfx_mem;
	u8*  frame_gfx;
	int state;
	int anim_frame;
}TouchSprite;

typedef struct {
	int x;
	int y;
}TouchTest;


void animateButtonSprite(ButtonSprite *sprite)
{
	int frame = sprite->mapId + sprite->state;
	u8* offset = sprite->frame_gfx + frame * 32*32;
	dmaCopy(offset, sprite->sprite_gfx_mem, 32*32);
	//dmaCopyHalfWords(3, offset, sprite->sprite_gfx_mem, 32*32);
}

void initButtonSprite(ButtonSprite *sprite, u8* gfx)
{
	sprite->sprite_gfx_mem = oamAllocateGfx(&oamMain, SpriteSize_32x32, SpriteColorFormat_256Color);
	sprite->frame_gfx = (u8*)gfx;
}

int buttons_test_begin(void) {
	lcdMainOnBottom();
	videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_BG_0x06000000);
	vramSetBankB(VRAM_B_MAIN_BG_0x06020000);
	vramSetBankC(VRAM_C_MAIN_BG_0x06060000);
	vramSetBankD(VRAM_D_LCD);
	vramSetBankE(VRAM_E_MAIN_SPRITE);
	vramSetBankF(VRAM_F_MAIN_SPRITE_0x06410000);
	vramSetBankG(VRAM_G_MAIN_SPRITE_0x06414000);
	vramSetBankH(VRAM_H_SUB_BG);
	vramSetBankI(VRAM_I_SUB_BG_0x06208000);

	consoleInit(NULL, 0, BgType_Text4bpp, BgSize_T_256x256, 2, 0, false, true);

	int mainbg = bgInit(2, BgType_Bmp8, BgSize_B8_256x256, 0, 0);
	dmaCopy(buttontest_bgBitmap, bgGetGfxPtr(mainbg), 256*192);
    dmaCopy(buttontest_bgPal, BG_PALETTE, buttontest_bgPalLen);

    ButtonSprite allButtons[10];
    allButtons[0] = {64, 34, 0}; // left bumper
    allButtons[1] = {160, 34, 2}; // right bumper
    allButtons[2] = {160, 93, 4}; // y button
    allButtons[3] = {183, 70, 6}; // x button
    allButtons[4] = {183, 116, 8}; // b button
    allButtons[5] = {206, 93, 10}; // a button
    allButtons[6] = {41, 116, 12}; // down button
    allButtons[7] = {41, 70, 14}; // up button
    allButtons[8] = {18, 93, 16}; // left button
    allButtons[9] = {64, 93, 18}; // right button
	ButtonStatus btnStatus = { 0x0000 };

	oamInit(&oamMain, SpriteMapping_1D_32, false);
	for (int i = 0; i < 10; ++i)
	{
		initButtonSprite(&allButtons[i], (u8*)buttontest_spritesTiles);
		
	}
	dmaCopy(buttontest_spritesPal, SPRITE_PALETTE, buttontest_spritesPalLen);

	while(1) {
		scanKeys();
		if ((keysDown() & KEY_UP) && !(btnStatus.DPAD & 0x0001)) {
			allButtons[7].state = 1;
			btnStatus.DPAD ^= 0x0001;
		}
		if ((keysDown() & KEY_RIGHT) && !(btnStatus.DPAD & 0x0010)) {
			allButtons[9].state = 1;
			btnStatus.DPAD ^= 0x0010;
		}
		if ((keysDown() & KEY_DOWN) && !(btnStatus.DPAD & 0x0100)) {
			allButtons[6].state = 1;
			btnStatus.DPAD ^= 0x0100;
		}
		if ((keysDown() & KEY_LEFT) && !(btnStatus.DPAD & 0x1000)) {
			allButtons[8].state = 1;
			btnStatus.DPAD ^= 0x1000;
		}
		if ((keysDown() & KEY_X) && !(btnStatus.XYAB & 0x0001)) {
			allButtons[3].state = 1;
			btnStatus.XYAB ^= 0x0001;
		}
		if ((keysDown() & KEY_Y) && !(btnStatus.XYAB & 0x0010)) {
			allButtons[2].state = 1;
			btnStatus.XYAB ^= 0x0010;
		}
		if ((keysDown() & KEY_A) && !(btnStatus.XYAB & 0x0100)) {
			allButtons[5].state = 1;
			btnStatus.XYAB ^= 0x0100;
		}
		if ((keysDown() & KEY_B) && !(btnStatus.XYAB & 0x1000)) {
			allButtons[4].state = 1;
			btnStatus.XYAB ^= 0x1000;
		}
		if ((keysDown() & KEY_R) && !btnStatus.RB) {
			allButtons[1].state = 1;
			btnStatus.RB = !btnStatus.RB;
		}
		if ((keysDown() & KEY_L) && !btnStatus.LB) {
			allButtons[0].state = 1;
			btnStatus.LB = !btnStatus.LB;
		}
		//draw_button_state(&btnStatus);
		for (int i = 0; i < 10; ++i)
		{
			//allButtons[i].state = 0;
			animateButtonSprite(&allButtons[i]);
			oamSet(&oamMain, 			//main graphics engine context
				i,           			//oam index (0 to 127)  
				allButtons[i].x, allButtons[i].y, 			
				0,						//priority, lower renders last (on top)
				0,	//palette index if multiple palettes or the alpha value if bmp sprite	
				SpriteSize_32x32,
				SpriteColorFormat_256Color,
				allButtons[i].sprite_gfx_mem,				//pointer to the loaded graphics
				-1,	//sprite rotation data  
				false,					//double the size when rotating?
				false,			//hide the sprite?
				false, false, //vflip, hflip
				false	//apply mosaic
				);
		}
		
		iprintf("\x1b[2J");
		iprintf("DPAD: %x\n",btnStatus.DPAD);
		iprintf("XYAB: %x\n",btnStatus.XYAB);
		iprintf("RB %s\tLB %s\n", btnStatus.RB ? "OK":"NT", btnStatus.LB ? "OK":"NT");
		swiWaitForVBlank();
		oamUpdate(&oamMain);
		if (keysDown()&KEY_START) break;
	}
	return 0;
}


void animateTouchPadSprite(TouchSprite *sprite)
{
	int frame = sprite->anim_frame + sprite->state * 3;
	u8* offset = sprite->frame_gfx + frame * 32*32;
	dmaCopy(offset, sprite->sprite_gfx_mem, 32*32);
	//dmaCopyHalfWords(3, offset, sprite->sprite_gfx_mem, 32*32);
}

void initTouchPadSprite(TouchSprite *sprite, u8* gfx)
{
	sprite->sprite_gfx_mem = oamAllocateGfx(&oamSub, SpriteSize_32x32, SpriteColorFormat_256Color);
	sprite->frame_gfx = (u8*)gfx;
}

int touchpad_test_begin(void) 
{
	lcdMainOnTop();
	vramDefault();
	TouchSprite touchPadSprite = {0,0};
	int cubescol = 7;
	int cubesrow = 3;
	int start_x = 16;
	int start_y = 16;
	int numberOfCubes = (cubesrow * cubescol);
	TouchTest touchLocations[numberOfCubes];
	memset(touchLocations, 0x0, sizeof(touchLocations));
	for (int i = 0; i < numberOfCubes; ++i)
	{
		touchLocations[i] = {start_x, start_y};
		if (start_x >= 208) {
			start_x = 16;
			start_y += 64;
		} else {
			start_x += 32;
		}
	}

	videoSetMode(MODE_0_2D);
	videoSetModeSub(MODE_5_2D);
	touchPosition touch;
	vramSetBankA(VRAM_A_MAIN_BG);
	consoleInit(NULL, 0, BgType_Text4bpp, BgSize_T_256x256, 22, 3, true, true);

	// setup background
	vramSetBankC(VRAM_C_SUB_BG);
	int bg4 = bgInitSub(3, BgType_Bmp16, BgSize_B8_256x256, 0, 0);
	dmaCopy(touchpadbgBitmap, bgGetGfxPtr(bg4), touchpadbgBitmapLen);
	dmaCopy(touchpadbgPal, BG_PALETTE_SUB, 256*2);

	// setup touch pad X sprite
	vramSetBankD(VRAM_D_SUB_SPRITE);
	//oamInit(&oamMain, SpriteMapping_1D_32, false);
	oamInit(&oamSub, SpriteMapping_1D_32, false);
	initTouchPadSprite(&touchPadSprite, (u8*)touchpadxTiles);
	dmaCopy(touchpadxPal, SPRITE_PALETTE_SUB, touchpadxPalLen);
	
	int correctTouch = 0;
	int badTouch = 0;
	int testIdx = 0;
	int touchLastX = 0;
	int touchLastY = 0;
	bool nextTest = false;
	while(1) {
		consoleClear();
		scanKeys();
		iprintf("GOOD: %i/%i\tBAD: %i/%i\n\nTARGET: #%i @ ~%i, ~%i\nRAW: %i, %i\n", correctTouch, numberOfCubes, badTouch, numberOfCubes, testIdx, (touchLocations[testIdx].x + 16), (touchLocations[testIdx].y + 16), touchLastX, touchLastY);
		if (keysDown() & KEY_TOUCH) {
			touchRead(&touch);
			touchLastX = touch.px;
			touchLastY = touch.py;
			if ((touch.py > touchLocations[testIdx].y && touch.py < (touchLocations[testIdx].y + 32) ) && (touch.px > touchLocations[testIdx].x && touch.px < (touchLocations[testIdx].x + 32) ))
			{
				nextTest = true;
				if (correctTouch < numberOfCubes) {
					correctTouch += 1;
				}
				touchPadSprite.anim_frame = 2;
			} else {
				if (badTouch < numberOfCubes) {
					badTouch += 1;
				}
				touchPadSprite.anim_frame = 1;
			}
			
		} else if (keysUp() & KEY_TOUCH) {
			if (nextTest) {
				testIdx = rand() % (numberOfCubes - 1);
				if (testIdx >= numberOfCubes) {
					testIdx = 0;
				}
			}
			touchPadSprite.anim_frame = 0;
		}
		animateTouchPadSprite(&touchPadSprite);
		/*		
		oamSet(&oamMain, 			//main graphics engine context
			0,           			//oam index (0 to 127)  
			touchLocations[testIdx].x, touchLocations[testIdx].y, 			
			0,						//priority, lower renders last (on top)
			0,	//palette index if multiple palettes or the alpha value if bmp sprite	
			SpriteSize_16x16,
			SpriteColorFormat_256Color,
			gfx,				//pointer to the loaded graphics
			-1,	//sprite rotation data  
			false,					//double the size when rotating?
			false,			//hide the sprite?
			false, false, //vflip, hflip
			false	//apply mosaic
			);
			*/
		oamSet(&oamSub, 			//main graphics engine context
			0,           			//oam index (0 to 127)  
			touchLocations[testIdx].x, touchLocations[testIdx].y, 			
			0,						//priority, lower renders last (on top)
			0,	//palette index if multiple palettes or the alpha value if bmp sprite	
			SpriteSize_32x32,
			SpriteColorFormat_256Color,
			touchPadSprite.sprite_gfx_mem,				//pointer to the loaded graphics
			-1,	//sprite rotation data  
			false,					//double the size when rotating?
			false,			//hide the sprite?
			false, false, //vflip, hflip
			false	//apply mosaic
			);              
	
		swiWaitForVBlank();
		//send the updates to the hardware
		//oamUpdate(&oamMain);
		oamUpdate(&oamSub);
		if(keysDown() & KEY_START) break;
	}

	return 0;
}