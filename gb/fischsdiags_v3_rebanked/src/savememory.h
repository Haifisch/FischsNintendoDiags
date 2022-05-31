#ifndef __savememory_h_INCLUDE
#define __savememory_h_INCLUDE

#include <stdint.h>
#include <gbdk/platform.h>

typedef struct Results
{
    unsigned char magic[4];
    unsigned char BUTTON_TEST_MAGIC[3]; // test #1
    unsigned char BUTTON_TEST[2]; // test #1
    unsigned char DISPLAY_TEST_MAGIC[3]; // 2
    unsigned char DISPLAY_TEST[2]; // 2
    unsigned char MEMORY_TEST_MAGIC[3]; // 3
    unsigned char MEMORY_TEST[2]; // 3
    unsigned char AUDIO_TEST_MAGIC[3]; // 4
    unsigned char AUDIO_TEST[2]; // 4
    unsigned char LINK_TEST_MAGIC[3];
    unsigned char LINK_TEST[2]; // 5
} TEST_SAVED_RESULTS;

void check_savemem();
void save_test_result(int testType, int testResult);
int mem_test();

#endif