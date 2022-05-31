#include <nds.h>
#include <gl2d.h>
#include <stdio.h>
#include <time.h>
#include "godmode9i/nandio.h"
#include "godmode9i/tonccpy.h"
#include "test_sprite.h"
#include "gfxtest.h"
#include "colorbars.h"
#include "checkerboard_8x8.h"
#include "checkerboard_16x16.h"
#include "checkerboard_32x32.h"
#include "flickerpattern.h"
#include "flickerpatterntwo.h"
#include "testcard.h"
#include "testcardtwo.h"
#include "bwgradient.h"
#include "qrencode.h"
#include "testconfirmation.h"


#define ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
#define PIXEL_OFFSET(x, y)  (((x) * SCREEN_HEIGHT) + (SCREEN_HEIGHT - (y) - 1))
const char *QR_CODE_TEST_STR = "FISCHSDIAGSDSi";

extern bool to_hex(char* dest, size_t dest_len, const uint8_t* values, size_t val_len);

//verticies for the cube
v16 CubeVectors[] = {
	floattov16(-0.5), floattov16(-0.5), floattov16(0.5), 
	floattov16(0.5),  floattov16(-0.5), floattov16(0.5),
	floattov16(0.5),  floattov16(-0.5), floattov16(-0.5),
	floattov16(-0.5), floattov16(-0.5), floattov16(-0.5),
	floattov16(-0.5), floattov16(0.5),  floattov16(0.5), 
	floattov16(0.5),  floattov16(0.5),	floattov16(0.5),
	floattov16(0.5),  floattov16(0.5),  floattov16(-0.5),
	floattov16(-0.5), floattov16(0.5),  floattov16(-0.5)
};

//polys
u8 CubeFaces[] = {
	3,2,1,0,
	0,1,5,4,
	1,2,6,5,
	2,3,7,6,
	3,0,4,7,
	5,6,7,4
};

//texture coordinates
u32 uv[] =
{

	TEXTURE_PACK(inttot16(128), 0),
	TEXTURE_PACK(inttot16(128),inttot16(128)),
	TEXTURE_PACK(0, inttot16(128)),
	TEXTURE_PACK(0,0)
};

u32 normals[] =
{
	NORMAL_PACK(0,floattov10(-.97),0),
	NORMAL_PACK(0,0,floattov10(.97)),
	NORMAL_PACK(floattov10(.97),0,0),
	NORMAL_PACK(0,0,floattov10(-.97)),
	NORMAL_PACK(floattov10(-.97),0,0),
	NORMAL_PACK(0,floattov10(.97),0)

};

typedef struct
{
	int x;
	int y;
	u16 *gfx;
} GFXQRTile;


//draw a cube face at the specified color
void drawQuad(int poly)
{	
	u32 f1 = CubeFaces[poly * 4] ;
	u32 f2 = CubeFaces[poly * 4 + 1] ;
	u32 f3 = CubeFaces[poly * 4 + 2] ;
	u32 f4 = CubeFaces[poly * 4 + 3] ;
	//glLight(0, RGB15(255, 0, 0), 0, 0, 200);
	//glNormal(normals[poly]);

	GFX_TEX_COORD = (uv[0]);
	glVertex3v16(CubeVectors[f1*3], CubeVectors[f1*3 + 1], CubeVectors[f1*3 +  2] );

	GFX_TEX_COORD = (uv[1]);
	glVertex3v16(CubeVectors[f2*3], CubeVectors[f2*3 + 1], CubeVectors[f2*3 + 2] );

	GFX_TEX_COORD = (uv[2]);
	glVertex3v16(CubeVectors[f3*3], CubeVectors[f3*3 + 1], CubeVectors[f3*3 + 2] );

	GFX_TEX_COORD = (uv[3]);
	glVertex3v16(CubeVectors[f4*3], CubeVectors[f4*3 + 1], CubeVectors[f4*3 + 2] );
}

