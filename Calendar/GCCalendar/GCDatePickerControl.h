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

/*
 This UIControl subclass displays the mechanism for changing the currently
 displayed date.  When the date is changed by the user, an action is posted
 for the UIControlEventValueChanged event.  Setting the date through the
 date property causes the labels and label color to update accordingly.
 */
@interface GCDatePickerControl : UIControl {
	// the date to display
	NSDate *date;
	
	// button facing left
	UIButton *backButton;
	// button facing right
	UIButton *forwardButton;
	// label displaying the date
	UILabel *titleLabel;
	// is the value in date today
	BOOL today;
}

@property (nonatomic, retain) NSDate *date;

@end
