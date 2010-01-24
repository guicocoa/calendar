/*
 Copyright (c) 2009 Caleb Davenport
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GCCalendarEvent.h"
#import "GCCalendarTile.h"
#import "GCCalendarDayView.h"
#import "GCDatePickerControl.h"
#import "GCCalendarPortraitView.h";

// name of the notification passed from GCCalendarTile objects to the GCCalendarPortraitView
static NSString * const CGCalendarTileTouchNotification = @"GCCalendarTileTouch";

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
 */
+ (NSArray *)calendarEventsForDate:(NSDate *)date;

@end
