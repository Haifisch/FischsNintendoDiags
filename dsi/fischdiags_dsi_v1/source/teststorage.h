#ifdef __cplusplus
extern "C" {
#endif

#ifndef __TESTSTORAGE_H__
#define __TESTSTORAGE_H__

enum TestType
{
	GFX3D,
	GFXColorBars,
	GFXQRCode,
	GFXFlicker
};

int save_test_result(TestType type, int result);

#endif

#ifdef __cplusplus
}
#endif