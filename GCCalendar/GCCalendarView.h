//
//  GCCalendarView.h
//  iBeautify
//
//  Created by Caleb Davenport on 2/27/10.
//  Copyright 2010 GUI Cocoa Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GCCalendarProtocols.h"

@interface GCCalendarView : UIViewController {
	// data source
	id<GCCalendarDataSource> dataSource;
	
	// delegate
	id<GCCalendarDelegate> delegate;
}

@property (nonatomic, assign) id<GCCalendarDataSource> dataSource;
@property (nonatomic, assign) id<GCCalendarDelegate> delegate;

@end
