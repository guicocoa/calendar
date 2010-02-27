//
//  GCCalendarDayView.h
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCCalendarProtocols.h"

/*
 GCCalendarDayView is responsible for displaying all dalendar information
 for a single day.  It sets up the appropriate scroll view and all day
 view, lays out all calendar tiles, and draws the calendar grid
 background.
 */
@interface GCCalendarDayView : UIView {
	// view shown at the top of the calendar containing all day events
	UIView *allDayView;
	// view containing events that occur on the given date
	UIView *todayView;
	// adds scrolling function to the calendar
	UIScrollView *scrollView;
	// the date to show events from
	NSDate *date;
	// an array of events for this date
	NSArray *events;
	// data source
	id<GCCalendarDataSource> dataSource;
}

@property (nonatomic, retain) NSDate *date;
/*
 accessor methods for accessing the contentOffset of the scroll view.
 this is used to keep the scroll position the same from one day view
 to the next.
 */
@property (nonatomic) CGPoint contentOffset;

- (id)initWithCalendarView:(GCCalendarView *)view;
- (void)reloadData;

@end
