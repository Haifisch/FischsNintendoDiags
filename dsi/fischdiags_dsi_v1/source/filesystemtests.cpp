/* 
	hiiiiii, a lot of these tests use godmode9i as reference / straight up usage
	extreme love to the project maintainers there.

	srsly <3
	~ haifisch
*/
#include <nds.h>
//#include <filesystem.h>
#include <nds/arm9/dldi.h>
#include <dirent.h>
#include <fat.h>
#include <stdio.h>
#include <string>
#include <sys/stat.h>
#include <sys/statvfs.h>
#include "godmode9i/nitrofs.h"
#include "godmode9i/nandio.h"
#include "filesystemtests.h"
#include "testconfirmation.h"

#define READWRITE_TEST_FILE "sd:/FD_Data/test.bin"

uint readWriteTestTicks = 0;

bool fatInitd = false;
bool nandMounted = false;
bool sdMounted = false;
bool ramdriveMounted = false;
bool canSkipFsInitialization = false;

char fatLabel[12];
char sdLabel[12];

//the speed of the timer when using ClockDivider_1024
#define TIMER_SPEED (BUS_CLOCK/1024)

typedef enum
{
	timerState_Stop,
	timerState_Pause,
	timerState_Running
}TimerStates;


u64 getBytesFree(const char* drivePath) {
    struct statvfs st;
    statvfs(drivePath, &st);
    return (u64)st.f_bsize * (u64)st.f_bavail;
}

bool nandFound(void) {
	return (access("nand:/", F_OK) == 0);
}

bool nitrofsFound(void) {
	return (access("nitro:/", F_OK) == 0);
}

bool sdFound(void) {
	return (access("sd:/", F_OK) == 0);
}


//---------------------------------------------------------------------------------
void dirlist(const char* path) {
//---------------------------------------------------------------------------------

	DIR* pdir = opendir(path);

	if (pdir != NULL) {

		for (int i = 0; i < 5; ++i)
		{
			struct dirent* pent = readdir(pdir);
			if(pent == NULL) break;
			
			if(strcmp(".", pent->d_name) != 0 && strcmp("..", pent->d_name) != 0 && strcmp(pent->d_name, "System Volume Information") != 0) {
				if(pent->d_type == DT_DIR) {
					printf("%s/%s <DIR>\n", (strcmp("/",path) == 0)?"":path, pent->d_name);
				} else {
					printf("%s/%s\n",(strcmp("/",path) == 0)?"":path, pent->d_name);
				}
			}
		}
		
		closedir(pdir);
	} else {
		printf("opendir() failure.\n");
	}
}

void printBytes(unsigned long long bytes) {
	if (bytes < 1024){
		printf("%dB\n", (unsigned int)bytes);
	} else if (bytes < 1024 * 1024) {
		printf("%.2fKB\n", (float)bytes / 1024.f);
	} else if (bytes < 1024 * 1024 * 1024) {
		printf("%.2fMB\n", (float)bytes / 1024.f / 1024.f);
	} else {
		printf("%.2fGB\n", (float)bytes / 1024.f / 1024.f / 1024.f);
	}
}

void start_readwrite_timer(void) {
	// start timer
	timerStart(0, ClockDivider_1024, 0, NULL);
}

void reset_readwrite_timer(void) {
	timerStop(0);
	readWriteTestTicks = 0;
}

void sd_speed_test(void) {
	struct stat st = {0};
	if (stat("sd:/FD_Data/", &st) == -1) 
	{ 
		printf("sd:/FD_Data/ directory not available!\n");
		return;
	}
	printf("\x1b[2J");
	iprintf("\x1b[0;0Hstarting sd read / write speed test\n");
	// write test
	unsigned char randData[0x30] = {0x46, 0x49, 0x53, 0x43, 0x48, 0x27, 0x53, 0x20, 0x44, 0x49, 0x41, 0x47, 0x53, 0x20, 0x53, 0x44, 0x52, 0x45, 0x41, 0x44, 0x2D, 0x57, 0x52, 0x49, 0x54, 0x45, 0x20, 0x54, 0x45, 0x53, 0x54, 0x20, 0x44, 0x41, 0x54, 0x41, 0x20, 0x48, 0x49, 0x20, 0x4D, 0x41, 0x21, 0x20, 0x3A, 0x29, 0x20, 0x20};
	char endStr[] = "TEST_PASSED";
	FILE * fp;
	start_readwrite_timer();
	for (int i = 0; i < 10; ++i)
	{
		//printf("opening file...\n");
		fp = fopen(READWRITE_TEST_FILE, "wb");
		printf("\x1b[2;0Hwrite #%i\n", i);
		fwrite(randData, 1, sizeof(randData), fp);
		fwrite(endStr, 1, sizeof(endStr), fp);
		//printf("closing file...\n");
		fclose(fp);
	}
	readWriteTestTicks += timerPause(0);
	iprintf("\x1b[3;0Hticks:  %u\n", readWriteTestTicks);
	iprintf("\x1b[4;0Hsecond: %u:%u\n", readWriteTestTicks/TIMER_SPEED, ((readWriteTestTicks%TIMER_SPEED)*1000) /TIMER_SPEED);
	reset_readwrite_timer();
	start_readwrite_timer();
	char readBuff[0x3B];
	for (int i = 0; i < 10; ++i)
	{
		memset(readBuff, 0, sizeof(readBuff));
		fp = fopen(READWRITE_TEST_FILE, "rb");
		int numRead = fread(readBuff, sizeof(char), sizeof(readBuff), fp);
		printf("\x1b[5;0Hread #%i, num => %i\n", i, numRead);
		fclose(fp);
	}
	printf("\x1b[6;0H%s\n\n", readBuff);
	readWriteTestTicks += timerPause(0);
	iprintf("ticks:  %u\n", readWriteTestTicks);
	iprintf("second: %u:%u\n", readWriteTestTicks/TIMER_SPEED, ((readWriteTestTicks%TIMER_SPEED)*1000) /TIMER_SPEED);
	reset_readwrite_timer();
}

