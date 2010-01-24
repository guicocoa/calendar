/*
 Copyright (c) 2010 Caleb Davenport
 
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

#import "GCCalendar.h"

static NSArray *colors;
static NSDateFormatter *dateFormatter;
static NSDateFormatter *timeFormatter;
static id<GCCalendarDataSource> dataSource;

@implementation GCCalendar

#pragma mark utility methods
+ (BOOL)dateIsToday:(NSDate *)date {
	NSDateComponents *components = nil;
	
	components = [[NSCalendar currentCalendar] components:
				  (NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
												 fromDate:[NSDate date]];
	NSInteger todayWeekday = [components weekday];
	NSInteger todayMonth = [components month];
	NSInteger todayYear = [components year];
	NSInteger todayDay = [components day];
	
	components = [[NSCalendar currentCalendar] components:
				  (NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
												 fromDate:date];
	NSInteger dateWeekday = [components weekday];
	NSInteger dateMonth = [components month];
	NSInteger dateYear = [components year];
	NSInteger dateDay = [components day];
	
	return (todayWeekday == dateWeekday &&
			todayMonth == dateMonth &&
			todayYear == dateYear &&
			todayDay == dateDay);
}
+ (NSDateFormatter *)dateFormatter {
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
		[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	}
	
	return dateFormatter;
}
+ (NSDateFormatter *)timeFormatter {
	if (timeFormatter == nil) {
		timeFormatter = [[NSDateFormatter alloc] init];
		[timeFormatter setDateStyle:NSDateFormatterNoStyle];
		[timeFormatter setTimeStyle:NSDateFormatterShortStyle];
	}
	
	return timeFormatter;
}
+ (NSArray *)colors {
	if (colors == nil) {
		colors = [[NSArray arrayWithObjects:@"BLUE", @"GREEN", @"ORANGE", @"MAGENTA", @"PURPLE", @"RED", @"YELLOW", nil] retain];
	}
	
	return colors;
}

#pragma mark delegate call
+ (void)setDataSource:(id<GCCalendarDataSource>)source {
	dataSource = source;
}
+ (id<GCCalendarDataSource>)dataSource {
	return dataSource;
}
+ (NSArray *)calendarEventsForDate:(NSDate *)date {
	if (dataSource != nil) {
		return [dataSource calendarEventsForDate:date];
	}
	
	return nil;
}

@end