void renderScene(int paletteIDS[6]) {
	static short angle = 0;
	glMatrixMode(GL_MODELVIEW);
	glPushMatrix();
	gluLookAt(0.0, 0.0, 1.25, //camera possition 
		0.0, 0.0, 0.0, //look at
		0.0, 1.0, 0.0); //up
	
	glTranslatef(0, 0, -1);
	glRotatef32i(degreesToAngle(angle), inttof32(1), inttof32(1), inttof32(1)); 
	//draw the obj
	glColor3b(255,255,255);
	glScalef(0.4f,0.4f,0.4f);
	int polyid = 1;
	for(int j = 0; j < 2; j++)
	{
		for(int i = 0; i < 6; i++)
		{
			glAssignColorTable(0,paletteIDS[i]);
			glTexParameter(0, 0); //disable GL_TEXTURE_COLOR0_TRANSPARENT
			glPolyFmt(POLY_ALPHA(31) | POLY_CULL_BACK | POLY_MODULATION | POLY_ID(polyid) ) ;
			glBegin(GL_QUAD);
			drawQuad(i);
			glEnd();				
			polyid++;
		}

		glScalef(1.0f/0.4f,1.0f/0.4f,1.0f/0.4f);
	}
	glPopMatrix(1);
	angle++;
}

int gfx_3d_test_begin(void)
{	
	//consoleDebugInit(DebugDevice_NOCASH);

	int textureIDS[8];
	int paletteIDS[6];
	videoSetMode(MODE_0_3D);
	videoSetModeSub(MODE_5_2D);
	//consoleDemoInit();
	//consoleInit(NULL, 0, BgType_Text4bpp, BgSize_T_256x256, 22, 3, false, true);

	// initialize gl
	glInit();

	glEnable(GL_TEXTURE_2D);
	glEnable(GL_ANTIALIAS);
	glEnable(GL_BLEND);

	// setup the rear plane
	glClearColor(0,0,0,31); // BG must be opaque for AA to work
	glClearPolyID(63); // BG must have a unique polygon ID for AA to work
	glClearDepth(0x7FFF);

	//this should work the same as the normal gl call
	glViewport(0,0,255,191);

	//You may comment/uncomment what you like, as the integration of nglVideo into libnds works
	// by examining the state of the banks, and deciding where to put textures/texpalettes based on that.
	//There are some exceptions to get certain stuff working though...
	// At least one main bank (A-D) must be allocated to textures to load/use them obviously, as well as 
	//  sub banks (E-G) for texture palettes
	// Compressed textures require bank B allocated, as well as bank A or C (or both) to be loadable/usable
	// 4 color palettes (not 4-bit) require either bank E, or bank F/G as slot0/1
	vramSetBankA(VRAM_A_TEXTURE_SLOT0);
	vramSetBankB(VRAM_B_TEXTURE_SLOT1);
	vramSetBankC(VRAM_C_TEXTURE_SLOT2);
	vramSetBankD(VRAM_D_TEXTURE_SLOT3);
	vramSetBankE(VRAM_E_LCD);
	vramSetBankF(VRAM_F_LCD);
	vramSetBankG(VRAM_G_LCD);
	vramSetBankH(VRAM_H_LCD);
	vramSetBankI(VRAM_I_LCD);
	//consoleDemoInit();
	glGenTextures(ARRAY_SIZE(textureIDS), textureIDS);
	
	glBindTexture(0, textureIDS[0]);
	glTexImage2D(0, 0, GL_RGB, TEXTURE_SIZE_128 , TEXTURE_SIZE_128, 0, TEXGEN_TEXCOORD, (u8*)test_spriteBitmap);

	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(70, 256.0 / 192.0, 0.1, 40);

	bool top = true;
	while (true) 
	{
		// wait for capture unit to be ready
		while(REG_DISPCAPCNT & DCAP_ENABLE);
		//-------------------------------------------------------
		//	 Switch render targets
		//-------------------------------------------------------
		//top = !top;
		top = !top;
		if(top)
		{
			lcdMainOnTop();
			vramSetBankD(VRAM_D_LCD);
			vramSetBankC(VRAM_C_TEXTURE);
			REG_DISPCAPCNT = DCAP_BANK(3) | DCAP_ENABLE | DCAP_SIZE(3);
		}
		else
		{
			lcdMainOnBottom();
			vramSetBankC(VRAM_C_LCD);
			vramSetBankD(VRAM_D_TEXTURE);
			REG_DISPCAPCNT = DCAP_BANK(2) | DCAP_ENABLE | DCAP_SIZE(3);
		}
		renderScene(paletteIDS);
		glFlush(GL_TRANS_MANUALSORT | GL_WBUFFERING);
		swiWaitForVBlank();
		scanKeys();
		if (keysDown() & KEY_START) {
			break;
		}
	}
 	
	return show_test_confirmation_screen();
}

