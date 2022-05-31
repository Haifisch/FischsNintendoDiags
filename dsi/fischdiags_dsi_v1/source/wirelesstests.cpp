#include <nds.h>
#include <stdio.h>
#include <dswifi9.h>
#include <sys/types.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <nds/debug.h>
#include <netdb.h>
#include "wirelesstests.h"
#include "testconfirmation.h"
#include "tiny-json.h"

//---------------------------------------------------------------------------------
void getHttp(char* url) {
//---------------------------------------------------------------------------------
	iprintf("\x1b[2J");
	iprintf("\x1b[0;0Hstarting httpget test\n");
	// store the HTTP request for later
	const char * request_text = 
		"GET /ip HTTP/1.1\r\n"
		"Host: ifconfig.io\r\n"
		"User-Agent: Nintendo DS\r\n\r\n";

	// Find the IP address of the server, with gethostbyname
	struct hostent * myhost = gethostbyname( url );
	//iprintf("Found IP Address!\n");
	// Create a TCP socket
	int my_socket;
	my_socket = socket( AF_INET, SOCK_STREAM, 0 );
	iprintf("\x1b[1;0Hcreated socket!\n");

	// Tell the socket to connect to the IP address we found, on port 80 (HTTP)
	struct sockaddr_in sain;
	sain.sin_family = AF_INET;
	sain.sin_port = htons(80);
	sain.sin_addr.s_addr = *((unsigned long *)(myhost->h_addr_list[0])); // inet_addr("10.16.0.10");
	connect( my_socket,(struct sockaddr *)&sain, sizeof(sain) );
	iprintf("\x1b[2;0Hconnected to server!\n");

	// send our request
	send( my_socket, request_text, strlen(request_text), 0 );
	iprintf("\x1b[3;0Hsent our request!\n");

	// Print incoming data
	//iprintf("Printing incoming data:\n");

	int recvd_len;
	char incoming_buffer[1024];

	while( ( recvd_len = recv( my_socket, incoming_buffer, 1023, 0 ) ) != 0 ) { 
		if (recvd_len > 0) {
			incoming_buffer[recvd_len] = 0; // null-terminate
			iprintf(incoming_buffer);
		}
	}
	//iprintf("\x1b[4;0H%s", incoming_buffer);
	iprintf("\n\nClosing socket...\n");
	shutdown(my_socket,0); 
	closesocket(my_socket); 
	/*
	iprintf("\x1b[10;2HAttempting to parse\n");
	enum { MAX_FIELDS = 4 };
	json_t pool[ MAX_FIELDS ];
	json_t const* parent = json_create( incoming_buffer, pool, MAX_FIELDS );
	if ( parent == NULL ) {
		iprintf("Failed to parse :(");
	}
	json_t const* ipField = json_getProperty( parent, "ip" );
	if ( ipField == NULL ) return;
	if ( json_getType( ipField ) != JSON_TEXT ) return;
	char const* namevalue = json_getValue( ipField );
	iprintf( "%s%s%s", "IP: '", namevalue, "'.\n" );
	*/
}


void scanWifiAPTest(void) {
	int i;
	int displaytop = 2;
	static Wifi_AccessPoint ap;
	Wifi_InitDefault(false);
	Wifi_ScanMode(); //this allows us to search for APs
	iprintf("\x1b[2J");
	for (int i = 0; i < 50; ++i)
	{
		//find out how many APs there are in the area
		int count = Wifi_GetNumAP();
		iprintf("\x1b[0;0HAP SCAN TEST");
		iprintf("\x1b[1;0H(%d detected)", count);
		int displayend = displaytop + 20;
		if (displayend > count) displayend = count;
		//display the APs to the user
		for(i = displaytop; i < displayend; i++) {
			Wifi_AccessPoint ap;
			Wifi_GetAPData(i, &ap);
			// print ap info
			iprintf("\x1b[%i;0H%.29s WEP: %s Sig: %i", i, ap.ssid, ap.flags & WFLAG_APDATA_WEP ? "Yes " : "No ", ap.rssi * 100 / 0xD0);
		}
		swiWaitForVBlank();
		scanKeys();
		if (keysDown() & KEY_B) {
			break;
		}
	}
}

