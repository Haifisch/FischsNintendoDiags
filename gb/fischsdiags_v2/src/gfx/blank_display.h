//AUTOGENERATED FILE FROM png2asset
#ifndef METASPRITE_blank_display_H
#define METASPRITE_blank_display_H

#include <stdint.h>
#include <gbdk/platform.h>
#include <gbdk/metasprites.h>

#define blank_display_TILE_ORIGIN 0
#define blank_display_TILE_H 8
#define blank_display_WIDTH 160
#define blank_display_HEIGHT 144
#define blank_display_TILE_COUNT 1
#define blank_display_MAP_ATTRIBUTES blank_display_map_attributes
#define blank_display_TILE_PALS 0

BANKREF_EXTERN(blank_display_palettes)
extern const palette_color_t blank_display_palettes[4];

BANKREF_EXTERN(blank_display_tiles)
extern const uint8_t blank_display_tiles[16];

BANKREF_EXTERN(blank_display_map)
extern const unsigned char blank_display_map[360];

BANKREF_EXTERN(blank_display_map_attributes)
extern const unsigned char blank_display_map_attributes[360];

#endif