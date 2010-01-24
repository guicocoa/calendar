//
//  CalendarAppDelegate.h
//  Calendar
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCCalendar.h"

@interface CalendarAppDelegate : NSObject <UIApplicationDelegate, GCCalendarDataSource> {
    UIWindow *window;
	UITabBarController *tabController;
}

@end