void connectToDefaultAPTest() {
	struct in_addr ip, gateway, mask, dns1, dns2;
	iprintf("\x1b[2J");
	iprintf("\x1b[0;0HConnecting via WFC data ...");
	Wifi_InitDefault(true);
	bool testCancel = false;
	bool gotConfiguration = false;
	int status = Wifi_AssocStatus();
	if (status != ASSOCSTATUS_ASSOCIATED) {
		Wifi_AutoConnect();
	} else if (status == ASSOCSTATUS_ASSOCIATED) {
		gotConfiguration = true;
	}
	int spinCount = 0;
	while(spinCount < 500 && gotConfiguration == false) {
		status = Wifi_AssocStatus();
		if (status == ASSOCSTATUS_CANNOTCONNECT) {
			iprintf("\x1b[6;0HFailed to connect!");
			break;
		} else if (status == ASSOCSTATUS_ASSOCIATED) {
			iprintf("\x1b[6;0HConnected");
			gotConfiguration = true;
			break;
		} else if (status == ASSOCSTATUS_SEARCHING) {
			iprintf("\x1b[2;0HSearching...");
		} else if (status == ASSOCSTATUS_AUTHENTICATING) {
			iprintf("\x1b[3;0HAuthenticating...");
		} else if (status == ASSOCSTATUS_ASSOCIATING) {
			iprintf("\x1b[4;0HAssociating...");
		} else if (status == ASSOCSTATUS_ACQUIRINGDHCP) {
			iprintf("\x1b[5;0HAcquiring DHCP...");
		}
		swiWaitForVBlank();
	}
	if (testCancel == false && gotConfiguration) 
	{
		ip = Wifi_GetIPInfo(&gateway, &mask, &dns1, &dns2);
		iprintf("\x1b[8;0Hip      : %s", inet_ntoa(ip));
		iprintf("\x1b[9;0Hgateway : %s", inet_ntoa(gateway) );
		iprintf("\x1b[10;0Hmask   : %s", inet_ntoa(mask) );
		iprintf("\x1b[11;0Hdns1   : %s", inet_ntoa(dns1) );
		iprintf("\x1b[12;0Hdns2   : %s", inet_ntoa(dns2) );
		iprintf("\x1b[16;0HPress any key to continue");
		while(!keysDown()) {		
			swiWaitForVBlank();
			scanKeys();
		}
		getHttp("ifconfig.io");
	}
	//Wifi_DisconnectAP();
}

int wireless_scan_test_begin(void) 
{
	videoSetModeSub(MODE_0_2D);
	vramSetBankC(VRAM_C_SUB_BG);
	lcdMainOnTop();
	//consoleDemoInit();
	consoleInit(NULL, 0, BgType_Text4bpp, BgSize_T_256x256, 2, 0, false, true);
	Wifi_Init(WIFIINIT_OPTION_USELED);
	scanWifiAPTest();
	iprintf("\x1b[17;0HWireless test done...");
	iprintf("\x1b[18;0HPress B to return.");
	while(!keysDown()) {		
		swiWaitForVBlank();
		scanKeys();
	}
	return 0;
}

int wireless_defaultconnect_test_begin(void) 
{
	videoSetModeSub(MODE_0_2D);
	vramSetBankC(VRAM_C_SUB_BG);
	lcdMainOnTop();
	//consoleDemoInit();
	consoleInit(NULL, 0, BgType_Text4bpp, BgSize_T_256x256, 2, 0, false, true);
	Wifi_Init(WIFIINIT_OPTION_USELED);
	connectToDefaultAPTest();
	iprintf("\x1b[17;0HWireless test done...");
	iprintf("\x1b[18;0HPress B to return.");
	while(1) {
		//scanWifiAPTest();
		swiWaitForVBlank();
		scanKeys();
		if(keysDown() & KEY_B) {
			break;
		}
	}
	return 0;
}