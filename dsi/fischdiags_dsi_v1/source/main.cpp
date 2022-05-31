// libnds includes
#include <nds.h>
#include <nds/bios.h>
#include <gl2d.h>
#include <fat.h>
#include <nds/debug.h>
// std
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <time.h>

// locals
#include "godmode9i/nitrofs.h"
#include "godmode9i/nandio.h"
#include "godmode9i/tonccpy.h"
#include "godmode9i/my_sd.h"
#include "screenshot.h"
#include "filesystemtests.h"
#include "audiotests.h"
#include "gfxtest.h"
#include "buttonstests.h"
#include "wirelesstests.h"
#include "rtctime.h"
#include "logo.h"
#include "about.h"
#include "giftsprites.h"
#include "dragon.h"
#include "menubuttons.h"
#include "menu_buttons.h"
#include "messagebg.h"

// fonts
#include "font.hpp"
#include "ds_nftr.h"
#include "tbf_ww_l_nftr.h"
#include "tbf_ww_m_nftr.h"
#include "tbf_ww_s_nftr.h"

bool charging = false;
bool programEnd = false;
bool arm7Exiting = false;
u8 batteryLevel = 0;

//glImage  Tiles[(256/8) * (256/8)];

PrintConsole topScreen;
PrintConsole bottomScreen;
Font largeFont;

#define TEXT_BLACK 0xF0
#define TEXT_GRAY  0xF4
#define TEXT_WHITE 0xF8
#define TEXT_GREEN 0xFC

// +experiment(al)
typedef struct
{
	int id;
	int x;
	int y;

	u8* buttonTiles;

	u16* sprite_gfx_mem;
	u8*  frame_gfx;

	bool activated;
	int defaultState;
	int anim_frame;
} MainMenuButtonSprite;

struct MenuItem
{
	const char *Name;
};

struct Menu 
{
	int MenuIndex;
	const char *Name;
	MenuItem *Items;
	int NumberOfItems;
};

typedef struct {
	int SelectedIndex;
	Menu ActiveMenu;
} MenuStatus;

MenuItem Power_Menu_Items[5] = { 
	{"Sleep"}, 
	{"Shutdown"},
	{"Back to Launcher"},
	{"(Return)"},
	{nullptr}
};

MenuItem Wireless_Menu_Items[4] = { 
	{"Scan AP"}, 
	{"WFC Connect"}, 
	{"(Return)"},
	{nullptr}
};

MenuItem Buttons_Menu_Items[4] = { 
	{"Buttons"}, 
	{"Touch Pad"}, 
	{"(Return)"},
	{nullptr}
};

MenuItem Filesystem_Menu_Items[5] = { 
	{"NitroFS"},
	{"SDMMC"},
	{"NAND"},
	{"(Return)"},
	{nullptr}
};

MenuItem Memory_Menu_Items[3] = { 
	{"NO IMPLEMENTATION :("}, 
	{"(Return)"},
	{nullptr}
};

MenuItem Audio_Menu_Items[3] = { 
	{"Song Test"}, 
	{"(Return)"},
	{nullptr}
};

MenuItem GFX_Menu_Items[6] = { 
	{"3D Test"}, 
	{"Color Bars"},
	{"QR Code"},
	{"Flicker Test"},
	{"(Return)"},
	{nullptr}
};

Menu mainMenu = { 0, "Main Menu", NULL, 8 };
Menu gfxMenu = { 1, "Graphics", GFX_Menu_Items, 5 };
Menu audioMenu = { 2, "Audio", Audio_Menu_Items, 2 };
Menu memoryMenu = { 3, "Memory", Memory_Menu_Items, 2 };
Menu filesystemMenu = { 4, "Filesystem", Filesystem_Menu_Items, 4 };
Menu buttonsMenu = { 5, "Controls", Buttons_Menu_Items, 3 };
Menu wirelessMenu = { 5, "Wireless", Wireless_Menu_Items, 3 };
Menu powerMenu = { 6, "Power", Power_Menu_Items, 4 };

