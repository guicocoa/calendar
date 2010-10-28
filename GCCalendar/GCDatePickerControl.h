//
//  GCDatePickerControl.h
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

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
