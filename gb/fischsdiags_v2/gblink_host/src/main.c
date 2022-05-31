#include <gb/gb.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <gbdk/console.h>

const UBYTE test_data_str[0x20] = {0x46, 0x49, 0x53, 0x43, 0x48, 0x53, 0x20, 0x44, 0x49, 0x41, 0x47, 0x53, 0x20, 0x43, 0x4F, 0x4D, 0x4D, 0x20, 0x54, 0x45, 0x53, 0x54, 0x20, 0x44, 0x41, 0x54, 0x41, 0x20, 0x4C, 0x49, 0x4E, 0x4B}; 

void wait_for_start() 
{
    UBYTE start[4] = { 0x73, 0x74, 0x72, 0x74 };
    // 73 74 72 74
    for (int i = 0; i < 4; ++i)
    {
        receive_byte();
        /* Wait for IO completion... */
        while (_io_status == IO_RECEIVING);
        if (_io_status == IO_ERROR) {
            printf("i/o error!\n");
            break;
        }
        if (_io_in == start[i]) {
            printf("%c", _io_in);
        }
    }
    printf("\n"); 
}

void send_data_str() 
{
    for (int i = 0; i < 0x20; ++i)
    {
        _io_out = test_data_str[i];
        send_byte();
        while(_io_status == IO_SENDING);
        if (_io_status == IO_ERROR) {
            printf("i/o error!\n");
            break;
        }
        if (test_data_str[i] == 0x20) {
            printf("\n");
        } else {
            printf("%c", test_data_str[i]);
        }
        delay(100);
    }
    printf("\n"); 
}


void main(void)
{
    // Loop forever
    while(1) {
        cls();
        printf("waiting for init\n");
        wait_for_start();
        printf("received init!\nsending big string\n");
        delay(100);
        send_data_str();
        delay(5000);
        wait_vbl_done();
    }
}
