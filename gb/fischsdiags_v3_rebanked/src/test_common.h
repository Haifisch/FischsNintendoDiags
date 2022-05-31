#ifndef __test_common_h_INCLUDE
#define __test_common_h_INCLUDE

#define TEST_PASSED 0x25
#define TEST_FAILED 0x69
#define PRINT_FUNC_INFO EMU_printf("[DBG] %s:%d @ %s() bank: %d", __FILE__, __LINE__, __func__, _current_bank)
#define PRINT_BANK_INFO EMU_printf("[DBG] bank => %d", _current_bank)

#define RUMBLE_REG			*(uint8_t *)0x4000
#define RUMBLE_TOGGLE		RUMBLE_REG ^= 1UL << 3;
#define RUMBLE_ON 			RUMBLE_REG |= 1UL << 3;
#define RUMBLE_OFF 			RUMBLE_REG &= ~(1UL << 3);


BANKREF_EXTERN(blank_display)
extern void blank_display() BANKED;

BANKREF_EXTERN(ask_user_pass_or_fail)
extern int ask_user_pass_or_fail() BANKED;

#endif