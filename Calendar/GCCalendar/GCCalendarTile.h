//
//  GCCalendarTile.h
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GCCalendarEvent;

/*
 A GCCalendarTile draws itself using data in the event passed to it.
 
 Each tile posts a notification whenever a touch ends inside its frame.
 */
@interface GCCalendarTile : UIView {
	// event title label
	UILabel *titleLabel;
	// event description label
	UILabel *descriptionLabel;
	
	// view containing stretchable image
	UIImageView *backgroundView;
	
	// event from which to draw tile
	GCCalendarEvent *event;
}

@property (nonatomic, retain) GCCalendarEvent *event;

@end
