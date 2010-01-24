//
//  CalendarAppDelegate.m
//  Calendar
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import "CalendarAppDelegate.h"

#import "GCCalendar.h"

@implementation CalendarAppDelegate

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	// set calendar data source
	[GCCalendar setDataSource:self];
	
	// create calendar view
	GCCalendarPortraitView *calendar = [[[GCCalendarPortraitView alloc] init] autorelease];
	
	// create navigation view
	UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:calendar] autorelease];
	
	// create tab controller
	tabController = [[UITabBarController alloc] init];
	tabController.viewControllers = [NSArray arrayWithObject:nav];
	
	// setup window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window addSubview:tabController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
	window = nil;
	
	[tabController release];
	tabController = nil;
	
    [super dealloc];
}

#pragma mark calendar data source
- (NSArray *)calendarEventsForDate:(NSDate *)date {
	NSMutableArray *events = [NSMutableArray array];
	
	NSDateComponents *components = [[NSCalendar currentCalendar] components:
									(NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
																   fromDate:date];
	[components setSecond:0];
	
	// create 5 calendar events that aren't all day events
	for (NSInteger i = 0; i < 5; i++) {
		GCCalendarEvent *event = [[GCCalendarEvent alloc] init];
		event.color = [[GCCalendar colors] objectAtIndex:i];
		event.allDayEvent = NO;
		event.eventName = [event.color capitalizedString];
		event.eventDescription = event.eventName;
		
		[components setHour:12 + i];
		[components setMinute:0];
		
		event.startDate = [[NSCalendar currentCalendar] dateFromComponents:components];
		
		[components setMinute:50];
		
		event.endDate = [[NSCalendar currentCalendar] dateFromComponents:components];
		
		[events addObject:event];
		[event release];
	}
	
	// create an all day event
	GCCalendarEvent *event = [[GCCalendarEvent alloc] init];
	event.allDayEvent = YES;
	event.eventName = @"All Day Event";
	[events addObject:event];
	[event release];
	
	return events;
}

@end