void display_qrcode(QRcode *qr, u8 *dst) {	
	int scale = SCREEN_HEIGHT / qr->width;
	for(int y = 0; y < qr->width; y++) {
		for(int i = 0; i < scale; i++) // Fill line with white
			toncset(dst + (y * scale + i) * SCREEN_WIDTH - 4, 0xF0, qr->width * scale + 8);

		for(int x = 0; x < qr->width; x++) {
			if(qr->data[y * qr->width + x] & 1) { // If black, draw pixel
				for(int i = 0; i < scale; i++)
					toncset(dst + (y * scale + i) * SCREEN_WIDTH + (x * scale), 0xF3, scale);
			}
		}
	}

	// Pad above and below with white
	for(int i = 0; i < 4; i++) {
		toncset(dst - (i + 1) * SCREEN_WIDTH - 4, 0xF0, qr->width * scale + 8);
		toncset(dst + ((qr->width * scale + i) * SCREEN_WIDTH) - 4, 0xF0, qr->width * scale + 8);
	}

}

int gfx_qrcode_test_begin(void) {
	// set the mode for 2 text layers and two extended background layers
	videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_5_2D);
    vramSetBankA(VRAM_A_MAIN_BG);
  	vramSetBankC(VRAM_C_SUB_BG);
    setBackdropColor(RGB15(0,0,0));
	setBackdropColorSub(RGB15(0,0,0));

	// hold our qr data
	char qrData[64];
	// get the cid
	u8 consoleID[8];
	u8 consoleIDfixed[8];
	getConsoleID(consoleID);
	for (int i = 0; i < 8; i++) {
		consoleIDfixed[i] = consoleID[7-i];
	}
	char consoleIDStr[32];
	to_hex(consoleIDStr, sizeof(consoleIDStr), consoleIDfixed, sizeof(consoleIDfixed));

	sprintf(qrData, "%s_%s", QR_CODE_TEST_STR, consoleIDStr);

	QRcode *qr = QRcode_encodeString(qrData, MQRSPEC_VERSION_MAX, QR_ECLEVEL_L, QR_MODE_8, true);

	int bgMain = bgInit(3, BgType_Bmp8, BgSize_B8_256x256, 0,0);
	int bgSub = bgInitSub(3, BgType_Bmp8, BgSize_B8_256x256, 0,0);
	dmaFillHalfWords(RGB15(0, 0, 0), bgGetGfxPtr(bgMain), 256*256);
  	dmaFillHalfWords(RGB15(0, 0, 0), bgGetGfxPtr(bgSub), 256*256);

	// Draw QR
	int scale = SCREEN_HEIGHT / qr->width;
	u8 *dst = (u8 *)bgGetGfxPtr(bgSub) + (SCREEN_HEIGHT - qr->width * scale) / 2 * SCREEN_WIDTH + (SCREEN_WIDTH - qr->width * scale) / 2;
	display_qrcode(qr, dst);
	dst = (u8 *)bgGetGfxPtr(bgMain) + (SCREEN_HEIGHT - qr->width * scale) / 2 * SCREEN_WIDTH + (SCREEN_WIDTH - qr->width * scale) / 2;
	display_qrcode(qr, dst);

	QRcode_free(qr);
	BG_PALETTE[0] = 0x0000;
	BG_PALETTE[1] = 0x7FFF;
	BG_PALETTE_SUB[0] = 0x0000;
	BG_PALETTE_SUB[1] = 0x7FFF;
	// Wait for input
	do {
		swiWaitForVBlank();
		scanKeys();
	} while(!(keysDown() & (KEY_A | KEY_B | KEY_TOUCH)));
	return show_test_confirmation_screen();
}


