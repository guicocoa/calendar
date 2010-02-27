//
//  GCCalendar.m
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import "GCCalendar.h"

static NSArray *colors = nil;
static NSDateFormatter *dateFormatter = nil;
static NSDateFormatter *timeFormatter = nil;

@implementation GCCalendar

#pragma mark date utilities
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

#pragma mark date formatters
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

#pragma mark color list
+ (NSArray *)colors {
	if (colors == nil) {
		colors = [[NSArray arrayWithObjects:@"BLUE", @"GREEN", @"ORANGE", @"MAGENTA", @"PURPLE", @"RED", @"YELLOW", nil] retain];
	}
	
	return colors;
}

@end
