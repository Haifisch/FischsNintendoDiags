#include <nds.h>
#include <stdio.h>
#include "rtctime.h"

const char* months[12] = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
const char* weekDays[7] = {"Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"};

const u16 daysAtStartOfMonthLUT[12] =
{
	0	%7, //januari		31
	31	%7, //februari		28+1(leap year)
	59	%7, //maart			31
	90	%7, //april			30
	120	%7, //mei			31
	151	%7, //juni			30
	181	%7, //juli			31
	212	%7, //augustus		31
	243	%7, //september		30
	273	%7, //oktober		31
	304	%7, //november		30
	334	%7  //december		31
};

#define isLeapYear(year) (((year)%4) == 0)

uint getDayOfWeek(uint day, uint month, uint year)
{
	//http://en.wikipedia.org/wiki/Calculating_the_day_of_the_week

	day += 2*(3-((year/100)%4));
	year %= 100;
	day += year + (year/4);
	day += daysAtStartOfMonthLUT[month] - (isLeapYear(year) && (month <= 1));
	return day % 7;
}