void copy_flicker_tiles(int mode, int bg1, int bg2) {
	vramSetBankA(VRAM_A_MAIN_BG);
  	vramSetBankC(VRAM_C_SUB_BG);
	if (mode == 1) {
		dmaCopy(flickerpatterntwoTiles, bgGetGfxPtr(bg1), sizeof(flickerpatterntwoTiles));
		dmaCopy(flickerpatterntwoPal, BG_PALETTE, sizeof(flickerpatterntwoPal));
		dmaCopy(flickerpatterntwoMap, bgGetMapPtr(bg1),  flickerpatterntwoMapLen);
		dmaCopy(flickerpatterntwoTiles, bgGetGfxPtr(bg2), sizeof(flickerpatterntwoTiles));
		dmaCopy(flickerpatterntwoPal, BG_PALETTE_SUB, sizeof(flickerpatterntwoPal));
		dmaCopy(flickerpatterntwoMap, bgGetMapPtr(bg2),  flickerpatterntwoMapLen);
	} else {
		dmaCopy(flickerpatternTiles, bgGetGfxPtr(bg1), sizeof(flickerpatternTiles));
		dmaCopy(flickerpatternPal, BG_PALETTE, sizeof(flickerpatternPal));
		dmaCopy(flickerpatternMap, bgGetMapPtr(bg1),  flickerpatternMapLen);
		dmaCopy(flickerpatternTiles, bgGetGfxPtr(bg2), sizeof(flickerpatternTiles));
		dmaCopy(flickerpatternPal, BG_PALETTE_SUB, sizeof(flickerpatternPal));
		dmaCopy(flickerpatternMap, bgGetMapPtr(bg2),  flickerpatternMapLen);
	}
}

int gfx_flicker_test_begin(void) {
	videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_5_2D);
	int bg3 = bgInit(3, BgType_ExRotation, BgSize_ER_256x256, 0,1);
	int bg4 = bgInitSub(3, BgType_ExRotation, BgSize_ER_256x256, 0,1);

	
	int mode = 0;
	float xScroll = 0;
	while(1) {
		/*
		int  	id,
		int  	angle,
		s32  	sx,
		s32  	sy,
		s32  	scrollX,
		s32  	scrollY,
		s32  	rotCenterX,
		s32  	rotCenterY 
		*/
		scanKeys();
		if (keysHeld() & KEY_RIGHT) {
			xScroll += 1;
			if (xScroll > 256) {
				xScroll = -256;
			}
		}
		bgSetScroll(bg3, xScroll, 0);
		bgSetScroll(bg4, xScroll, 0);
		copy_flicker_tiles(mode, bg3, bg4);
		swiWaitForVBlank();
		scanKeys();
		int pressed = keysDown();
		if (pressed & KEY_UP) {
			if (mode == 1) {
				mode = 0;
			} else { 
				mode = 1;
			}
		}
		bgUpdate();
		if(pressed & KEY_START) break;
	}
	return show_test_confirmation_screen();	
}

