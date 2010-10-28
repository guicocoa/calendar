//
//  GCCalendarPortraitView.m
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import "GCCalendarPortraitView.h"
#import "GCCalendarDayView.h"
#import "GCCalendarTile.h"
#import "GCDatePickerControl.h"
#import "GCCalendar.h"

#define kAnimationDuration 0.3f

@interface GCCalendarPortraitView ()
@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) GCCalendarDayView *dayView;

- (void)reloadDayAnimated:(BOOL)animated context:(void *)context;
@end

@implementation GCCalendarPortraitView

@synthesize date, dayView, hasAddButton;

#pragma mark create and destroy view
- (id)init {
	if(self = [super init]) {
		self.title = [[NSBundle mainBundle] localizedStringForKey:@"CALENDAR" value:@"" table:@"GCCalendar"];
		self.tabBarItem.image = [UIImage imageNamed:@"Calendar.png"];
		
		viewDirty = YES;
		viewVisible = NO;
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(calendarTileTouch:)
													 name:__GCCalendarTileTouchNotification
												   object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(calendarShouldReload:)
													 name:GCCalendarShouldReloadNotification
												   object:nil];
	}
	
	return self;
}
- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	self.date = nil;
	self.dayView = nil;
	
	[dayPicker release];
	
	[super dealloc];
}

#pragma mark calendar actions
- (void)calendarShouldReload:(NSNotification *)notif {
	viewDirty = YES;
}
- (void)calendarTileTouch:(NSNotification *)notif {
	if (delegate != nil) {
		GCCalendarTile *tile = [notif object];
		[delegate calendarTileTouchedInView:self withEvent:[tile event]];
	}
}

#pragma mark GCDatePickerControl actions
- (void)datePickerDidChangeDate:(GCDatePickerControl *)picker {
	NSTimeInterval interval = [date timeIntervalSinceDate:picker.date];
	
	self.date = picker.date;
	
	[[NSUserDefaults standardUserDefaults] setObject:date forKey:@"GCCalendarDate"];
	
	[self reloadDayAnimated:YES context:[NSNumber numberWithInt:interval]];
}

#pragma mark button actions
- (void)today {
	dayPicker.date = [NSDate date];
	
	self.date = dayPicker.date;
	
	[[NSUserDefaults standardUserDefaults] setObject:date forKey:@"GCCalendarDate"];
	
	[self reloadDayAnimated:NO context:NULL];
}
- (void)add {
	if (delegate != nil) {
		[delegate calendarViewAddButtonPressed:self];
	}
}

#pragma mark custom setters
- (void)setHasAddButton:(BOOL)b {
	hasAddButton = b;
	
	if (hasAddButton) {
		UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																				target:self
																				action:@selector(add)];
		self.navigationItem.rightBarButtonItem = button;
		[button release];
	}
	else {
		self.navigationItem.rightBarButtonItem = nil;
	}
}

#pragma mark view notifications
- (void)loadView {
	[super loadView];
	
	self.date = [[NSUserDefaults standardUserDefaults] objectForKey:@"GCCalendarDate"];
	if (date == nil) {
		self.date = [NSDate date];
	}
	
	// setup day picker
	dayPicker = [[GCDatePickerControl alloc] init];
	dayPicker.frame = CGRectMake(0, 0, self.view.frame.size.width, 0);
	dayPicker.autoresizingMask = UIViewAutoresizingNone;
	dayPicker.date = date;
	[dayPicker addTarget:self action:@selector(datePickerDidChangeDate:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:dayPicker];
	
	// setup initial day view
	dayView = [[GCCalendarDayView alloc] initWithCalendarView:self];
	dayView.frame = CGRectMake(0,
							   dayPicker.frame.size.height,
							   self.view.frame.size.width,
							   self.view.frame.size.height - dayPicker.frame.size.height);
	dayView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	[self.view addSubview:dayView];
	
	// setup today button
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:[[NSBundle mainBundle] localizedStringForKey:@"TODAY" value:@"" table:@"GCCalendar"]
															   style:UIBarButtonItemStylePlain
															  target:self 
															  action:@selector(today)];
	self.navigationItem.leftBarButtonItem = button;
	[button release];
}
- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	if (viewDirty) {
		[self reloadDayAnimated:NO context:NULL];
		viewDirty = NO;
	}
	
	viewVisible = YES;
}
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	viewVisible = NO;
}

#pragma mark view animation functions
- (void)reloadDayAnimated:(BOOL)animated context:(void *)context {
	if (animated) {
		NSTimeInterval interval = [(NSNumber *)context doubleValue];
		
		// block user interaction
		dayPicker.userInteractionEnabled = NO;
		
		// setup next day view
		GCCalendarDayView *nextDayView = [[GCCalendarDayView alloc] initWithCalendarView:self];
		CGRect initialFrame = dayView.frame;
		if (interval < 0) {
			initialFrame.origin.x = initialFrame.size.width;
		}
		else if (interval > 0) {
			initialFrame.origin.x = 0 - initialFrame.size.width;
		}
		else {
			[nextDayView release];
			return;
		}
		nextDayView.frame = initialFrame;
		nextDayView.date = date;
		[nextDayView reloadData];
		nextDayView.contentOffset = dayView.contentOffset;

		[self.view addSubview:nextDayView];
		
		[UIView beginAnimations:nil context:nextDayView];
		[UIView setAnimationDuration:kAnimationDuration];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
		CGRect finalFrame = dayView.frame;
		if(interval < 0) {
			finalFrame.origin.x = 0 - finalFrame.size.width;
		} else if(interval > 0) {
			finalFrame.origin.x = finalFrame.size.width;
		}
		nextDayView.frame = dayView.frame;
		dayView.frame = finalFrame;
		[UIView commitAnimations];
	}
	else {
		CGPoint contentOffset = dayView.contentOffset;
		dayView.date = date;
		[dayView reloadData];
		dayView.contentOffset = contentOffset;
	}
}
- (void)animationDidStop:(NSString *)animationID 
				finished:(NSNumber *)finished 
				 context:(void *)context {
	
	GCCalendarDayView *nextDayView = (GCCalendarDayView *)context;
	
	// cut variables
	[dayView removeFromSuperview];
	
	// reassign variables
	self.dayView = nextDayView;
	
	// release pointers
	[nextDayView release];
	
	// reset pickers
	dayPicker.userInteractionEnabled = YES;
}

@end
