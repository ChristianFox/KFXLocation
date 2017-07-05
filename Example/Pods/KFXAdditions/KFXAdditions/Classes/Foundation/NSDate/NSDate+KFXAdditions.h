/********************************
 *
 * Copyright © 2016-2017 Christian Fox
 * All Rights Reserved
 * Full licence details can be found in the file 'LICENSE' or in the Pods-{yourProjectName}-acknowledgements.markdown
 *
 * This file is included with KFXAdditions
 *
 ************************************/
/****************
 * # Some code ripped from:
 * - https://github.com/Daij-Djan/DDCalendarView
 * - http://stackoverflow.com/questions/4739483/number-of-days-between-two-nsdates#4739650
 * - http://stackoverflow.com/questions/8087900/how-to-retrieve-number-of-hours-past-midnight-from-an-nsdate-object
 ****************/
 

#import <Foundation/Foundation.h>

@interface NSDate (KFXAdditions)

//--------------------------------------------------------
#pragma mark - Comparison Convience methods
//--------------------------------------------------------
-(BOOL)kfx_isEarlierThanDate:(NSDate*)anotherDate;
-(BOOL)kfx_isLaterThanDate:(NSDate*)anotherDate;
-(BOOL)kfx_isEarlierThanOrEqualToDate:(NSDate*)anotherDate;
-(BOOL)kfx_isLaterThanOrEqualToDate:(NSDate*)anotherDate;
-(BOOL)kfx_isBetweenStartDate:(NSDate*)startDate andEndDate:(NSDate*)endDate;


//--------------------------------------------------------
#pragma mark - Equality
//--------------------------------------------------------
-(BOOL)kfx_isDayEqualToDate:(NSDate*)anotherDate;
-(BOOL)kfx_isHourEqualToDate:(NSDate*)anotherDate;
-(BOOL)kfx_isMinuteEqualToDate:(NSDate*)anotherDate;
-(BOOL)kfx_isTimeEqualToDate:(NSDate*)anotherDate;


//--------------------------------------------------------
#pragma mark - Components/difference between dates
//--------------------------------------------------------
/// If the receiver is earlier than the otherDate then the return value will be negative.
-(NSInteger)kfx_daysSinceDate:(NSDate*)otherDate
  includeCurrentIncompleteDay:(BOOL)includeToday;

/// If the receiver is earlier than the otherDate then the return value will be negative.
-(NSInteger)kfx_hoursSinceDate:(NSDate*)otherDate
  includeCurrentIncompleteHour:(BOOL)includeToday;

/// Returns the number of hours since midnight of the receiver's date
-(NSInteger)hoursSinceMidnight;



//--------------------------------------------------------
#pragma mark - Components
//--------------------------------------------------------
-(NSDateComponents*)kfx_currentCalendarDateComponents;




@end
