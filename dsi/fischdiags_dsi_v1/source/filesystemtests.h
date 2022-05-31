#ifdef __cplusplus
extern "C" {
#endif

#ifndef __FILESYSTEMTEST_H__
#define __FILESYSTEMTEST_H__

void do_nand_test(void);
void do_sd_test(void);
void do_nitrofs_test(char *argvVar);
int init_filesystem_and_begin_test(char *argvVar, bool hasArgs, int testType);

#endif

#ifdef __cplusplus
}
#endif