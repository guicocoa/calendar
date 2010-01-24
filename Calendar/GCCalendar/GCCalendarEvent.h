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

#import "GCCalendar.h"

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
