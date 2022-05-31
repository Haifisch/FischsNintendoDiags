#ifndef FB_LIB
#define FB_LIB

#ifdef __cplusplus
extern "C" {
#endif

#include <stdio.h>
#include <nds.h>

/* It's best to include libcommon.h instead of libfb.h because it also includes
   useful defines such as button graphics in fonts */

//-----------------------//
// functions for rpg box //
//-----------------------//

/* This function will draw a dialog box on the screen using the sprites found in rpgbox.c
   and then set the clipping to be inside the box. */
void fb_setDialogBox(int x, int y, int width, int height);
void bg_setDialogBox(int x, int y, int width, int height);

/* This function will draw an animated dialog box on the screen expanding downard and to
   the right. */
void fb_dispAnimatedBox(int x, int y, int width, int height, int tx, int ty, const void *strDisp);
void bg_dispAnimatedBox(int x, int y, int width, int height, int tx, int ty, const void *strDisp);

/* This function returns the transparent color for the current rpg box data */
uint16 getTransparentColorBox();

/* This function returns the background color for the corrent rpg box data */
uint16 getBGColorBox();

//----------------------------//
// functions for text display //
//----------------------------//

/* Self explanitory, I hope. */
void fb_dispChar(int x, int y, int toDisp);
void bg_dispChar(int x, int y, int toDisp);
void fb_dispString(int x, int y, const void *toDisp);
void bg_dispString(int x, int y, const void *toDisp);

/* Returns the width in pixels of a string.  Stops at the first tab or newline it encounters. */
int getStringWidth(const void *toDisp, uint16 **FP);

/* Returns an array of integers containing the locations in the string where libfb would wrap text.
   NOTE: Not multi-font safe. */
uint getWrapPoints(int x, int y, const void *toDisp, int c_x, int c_y, int c_bx, int c_by, int **pts, uint16 **FP);

/* Display a string to any valid 256 by x sized uint16 buffer.
   Returns the height of the string in the case of long rendering. */
int dispString(int x, int y, const void *toDisp, uint16 *buffer, uint32 enableClipping, int c_x, int c_y, int c_bx, int c_by);

/* Allows you to calculate if an element will wordwrap within the callback */
void calculateNewXY(int *xpos, int *ypos);

/* Display a character to any valid 256 by x sized uint16 buffer. */
void dispChar(int x, int y, u32 chr, uint16 *buffer, uint max_X, uint max_Y);

/* Sets the output color of the current font.  Safe to call from within a callback. */
void setColor(uint16 color);

/* Sets the current font.  Safe to call from within a callback. */
void setFont(uint16 **FP);

/* Returns the width in pixels of a character in the current font */
uint32 getCharWidth(u32 toDisp);

/* Returns the height in pixels of the current font */
uint32 getFontHeight();

/* Returns the width of a tabstop in the current font */
uint32 getTabStop();

/* Returns the transparent color used in the current font */
uint16 getTransparentColorFont();

/* Pretty self explanitory.  Set to true for enabled or false for disabled.
   Safe to call form within a callback. */
void setBold(bool);
void setItalics(bool);
void setUnderline(bool);
void setStrikeThrough(bool);

/* Callback functions.  The callback function you define will be called
   before the display of every character in the string you pass to libfb.
   Useful for complex rendering with different colors or fonts.
   
   First param - Current position in string
   Second param - Current character in string
   Third param - Which pass (calc or display loop) libfb is on
   Fourth param - Current x-position of renderer
   Fifth param - Current y-position of renderer */
void setCallBack(int (*callback)(int,u32,int,int,int));
void clearCallBack();

/* Set to true to enable the callback to be fired for the calc loop and the display loop.
   Set to false to set the callback to be fired only on the second (display) loop. */
void setTwoPasEnabled(bool);

/* This function will set libfb to wrap to the left edge of the clipping area on a wordwrap or
   carriage return, even if the start position was not on the left edge. */
void setWrapToBorder();

/* this function will set libfb to wrap to the start position that the text string was displayed
   at. */
void setWrapNormal();

/* Returns the x and y positions respectively where the font renderer stopped.  Also usable in
   a callback but basically pointless due to parameters containing same data. */
int getLastX();
int getLastY();

//--------------------------------//
// functions for cursor mangement //
//--------------------------------//

/* These functions return respectively the position in the current string where the cursor
   would lie if moved directly up or down one line.  The text must have been displayed to the
   screen at least once already in order for the return to be valid. */
uint32 getPositionAbove();
uint32 getPositionBelow();

/* These functions enable and disable cursor management respectively. */
void showCursor();
void hideCursor();

/* Sets the cursor position in the text file, 0 being before the first character
   in the string. */
void setCursorPos(uint32 pos);

/* This function controls the position respective to the current character and 
   render color of the cursor. */
void setCursorProperties(uint16 color, int top, int height, int left);

/* This function controls the color of the highlight box that goes behind
   highlighted text. */
void setHighlightColor(uint16 color);

/* This function allows you to specify a portion of text to highlight. */
void setHighlight(int start, int end);

/* This function clears a highlight that is present. */
void clearHighlight();

//------------------------------//
// functions for sprite display //
//------------------------------//

/* These functions will return the width and height respectively of a libfb sprite. */
uint32 getSpriteWidth(uint16* sprite);
uint32 getSpriteHeight(uint16* sprite);

/* These functions allow you to enable or disable inverted sprite display. */
void drawNormal();
void drawInverse();

/* This function allows you to display a simple sprite to the screen.
   It will clip the sprite to the edge of the display and allows you to
   specify your own transparent color. */
void fb_dispSprite(int x, int y, uint16* sprite, uint16 tc);
void bg_dispSprite(int x, int y, uint16* sprite, uint16 tc);

/* This function acts as the above function, but allows you to mask the sprite
   with a certain colormask. */
void fb_dispCustomSprite(int x, int y, uint16* sprite, uint16 tc, uint16 colormask);
void bg_dispCustomSprite(int x, int y, uint16* sprite, uint16 tc, uint16 colormask);

/* This is a generic function for displaying any libfb sprite to any valid 256 by x sized
   uint16 buffer. */
void dispCustomSprite(int x, int y, uint16* sprite, uint32 tc, uint32 colormask, uint16 *bgFlag, uint max_X, uint max_Y);

//----------------------------------//
// functions for general operations //
//----------------------------------//

/* Initialize screen.  These are mutually exclusive and will work with only one initialized or both. */
void fb_init();
void bg_init();

/* Place backbuffer onto the screen.  Call this after a swiWaitForVblank for no flickering. */
void fb_swapBuffers();
void bg_swapBuffers();

/* Enables or disables clipping to the screen. */
void fb_disableClipping();
void bg_disableClipping();
void fb_enableClipping();
void bg_enableClipping();

/* Allows displaying of text elements anywhere on the screen. */
void fb_setDefaultClipping();
void bg_setDefaultClipping();

/* Sets a window on the current screen to clip text to. */
void fb_setClipping(int x, int y, int bx, int by);
void bg_setClipping(int x, int y, int bx, int by);

/* Returns a pointer to the current raw backbuffer.  Safe to write directly to
   as an array. */
uint16 *fb_backBuffer();
uint16 *bg_backBuffer();

/* Sets the erase color for backgrounds. */
void fb_setBGColor(uint16 color);
void bg_setBGColor(uint16 color);

/* Sets a background for the buffer.  Instead of filling with the
   current background color, libfb will fill with a specified raw
   picture. */
void fb_setBG(uint16 *buffer);
void bg_setBG(uint16 *buffer);

/* Removes a previously set background. */
void fb_eraseBG();
void bg_eraseBG();

/* Change the orientation of the screen. See libcommon for defines. */
void fb_setOrientation(int orientation);
void bg_setOrientation(int orientation);

/* Disables drawing the background or the erase color for the next frame. */
void disableBackgroundDraw();

/* Keeps the previous frame after swapping. */
void preserveBackground();

/* Returns whether or not something has been drawn to the backbuffer since the last
   frame swap. */
bool fb_needsUpdate();
bool bg_needsUpdate();

/* Sets the backbuffer to black. */
void fb_clear();
void bg_clear();

/* Draws a pixel to the screen. */
void fb_setPixel(int x, int y, uint16 color);
void bg_setPixel(int x, int y, uint16 color);

/* Draws a simple filled rectangle to the screen. */
void fb_drawRect(int x, int y, int bx, int by, uint16 color);
void bg_drawRect(int x, int y, int bx, int by, uint16 color);

/* Draws a simple box to the screen. */
void fb_drawBox(int x, int y, int bx, int by, uint16 c);
void bg_drawBox(int x, int y, int bx, int by, uint16 c);

/* Draws a filled rectangle to the screen. */
void fb_drawFilledRect(int x, int y, int bx, int by, uint16 borderColor, uint16 fillColor);
void bg_drawFilledRect(int x, int y, int bx, int by, uint16 borderColor, uint16 fillColor);

/* Draws a rectangle to any valid 256 by x sized uint16 buffer. */
void drawRect(int x, int y, int bx, int by, uint16 c, uint16 *buf, int max_y);

#ifdef __cplusplus
}
#endif
#endif