Menu menus[8] = {
	mainMenu,
	gfxMenu,
	audioMenu,
	memoryMenu,
	filesystemMenu,
	buttonsMenu,
	wirelessMenu,
	powerMenu
};

MenuStatus menuStatus = { 
	0, // current menu item idx
	mainMenu // active menu
};

constexpr std::array<std::array<u16, 16>, 2> fontPal = {{
	{
		0xFFFF, 0xDEF7, 0xC631, 0x8000, // Black
		0x0000, 0xEF7B, 0xD6B5, 0xC631, // Gray
		0x39CE, 0xC631, 0xF39C, 0xFFFF, // White on gray
		0x32AD, 0xC2D1, 0xDF57, 0xFFFF, // White on green
	},
	{
		0xFFFF, 0xDEF7, 0xC631, 0x8000, // Black
		0x0000, 0xEF7B, 0xD6B5, 0xC631, // Gray
		0x39CE, 0xC631, 0xF39C, 0xFFFF, // White on gray
		0x1DFD, 0xB63D, 0xD6DE, 0xFFFF, // White on orange
	}
}};

bool to_hex(char* dest, size_t dest_len, const uint8_t* values, size_t val_len) {
    if(dest_len < (val_len*2+1)) /* check that dest is large enough */
        return false;
    *dest = '\0'; /* in case val_len==0 */
    while(val_len--) {
        /* sprintf directly to where dest points */
        sprintf(dest, "%02X", *values);
        dest += 2;
        ++values;
    }
    return true;
}

bool operator == (const Menu &m1, const Menu &m2)
{
	if (m1.Name == m2.Name && m1.MenuIndex == m2.MenuIndex)
		return true;
	else
		return false;
}

bool operator != (const Menu &m1, const Menu &m2)
{
	if (m1.Name != m2.Name && m1.MenuIndex != m2.MenuIndex)
		return true;
	else
		return false;
}

int getBit(u32 byteFlag, int whichBit)
{
    if (whichBit > 0 && whichBit <= 32)
        return (byteFlag & (1<<(whichBit-1)));
    else
        return 0;
}

void fifoHandlerPower(u32 value32, void* userdata)
{
	if (value32 == 0x54495845) // 'EXIT'
	{
		programEnd = true;
		arm7Exiting = true;
	}
}

void fifoHandlerBattery(u32 value32, void* userdata)
{
	batteryLevel = value32 & 0xF;
	charging = (value32 & BIT(7)) != 0;
}

void init_splashscreen() {
	videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_5_2D);
	vramSetBankA(VRAM_A_MAIN_BG);
  	vramSetBankC(VRAM_C_SUB_BG);

  	int bg3 = bgInit(3, BgType_Bmp8, BgSize_B8_256x256, 0,0);
  	int bg4 = bgInitSub(3, BgType_Bmp8, BgSize_B8_256x256, 0,0);

  	dmaFillHalfWords(RGB15(0, 0, 0), bgGetGfxPtr(bg3), 256*256);
  	dmaFillHalfWords(RGB15(0, 0, 0), bgGetGfxPtr(bg4), 256*256);
}

// classique text menu, I didn't really wanna keep making buttons in photoshop tbh
void print_menu(Menu menu, int currentIdx) {
	largeFont.clear(true);
	// build & print the menu
	int idx = 0;
	int item_y = 2;
	int active_item_y = 0;

	while (idx < 16) {
		if (menu.Items[idx].Name == nullptr) break;
		if (strncmp(menu.Items[idx].Name, "#", 1) != 0) {
			largeFont.print(8, item_y, true, menu.Items[idx].Name, Alignment::left);
			if (idx == currentIdx) {
				active_item_y = item_y;
			}
		}
		item_y += 16;
		idx++;
	}
	largeFont.print(0, active_item_y, true, ">", Alignment::left);
	largeFont.update(true, false);
}

