#ifndef FBLIB_COMMON
#define FBLIB_COMMON

#define MAX_X 256
#define MAX_Y 256

#define BUFFER_SIZE 	65536   	//256*256

// control characters, use with %c in a sprintf
#define POS_LEFT	'\b'
#define POS_RIGHT	'\a'
#define POS_UP		'\v'
#define POS_DOWN	'\f'

// constants for button graphics, use with %c in a sprintf again
#define BUTTON_A 1
#define BUTTON_B 2
#define BUTTON_X 3
#define BUTTON_Y 4
#define BUTTON_LEFT 5
#define BUTTON_UP 6
#define BUTTON_DOWN 14
#define BUTTON_RIGHT 15
#define BUTTON_SELECT 16
#define BUTTON_START 17
#define BUTTON_L 18
#define BUTTON_R 19

#define SCROLL_UP 20
#define SCROLL_DOWN 21

#define ORIENTATION_0 0
#define ORIENTATION_90 1
#define ORIENTATION_180 2
#define ORIENTATION_270 3

#include "libfb.h"

#endif
