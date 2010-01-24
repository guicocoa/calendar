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
}

@property (nonatomic, retain) NSDate *date;
/*
 accessor methods for accessing the contentOffset of the scroll view.
 this is used to keep the scroll position the same from one day view
 to the next.
 */
@property (nonatomic) CGPoint contentOffset;

- (void)reloadData;

@end
