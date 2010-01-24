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

@class GCCalendarDayView;
@class GCDatePickerControl;

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
@interface GCCalendarPortraitView : UIViewController {
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
}

@end
