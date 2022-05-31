#ifndef __test_common_h_INCLUDE
#define __test_common_h_INCLUDE

#include <stdint.h>
#include <gbdk/platform.h>

#define TEST_PASSED 0x25
#define TEST_FAILED 0x69
#define PRINT_FUNC_INFO EMU_printf("[DBG] (%s:%d @ %s())", __FILE__, __LINE__, __func__)
#define PRINT_BANK_INFO EMU_printf("[DBG] bank => %d", _current_bank)

BANKREF_EXTERN(blank_display);
extern void blank_display();

BANKREF_EXTERN(blank_display);
extern void blank_display();

#endif