void update_mainmenu() {
	largeFont.clear(true);
	largeFont.print(0, 0, true, "==========================================", Alignment::center);
	time_t unixTime = time(NULL);
	struct tm* timeStruct = gmtime((const time_t *)&unixTime);

	char mainMenuStrBuff[256];
	// print current rtc time
	sprintf(mainMenuStrBuff, "%i/%i/%i - %02i:%02i:%02i", timeStruct->tm_mday, (timeStruct->tm_mon + 1), (timeStruct->tm_year+1900), timeStruct->tm_hour, timeStruct->tm_min, timeStruct->tm_sec);
	largeFont.print(0, 10, true, mainMenuStrBuff, Alignment::center);

	// battery info
	memset(mainMenuStrBuff, 0x0, 256);
	sprintf(mainMenuStrBuff, "BAT: %i %s", batteryLevel, charging ? "(CHARGING)":"(NOT CHARGING)");
	largeFont.print(4, 24, true, mainMenuStrBuff, Alignment::left);

	// Get ConsoleID
	u8 consoleID[8];
	u8 consoleIDfixed[8];
	getConsoleID(consoleID);
	for (int i = 0; i < 8; i++) {
		consoleIDfixed[i] = consoleID[7-i];
	}
	char consoleIDStr[32];
	to_hex(consoleIDStr, sizeof(consoleIDStr), consoleIDfixed, sizeof(consoleIDfixed));
	// print console info
	memset(mainMenuStrBuff, 0x0, 256);
	sprintf(mainMenuStrBuff, "CID: %s", consoleIDStr);
	largeFont.print(128, 38, true, mainMenuStrBuff, Alignment::left);

	// what mode are we running in?
	sprintf(mainMenuStrBuff, "DSi Mode: %s", isDSiMode() ? "YES":"NO");
	largeFont.print(4, 38, true, mainMenuStrBuff, Alignment::left);

	largeFont.print(0, 52, true, "==========================================", Alignment::center);
	largeFont.update(true, false);
}


void init_mainmenu(MainMenuButtonSprite *menuButtons) {
	nocashMessage("init_mainmenu()\n");

  	init_splashscreen();
	// initialize video
	videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_5_2D);
	vramSetBankA(VRAM_A_MAIN_BG_0x06000000);
	vramSetBankB(VRAM_B_MAIN_BG_0x06020000);
	vramSetBankC(VRAM_C_SUB_BG_0x06200000);
	vramSetBankD(VRAM_D_MAIN_BG_0x06040000);
	vramSetBankE(VRAM_E_MAIN_SPRITE);
	vramSetBankF(VRAM_F_MAIN_SPRITE_0x06410000);
	vramSetBankG(VRAM_G_MAIN_SPRITE_0x06414000);
	vramSetBankH(VRAM_H_LCD);
	vramSetBankI(VRAM_I_LCD);
	lcdMainOnBottom();

	// Fonts
    largeFont = Font(tbf_ww_s_nftr, tbf_ww_s_nftr_size);
    //BG_PALETTE[0xF0] = RGB15(32, 32, 32);
    largeFont.bgId = bgInit(0, BgType_Text8bpp, BgSize_T_256x256, 0, 0);
    tonccpy(BG_PALETTE + 0xF0, fontPal[0].data(), fontPal[0].size() * sizeof(u16));
    largeFont.clear(true).update(true, false);
	largeFont.palette(TEXT_WHITE);

    // set up our bitmap background
	int bg3 = bgInitSub(3, BgType_Bmp8, BgSize_B8_256x256, 0, 0);
	dmaCopy(logoBitmap, bgGetGfxPtr(bg3), logoBitmapLen);
    dmaCopy(logoPal, BG_PALETTE_SUB, logoPalLen);

	int messagebgId = bgInit(3, BgType_Bmp8, BgSize_B8_256x256, 0, 0);
	dmaCopy(messagebgTiles, bgGetGfxPtr(messagebgId), 256*192);
    dmaCopy(messagebgPal, BG_PALETTE, messagebgPalLen);
    bgSetPriority(largeFont.bgId, 3);
	
	// init the main menu button sprites    
    oamInit(&oamMain, SpriteMapping_1D_64, false);
	int buttonX = 0;
    int buttonY = 64;
	for (int i = 0; i < MAINMENU_BUTTON_SPRITE_COUNT; ++i)
	{
		menuButtons[i] = { (i+1), buttonX, buttonY };
		menuButtons[i].activated = false;
		menuButtons[i].sprite_gfx_mem = oamAllocateGfx(&oamMain, SpriteSize_64x64, SpriteColorFormat_256Color);
		menuButtons[i].frame_gfx = (u8*)menuButtonTiles[i];
		buttonX += 64;
		if (buttonX >= 256) {
			buttonX = 0;
			buttonY += 64;
		}
	}
	dmaCopy(menu_gfx_btnPal, SPRITE_PALETTE, 512);    
}

