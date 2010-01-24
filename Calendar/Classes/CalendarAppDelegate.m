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

@end