int gfx_colorbars_test_begin(void) 
{
	int currentImage = 0; // 0 colorbars, 1 checkerboard8x8, 2 checkerboard16x16, 3 checkerboard32x32, 4 bw gradient, 5 testcard #1
	// set the mode for 2 text layers and two extended background layers
	videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_5_2D);
    vramSetBankA(VRAM_A_MAIN_BG);
  	vramSetBankC(VRAM_C_SUB_BG);
    vramSetBankE(VRAM_E_TEX_PALETTE);
	int bg3 = bgInit(3, BgType_Bmp16, BgSize_B8_256x256, 0, 0);
	int bg4 = bgInitSub(3, BgType_Bmp16, BgSize_B8_256x256, 0, 0);
	dmaCopy(colorbarsBitmap, bgGetGfxPtr(bg3), 256*192);
	dmaCopy(colorbarsBitmap, bgGetGfxPtr(bg4), 256*192);
	dmaCopy(colorbarsPal, BG_PALETTE, 256*2);
	dmaCopy(colorbarsPal, BG_PALETTE_SUB, 256*2);
	while(1) {
		scanKeys();
		if (keysDown()&KEY_A) {
			currentImage += 1;
			if (currentImage > 6) {
				currentImage = 0;
			}
			switch (currentImage) {
				case 1:
					dmaCopy(checkerboard_8x8Bitmap, bgGetGfxPtr(bg3), 256*192);
					dmaCopy(checkerboard_8x8Bitmap, bgGetGfxPtr(bg4), 256*192);
					dmaCopy(checkerboard_8x8Pal, BG_PALETTE, 256*2);
					dmaCopy(checkerboard_8x8Pal, BG_PALETTE_SUB, 256*2);
					break;
				case 2:
					dmaCopy(checkerboard_16x16Bitmap, bgGetGfxPtr(bg3), 256*192);
					dmaCopy(checkerboard_16x16Bitmap, bgGetGfxPtr(bg4), 256*192);
					dmaCopy(checkerboard_16x16Pal, BG_PALETTE, 256*2);
					dmaCopy(checkerboard_16x16Pal, BG_PALETTE_SUB, 256*2);
					break;
				case 3:
					dmaCopy(checkerboard_32x32Bitmap, bgGetGfxPtr(bg3), 256*192);
					dmaCopy(checkerboard_32x32Bitmap, bgGetGfxPtr(bg4), 256*192);
					dmaCopy(checkerboard_32x32Pal, BG_PALETTE, 256*2);
					dmaCopy(checkerboard_32x32Pal, BG_PALETTE_SUB, 256*2);
					break;
				case 4:
					dmaCopy(bwgradientBitmap, bgGetGfxPtr(bg3), 256*192);
					dmaCopy(bwgradientBitmap, bgGetGfxPtr(bg4), 256*192);
					dmaCopy(bwgradientPal, BG_PALETTE, 256*2);
					dmaCopy(bwgradientPal, BG_PALETTE_SUB, 256*2);
					break;
				case 5:
					dmaCopy(testcardBitmap, bgGetGfxPtr(bg3), 256*192);
					dmaCopy(testcardBitmap, bgGetGfxPtr(bg4), 256*192);
					dmaCopy(testcardPal, BG_PALETTE, 256*2);
					dmaCopy(testcardPal, BG_PALETTE_SUB, 256*2);
					break;
				case 6:
					dmaCopy(testcardtwoBitmap, bgGetGfxPtr(bg3), 256*192);
					dmaCopy(testcardtwoBitmap, bgGetGfxPtr(bg4), 256*192);
					dmaCopy(testcardtwoPal, BG_PALETTE, 256*2);
					dmaCopy(testcardtwoPal, BG_PALETTE_SUB, 256*2);
					break;
				default:
					dmaCopy(colorbarsBitmap, bgGetGfxPtr(bg3), 256*192);
					dmaCopy(colorbarsBitmap, bgGetGfxPtr(bg4), 256*192);
					dmaCopy(colorbarsPal, BG_PALETTE, 256*2);
					dmaCopy(colorbarsPal, BG_PALETTE_SUB, 256*2);
					break;
			}
		}
		swiWaitForVBlank();
		if (keysDown()&KEY_START) break;
	}
	return show_test_confirmation_screen();
}