int show_about_menu() {
	videoSetMode(MODE_5_2D);
	videoSetModeSub(MODE_0_2D);
    vramSetBankA(VRAM_A_MAIN_BG);
  	// set up our bitmap background
  	consoleInit(NULL, 0, BgType_Text4bpp, BgSize_T_256x256, 22, 3, false, true);

	int bg3 = bgInit(3, BgType_Bmp8, BgSize_B8_256x256, 0,0);
	dmaCopy(aboutBitmap, bgGetGfxPtr(bg3), logoBitmapLen);
    dmaCopy(aboutPal, BG_PALETTE, logoPalLen);

    PERSONAL_DATA p = *PersonalData;
	char str[256];
	char name[20];
	char message[26];
	memset(name, 0, 20);
	memset(message, 0, 26);
	uint16 x=0;
	for(x=0;x<p.nameLen;x++)
	{
		name[x] = (char)(p.name[x] & 0xFF);
	}
	for(x=0;x<p.messageLen;x++)
	{
		message[x] = (char)(p.message[x] & 0xFF);
	}
	iprintf("\x1b[2J");
	iprintf("\x1b[0;0H|------------------------------|");
	iprintf("\n\nAbout this DS(i)\n");
	sprintf(str, "name => %s\nmessage => %s\n", name, message);
    iprintf("%s\nbirth month => %i day => %i\n", str, PersonalData->birthMonth, PersonalData->birthDay);
    while(1) {
		swiWaitForVBlank();
		scanKeys();
		if (keysDown()&KEY_START) break;
	}
    return 0;
}

