#pragma bank 1

#include <gb/gb.h>
#include "font.h"
#include "text.h"


BANKREF(text_load_font)
void text_load_font() BANKED
{
    palette_color_t text_font_palettes[4] = {
        RGB_WHITE, RGB_RED, RGB_BLUE, RGB_BLACK
    };
    set_bkg_palette(0, 1, text_font_palettes);
    set_bkg_data(TEXT_FONT_OFFSET, font_TILE_COUNT, font_tiles);
}

// Write the given char at the (x, y) position on the Background layer
BANKREF(text_print_char_bkg)
void text_print_char_bkg(UINT8 x, UINT8 y, unsigned char chr) BANKED
{
    UINT8 tile = _TEXT_CHAR_TOFU;
    if (chr >= 'a' && chr <= 'z') {
        tile = _TEXT_CHAR_A + chr - 'a';
    } else if (chr >= 'A' && chr <= 'Z') {
        tile = _TEXT_CHAR_A + chr - 'A';
    } else if (chr >= '0' && chr <= '9') {
        tile = _TEXT_CHAR_0 + chr - '0';
    } else {
        switch (chr) {
            case '\'':
                tile = _TEXT_CHAR_APOSTROPHE;
                break;
            case '-':
                tile = _TEXT_CHAR_DASH;
                break;
            case '.':
                tile = _TEXT_CHAR_DOT;
                break;
            case ',':
                tile = _TEXT_CHAR_COMMA;
                break;
            case ':':
                tile = _TEXT_CHAR_COLON;
                break;
            case '!':
                tile = _TEXT_CHAR_EXCLAMATION;
                break;
            case '?':
                tile = _TEXT_CHAR_INTERROGATION;
                break;
            case '(':
                tile = _TEXT_CHAR_LPARENTHESES;
                break;
            case ')':
                tile = _TEXT_CHAR_RPARENTHESES;
                break;
            case ' ':
                tile = _TEXT_CHAR_SPACE;
                break;
        }
    }
    set_bkg_tiles(x, y, 1, 1, &tile);
}

// Write the given string at the (x, y) position on the Background layer
// Line feed (\n) allowed
BANKREF(text_print_string_bkg)
void text_print_string_bkg(UINT8 x, UINT8 y, unsigned char *string) BANKED
{
    UINT8 offset_x = 0;
    UINT8 offset_y = 0;

    while (string[0]) {
        if (string[0] == '\n') {
            offset_x = 0;
            offset_y += 1;
        } else {
            text_print_char_bkg(x + offset_x, y + offset_y, (unsigned char) string[0]);
            offset_x += 1;
        }
        string += 1;  // Increment pointer address, /!\ THIS IS DANGEROUS!
    }
}