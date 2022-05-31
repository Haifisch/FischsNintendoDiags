#ifdef __cplusplus
extern "C" {
#endif

#ifndef __TIME_H__
#define __TIME_H__

extern const char* weekDays[7];
extern const char* months[12];

uint getDayOfWeek(uint day, uint month, uint year);

#endif

#ifdef __cplusplus
}
#endif