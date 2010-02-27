//
//  GCCalendarEvent.h
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 GCCalendarEvent is the model object that GCCalendarTiles use to
 draw themselves on the calendar interface.
 
 Event name and description show up as strings in the event tile.
 Start and end times determine the location and height of an event tile.
 Color must be a string from the array returned by [GCCalendar colors]
 All day event determines the placement of the event in the day view
 User Info can be used to store lookup data about the object an event
	represents.  Ex. in CoreData based applications, userInfo could be
	the objectID of a managed object.
 */
@interface GCCalendarEvent : NSObject {
	// name of the event
	NSString *eventName;
	// event description
	NSString *eventDescription;
	
	// start date
	NSDate *startDate;
	// end date
	NSDate *endDate;
	
	// color
	NSString *color;
	// is this an all day event
	BOOL allDayEvent;
	
	// contextual information
	id userInfo;
}

@property (nonatomic, copy) NSString *eventName;
@property (nonatomic, copy) NSString *eventDescription;
@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, retain) id userInfo;
@property (nonatomic) BOOL allDayEvent;

@end