int main(int argc, char **argv)
{
	//consoleDebugInit(DebugDevice_NOCASH);
	//fifoSetValue32Handler(FIFO_USER_02, fifoHandlerPower, NULL);
	if (isDSiMode()) {
		fifoSetValue32Handler(FIFO_USER_04, sdStatusHandler, nullptr);
	}
	fifoSetValue32Handler(FIFO_USER_08, fifoHandlerBattery, NULL);

	MainMenuButtonSprite menuButtons[MAINMENU_BUTTON_SPRITE_COUNT];
	touchPosition touch;
	srand(time(NULL));
	init_splashscreen();
	init_mainmenu(menuButtons);

    int frame = 0;
	bool exitEntirelyPls = false;
	int selectedButton = 0;
	menuStatus.ActiveMenu = mainMenu;
	while (1) {
		// increment frame counter 
		frame++;
		scanKeys();
		int keydown = keysDown();
		if (menuStatus.ActiveMenu == mainMenu) {
			update_mainmenu();
			if (keydown & KEY_TOUCH) {
				touchRead(&touch);
				for (int q = 0; q < MAINMENU_BUTTON_SPRITE_COUNT; ++q) {
					if ((touch.px < (menuButtons[q].x + 64) && touch.px > menuButtons[q].x) && (touch.py < (menuButtons[q].y + 32) && touch.py > menuButtons[q].y)) {
						menuButtons[q].activated = true;
						selectedButton = menuButtons[q].id;
					} else {
						menuButtons[q].activated = false;
					}
				}
			} else {
				if (keydown & KEY_RIGHT) {
					bool allButtonsAreDeactivated = true;
					for (int q = 0; q < MAINMENU_BUTTON_SPRITE_COUNT; ++q) {
						if (menuButtons[q].activated) {
							if ((q + 1) < MAINMENU_BUTTON_SPRITE_COUNT) {
								menuButtons[q+1].activated = true;
							} else {
								menuButtons[0].activated = true;
							}
							menuButtons[q].activated = false;
							selectedButton = menuButtons[q+1].id;
							allButtonsAreDeactivated = false;
							break;
						}
					}
					if (allButtonsAreDeactivated) {
						menuButtons[0].activated = true;
					}
				}
				if (keydown & KEY_LEFT) {
					bool allButtonsAreDeactivated = true;
					for (int q = 0; q < MAINMENU_BUTTON_SPRITE_COUNT; ++q) {
						if (menuButtons[q].activated) {
							menuButtons[q].activated = false;
							if ((q - 1) < 0) {
								menuButtons[MAINMENU_BUTTON_SPRITE_COUNT-1].activated = true;
							} else {
								menuButtons[q-1].activated = true;
							}
							
							selectedButton = menuButtons[q-1].id;
							allButtonsAreDeactivated = false;
							break;
						}
					}
					if (allButtonsAreDeactivated) {
						menuButtons[MAINMENU_BUTTON_SPRITE_COUNT - 1].activated = true;
					}
				}
			}
			bool hideSpritesPls = false;
			if (keydown & KEY_A) {
				switch (selectedButton) {
					case 1: // goto gfx menu
						menuStatus.ActiveMenu = gfxMenu;
						hideSpritesPls = true;
						break;
					case 2: // goto audio menu
						menuStatus.ActiveMenu = audioMenu;
						hideSpritesPls = true;
						break;
					case 3: // goto memory menu
						menuStatus.ActiveMenu = memoryMenu;
						hideSpritesPls = true;
						break;
					case 4: // jump straight into the fs test / demo
						//init_filesystem_and_begin_test(argv[0], (argc > 0));
						menuStatus.ActiveMenu = filesystemMenu;
						hideSpritesPls = true;
						break;
					case 5:
						menuStatus.ActiveMenu = buttonsMenu;
						hideSpritesPls = true;
						break;
					case 6: // jump straight into the wireless test / demo
						menuStatus.ActiveMenu = wirelessMenu;
						//wireless_test_begin();
						hideSpritesPls = true;
						break;
					case 7: // goto the power mgmt menu
						menuStatus.ActiveMenu = powerMenu;
						hideSpritesPls = true;
						break;
					case 8: // show about graphics
						show_about_menu();
						init_mainmenu(menuButtons);
						break;
					default:
						menuStatus.ActiveMenu = mainMenu; // menu default to itself
						break;
				}
			}
			if (!hideSpritesPls) {
				for (int i = 0; i < MAINMENU_BUTTON_SPRITE_COUNT; ++i)
				{
					u8* offset = menuButtonTiles[i] + (menuButtons[i].activated ? 1:0) * 64*64;
					dmaCopy(offset, menuButtons[i].sprite_gfx_mem, 64*64);
					oamSet(&oamMain, i, menuButtons[i].x, menuButtons[i].y, 0, 0, SpriteSize_64x64, SpriteColorFormat_256Color, menuButtons[i].sprite_gfx_mem, -1, false, false, false, false, false);
					oamSetHidden(&oamMain, i, false);
				}
			} else {
				for (int i = 0; i < MAINMENU_BUTTON_SPRITE_COUNT; ++i)
				{
					oamSetHidden(&oamMain, i, true);
				}
			}
		} else {
			if (keydown & KEY_DOWN) {
				if (menuStatus.SelectedIndex < (menuStatus.ActiveMenu.NumberOfItems - 1)) {
					menuStatus.SelectedIndex += 1;
				}
				fprintf(stderr, "menuStatus.SelectedIndex %i\n", menuStatus.SelectedIndex);
			}
			if (keydown & KEY_UP) {
				if (menuStatus.SelectedIndex <= 0) {
					menuStatus.SelectedIndex = (menuStatus.ActiveMenu.NumberOfItems - 1);
				} else {
					menuStatus.SelectedIndex -= 1;
				}
				fprintf(stderr, "menuStatus.SelectedIndex %i\n", menuStatus.SelectedIndex);
			}
			print_menu(menuStatus.ActiveMenu, menuStatus.SelectedIndex);
			if (menuStatus.ActiveMenu == gfxMenu && keydown & KEY_A) 
			{
				switch (menuStatus.SelectedIndex) {
					case 0:
						gfx_3d_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 1:
						gfx_colorbars_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 2:
						gfx_qrcode_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 3:
						gfx_flicker_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 4:
						menuStatus.ActiveMenu = mainMenu;
						break;
					default:
						menuStatus.ActiveMenu = gfxMenu; // menu default to itself
						break;
				}
				menuStatus.SelectedIndex = 0;
			} else if (menuStatus.ActiveMenu == audioMenu && keydown & KEY_A) 
			{
				switch (menuStatus.SelectedIndex) {
					case 0:
						audio_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 1:
						menuStatus.ActiveMenu = mainMenu;
						break;
					default:
						menuStatus.ActiveMenu = audioMenu; // menu default to itself
						break;
				}
				menuStatus.SelectedIndex = 0;
			} else if (menuStatus.ActiveMenu == buttonsMenu && keydown & KEY_A) 
			{
				switch (menuStatus.SelectedIndex) {
					case 0:
						buttons_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 1:
						touchpad_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 2:
						menuStatus.ActiveMenu = mainMenu;
						break;
					default:
						menuStatus.ActiveMenu = buttonsMenu; // menu default to itself
						break;
				}
				menuStatus.SelectedIndex = 0;
			} else if (menuStatus.ActiveMenu == powerMenu && keydown & KEY_A) 
			{
				switch (menuStatus.SelectedIndex) {
					case 0:
						systemSleep();
						break;
					case 1:
						systemShutDown();
						break;
					case 2:
						exitEntirelyPls = true;
						break;
					case 3:
						menuStatus.ActiveMenu = mainMenu;
						break;
					default:
						menuStatus.ActiveMenu = powerMenu; // menu default to itself
						break;
				}
				menuStatus.SelectedIndex = 0;
			} else if (menuStatus.ActiveMenu == wirelessMenu && keydown & KEY_A) 
			{
				switch (menuStatus.SelectedIndex) {
					case 0:
						wireless_scan_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 1:
						wireless_defaultconnect_test_begin();
						init_mainmenu(menuButtons);
						break;
					case 2:
						menuStatus.ActiveMenu = mainMenu;
						break;
					default:
						menuStatus.ActiveMenu = wirelessMenu; // menu default to itself
						break;
				}
				menuStatus.SelectedIndex = 0;
			} else if (menuStatus.ActiveMenu == filesystemMenu && keydown & KEY_A) 
			{
				switch (menuStatus.SelectedIndex) {
					case 0:
						init_filesystem_and_begin_test(argv[0], (argc > 0), 0);
						init_mainmenu(menuButtons);
						break;
					case 1:
						init_filesystem_and_begin_test(argv[0], (argc > 0), 1);
						init_mainmenu(menuButtons);
						break;
					case 2:
						init_filesystem_and_begin_test(argv[0], (argc > 0), 2);
						init_mainmenu(menuButtons);
						break;
					case 3:
						menuStatus.ActiveMenu = mainMenu;
						break;
					default:
						menuStatus.ActiveMenu = filesystemMenu; // menu default to itself
						break;
				}
				menuStatus.SelectedIndex = 0;
			} else if (menuStatus.ActiveMenu == memoryMenu && keydown & KEY_A) 
			{
				switch (menuStatus.SelectedIndex) {
					case 0:
						menuStatus.ActiveMenu = mainMenu;
						break;
					default:
						menuStatus.ActiveMenu = memoryMenu; // menu default to itself
						break;
				}
				menuStatus.SelectedIndex = 0;
			}
			if (exitEntirelyPls) { break; }
		}
		swiWaitForVBlank();
		oamUpdate(&oamMain);
	}
	return 0;
}