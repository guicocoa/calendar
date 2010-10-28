//
//  GCCalendar.h
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCCalendarView.h"
#import "GCCalendarEvent.h"
#import "GCCalendarProtocols.h"
#import "GCCalendarPortraitView.h"

// calendar notificaions
static NSString * const GCCalendarShouldReloadNotification = @"GCCalendarShouldReload";

// private notifications
static NSString * const __GCCalendarTileTouchNotification = @"__GCCalendarTileTouchNotification";

/*
 GCCalendar provides several key utility methods, as well as a centralized
 calendar imports location.  The notable function of this class is the
 calendarEventsForDate: method which creates an array of GCCalendarEvent
 objects which will be displayed by the calendar interface.
 */
@interface GCCalendar : NSObject {
	
}

#pragma mark date utilities
// asks if a given date is today by comparing day, month, and year values
+ (BOOL)dateIsToday:(NSDate *)date;

#pragma mark get date formatters
// returns a single date formatter with a "medium" date style
+ (NSDateFormatter *)dateFormatter;
// returns a single time formatter with a "short" time style
+ (NSDateFormatter *)timeFormatter;

#pragma mark color list
// returns a list of supported calendar event colors
+ (NSArray *)colors;

@end
