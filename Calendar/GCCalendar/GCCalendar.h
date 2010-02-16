//
//  GCCalendar.h
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GCCalendarEvent.h"
#import "GCCalendarTile.h"
#import "GCCalendarDayView.h"
#import "GCDatePickerControl.h"
#import "GCCalendarPortraitView.h";

// calendar notificaions
static NSString * const GCCalendarTileTouchNotification = @"GCCalendarTileTouch";
static NSString * const GCCalendarShouldReloadNotification = @"GCCalendarShouldReload";

@protocol GCCalendarDataSource <NSObject>
@required
- (NSArray *)calendarEventsForDate:(NSDate *)date;
@end


/*
 GCCalendar provides several key utility methods, as well as a centralized
 calendar imports location.  The notable function of this class is the
 calendarEventsForDate: method which creates an array of GCCalendarEvent
 objects which will be displayed by the calendar interface.
 */
@interface GCCalendar : NSObject {
	
}

// asks if a given date is today by comparing day, month, and year values
+ (BOOL)dateIsToday:(NSDate *)date;
// returns a single date formatter with a "medium" date style
+ (NSDateFormatter *)dateFormatter;
// returns a single time formatter with a "short" time style
+ (NSDateFormatter *)timeFormatter;
// returns a list of supported calendar event colors
+ (NSArray *)colors;
/*
 returns an array of calendar events
 
 this method is called by GCCalendarDay as part of its reloadData function.
 the date to be displayed is passed so that data for the appropriate date can
 be converted into events
 
 this method call is simply forwarded to the data source of this class
 */
+ (NSArray *)calendarEventsForDate:(NSDate *)date;
// sets the data source
+ (void)setDataSource:(id<GCCalendarDataSource>)source;
// gets the data source
+ (id<GCCalendarDataSource>)dataSource;

@end
