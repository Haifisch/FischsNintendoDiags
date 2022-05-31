#ifdef __cplusplus
extern "C" {
#endif

#ifndef __MENUBUTTONS_H__
#define __MENUBUTTONS_H__

#include "menu_gfx_btn.h"
#include "menu_sfx_btn.h"
#include "menu_mem_btn.h"
#include "menu_controls_btn.h"
#include "menu_power_btn.h"
#include "menu_fs_btn.h"
#include "menu_wireless_btn.h"
#include "menu_about_btn.h"

const static int MAINMENU_BUTTON_SPRITE_COUNT = 8;

u8 *menuButtonTiles[MAINMENU_BUTTON_SPRITE_COUNT] = {
	(u8*)menu_gfx_btnTiles,
	(u8*)menu_sfx_btnTiles,
	(u8*)menu_mem_btnTiles,
	(u8*)menu_fs_btnTiles,
	(u8*)menu_controls_btnTiles,
	(u8*)menu_wireless_btnTiles,
	(u8*)menu_power_btnTiles,
	(u8*)menu_about_btnTiles
};

#endif

#ifdef __cplusplus
}
#endif

