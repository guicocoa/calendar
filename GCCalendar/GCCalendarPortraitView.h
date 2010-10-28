//
//  GCCalendarPortraitView.h
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCCalendarView.h"

@class GCDatePickerControl;
@class GCCalendarDayView;

/*
 GCCalendarPortraitView defines the top-level view controller containing
 calendar events for a single day.  This view works best when placed in
 the stack of a navigation controller.  If no navigation controller is present,
 the "Today" button will not be available to the user.
 
 The most notable method inside this class is calendarTileTouch: which is called
 whenever a CGCalendarTileTouchNotification is posted to the default notification
 center.  Use the userInfo field of the event (not of the notification) to 
 push a detailed view controller onto the stack with more information about the
 event (currently unimplemnted)
 */
@interface GCCalendarPortraitView : GCCalendarView {
	// date the view will display
	NSDate *date;
	
	// control for changing the date
	GCDatePickerControl *dayPicker;
	
	// interface for displaying events
	GCCalendarDayView *dayView;
	
	// view has changed since last time on screen
	BOOL viewDirty;
	
	// view is on screen
	BOOL viewVisible;
	
	// add button
	BOOL hasAddButton;
}

@property (nonatomic, assign) BOOL hasAddButton;

@end
