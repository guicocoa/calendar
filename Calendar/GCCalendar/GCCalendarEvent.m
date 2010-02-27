//
//  GCCalendarEvent.m
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import "GCCalendarEvent.h"

@implementation GCCalendarEvent

@synthesize eventName;
@synthesize eventDescription;
@synthesize startDate;
@synthesize endDate;
@synthesize allDayEvent;
@synthesize color;
@synthesize userInfo;

- (id)init {
	if (self = [super init]) {
		self.color = @"GREY";
	}
	
	return self;
}

- (void)dealloc {
	self.eventName = nil;
	self.eventDescription = nil;
	self.startDate = nil;
	self.endDate = nil;
	self.color = nil;
	
	[super dealloc];
}

@end