void do_nand_test(void) 
{
	if (!nandFound) {
		iprintf("\x1b[1;31mCRIT:\x1b[0m nand not found! :(\n");
		return;
	}
	iprintf("\x1b[2J");
	//setup nand access
	if (nandMounted == false) {
		iprintf("initalizing nand...\n");
		if (fatMountSimple("nand", &io_dsi_nand))
		{
			iprintf("nand init'd.\n");
			nandMounted = true;
		} else {
			iprintf("failed to init nand :(\n");
			return;
		}
	}
	printf("trying dirlist nand:/\n");
	//chdir("nand:/");
	dirlist("nand:/");
	printf("Free space on nand:/ => ");
	printBytes(getBytesFree("nand:/"));
	//fatUnmount("nand");
}

void do_sd_test(void) 
{
	if (!sdFound) {
		iprintf("WARN: sd not found! :(\n");
		return;
	}
	iprintf("\x1b[2J");
	//setup sd card access
	if (sdMounted == false) {
		iprintf("initalizing fatfs...\n");
		if (fatInitd == false) {
			if (fatInitDefault())
			{
				iprintf("fatfs init'd.\n");
				fatInitd = true;
				sdMounted = true;
			} else {
				iprintf("failed to init fatfs :(\n");
				return;
			}
		}
	}
	
	fatGetVolumeLabel("sd", fatLabel);
	printf("LABEL: %s\n", fatLabel);
	printf("trying dirlist sd:/\n");
	//chdir("sd:/");
	dirlist("sd:/");
	printf("Free space on sd:/ => ");
	printBytes(getBytesFree("sd:/"));
}

void do_nitrofs_test(char *ndsPath) 
{
	iprintf("\x1b[2J");
	iprintf("initalizing nitrofs...\n");
	if (fatInitd == false) {
		if (fatInitDefault())
		{
			iprintf("fatfs init'd.\n");
			fatInitd = true;
		} else {
			iprintf("failed to init fatfs :(\n");
			return;
		}
	}
	
	if (strlen(ndsPath) > 0) {
		iprintf("\n\n%s\n",ndsPath);
		if (nitroFSInit(ndsPath)) 
		{ 
			iprintf("nitrofs init'd.\n");
		} else {
			iprintf("failed to init nitrofs :(\n");
			iprintf("\n\n%s\n",ndsPath);
			return;
		}
	} else {
		if (sdFound) {
			if (nitroFSInit("sd:/FischsDiagsNTR.dsi")) 
			{ 
				iprintf("nitrofs init'd.\n");
			} else {
				iprintf("failed to init nitrofs :(\n");
				iprintf("\n\n%s\n",ndsPath);
				return;
			}
		} else {
			iprintf("failed to init nitrofs :(\n");
			
			return;
		}
	}
	printf("trying dirlist nitro:/\n");
	//chdir("nitro:/");
	dirlist("nitro:/");
	// now, try reading a file to make sure things are working OK.
	FILE* inf = fopen("nitro:/fs_test/subdir/test.txt","rb");
	if (inf)
	{
		int len;
		fseek(inf,0,SEEK_END);
		len = ftell(inf);
		fseek(inf,0,SEEK_SET);

		char *entireFile = (char*)malloc(len+1);
		entireFile[len] = 0;
		if(fread(entireFile,1,len,inf) != len) {
			printf("savage error reading the bytes from the file!\n");
		} else {
			printf("%s\n",entireFile);
		}
		free(entireFile);

		fclose(inf);
	} else {
		printf("couldn't open test.txt\n");
	}
}

int init_filesystem_and_begin_test(char *ndsPath, bool hasArgs, int testType) // note ndsPath very well may / can be null if the nds path wasn't provided as an argument by the launcher/hbmenu
{
	videoSetMode(MODE_0_2D);
	//videoSetModeSub(MODE_0_2D);
	vramSetBankA(VRAM_A_MAIN_BG_0x06000000);
	vramSetBankB(VRAM_B_MAIN_BG_0x06020000);
	vramSetBankC(VRAM_C_MAIN_BG_0x06040000);
	lcdMainOnBottom();

  	consoleInit(NULL, 3, BgType_Text4bpp, BgSize_T_256x256, 2, 0, true, true);

	if (testType == 0) {
		do_nitrofs_test(ndsPath);
	} else if (testType == 1) {
		do_sd_test();
		iprintf("\nPress any key to continue\n");
		do {
		    swiWaitForVBlank();
		    scanKeys();
		} while(!keysDown());
		sd_speed_test();
	} else if (testType == 2) {
		do_nand_test();
	}
	do {
	    swiWaitForVBlank();
	    scanKeys();
	} while(!keysDown());
	return show_test_confirmation_screen();
}