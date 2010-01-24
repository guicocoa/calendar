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

#define kTileLeftSide 52.0f
#define kTileRightSide 10.0f

#define kTopLineBuffer 11.0
#define kSideLineBuffer 50.0
#define kHalfHourDiff 22.0

static NSArray *timeStrings;

@interface GCCalendarAllDayView : UIView {
	NSArray *events;
}

- (id)initWithEvents:(NSArray *)a;
- (BOOL)hasEvents;

@end

@implementation GCCalendarAllDayView
- (id)initWithEvents:(NSArray *)a {
	if (self = [super init]) {
		NSPredicate *pred = [NSPredicate predicateWithFormat:@"allDayEvent == YES"];
		events = [[a filteredArrayUsingPredicate:pred] retain];
		
		NSInteger eventCount = 0;
		for (GCCalendarEvent *e in events) {
			if (eventCount < 5) {
				GCCalendarTile *tile = [[GCCalendarTile alloc] init];
				tile.event = e;
				[self addSubview:tile];
				[tile release];
				
				eventCount++;
			}
		}
	}
	
	return self;
}
- (void)dealloc {
	[events release];
	events = nil;
	
	[super dealloc];
}
- (BOOL)hasEvents {
	return ([events count] != 0);
}
- (CGSize)sizeThatFits:(CGSize)size {
	CGSize toReturn = CGSizeMake(0, 0);
	
	if ([self hasEvents]) {
		NSInteger eventsCount = ([events count] > 5) ? 5 : [events count];
		toReturn.height = (5 * 2) + (27 * eventsCount) + (eventsCount - 1);
	}
	
	return toReturn;
}
- (void)layoutSubviews {
	CGFloat start_y = 5.0f;
	CGFloat height = 27.0f;
	
	for (UIView *view in self.subviews) {
		// get calendar tile and associated event
		GCCalendarTile *tile = (GCCalendarTile *)view;
		
		tile.frame = CGRectMake(kTileLeftSide,
								start_y,
								self.frame.size.width - kTileLeftSide - kTileRightSide,
								height);
		
		start_y += (height + 1);
	}
}
- (void)drawRect:(CGRect)rect {
	// grab current graphics context
	CGContextRef g = UIGraphicsGetCurrentContext();
	
	// fill white background
	CGContextSetRGBFillColor(g, 1.0, 1.0, 1.0, 1.0);
	CGContextFillRect(g, self.frame);
	
	// draw border line
	CGContextMoveToPoint(g, 0, self.frame.size.height);
	CGContextAddLineToPoint(g, self.frame.size.width, self.frame.size.height);
	
	// draw all day text
	UIFont *numberFont = [UIFont boldSystemFontOfSize:12.0];
	[[UIColor blackColor] set];
	NSString *text = [[NSBundle mainBundle] localizedStringForKey:@"ALL_DAY" value:@"" table:@"GCCalendar"];
	CGRect textRect = CGRectMake(6, 10, 40, [text sizeWithFont:numberFont].height);
	[text drawInRect:textRect withFont:numberFont];
	
	// stroke the path
	CGContextStrokePath(g);
}
@end

@interface GCCalendarTodayView : UIView {
	NSArray *events;
}

- (id)initWithEvents:(NSArray *)a;
- (BOOL)hasEvents;

@end

@implementation GCCalendarTodayView
- (id)initWithEvents:(NSArray *)a {
	if (self = [super init]) {
		NSPredicate *pred = [NSPredicate predicateWithFormat:@"allDayEvent == NO"];
		events = [[a filteredArrayUsingPredicate:pred] retain];
		
		for (GCCalendarEvent *e in events) {
			GCCalendarTile *tile = [[GCCalendarTile alloc] init];
			tile.event = e;
			[self addSubview:tile];
			[tile release];
		}
	}
	
	return self;
}
- (BOOL)hasEvents {
	return ([events count] != 0);
}
- (void)dealloc {
	[events release];
	events = nil;
	
	[super dealloc];
}
- (void)layoutSubviews {
	for (UIView *view in self.subviews) {
		// get calendar tile and associated event
		GCCalendarTile *tile = (GCCalendarTile *)view;
		
		NSDateComponents *components;
		components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | 
															   NSMinuteCalendarUnit) 
													 fromDate:tile.event.startDate];
		NSInteger startHour = [components hour];
		NSInteger startMinute = [components minute];
		
		components = [[NSCalendar currentCalendar] components:(NSHourCalendarUnit | 
															   NSMinuteCalendarUnit) 
													 fromDate:tile.event.endDate];
		NSInteger endHour = [components hour];
		NSInteger endMinute = [components minute];
		
		CGFloat startPos = kTopLineBuffer + startHour * 2 * kHalfHourDiff - 2;
		startPos += (startMinute / 60.0) * (kHalfHourDiff * 2.0);
		startPos = floor(startPos);
		
		CGFloat endPos = kTopLineBuffer + endHour * 2 * kHalfHourDiff + 3;
		endPos += (endMinute / 60.0) * (kHalfHourDiff * 2.0);
		endPos = floor(endPos);
		
		tile.frame = CGRectMake(kTileLeftSide, 
								startPos, 
								self.bounds.size.width - kTileLeftSide - kTileRightSide,
								endPos - startPos);
	}
}
- (void)drawRect:(CGRect)rect {
    // grab current graphics context
	CGContextRef g = UIGraphicsGetCurrentContext();
	
	// fill white background
	CGContextSetRGBFillColor(g, 1.0, 1.0, 1.0, 1.0);
	CGContextFillRect(g, self.frame);
	
	// set starting location
	CGFloat y_val = kTopLineBuffer - kHalfHourDiff;
	
	// setup text variables
	UIFont *numberFont = [UIFont boldSystemFontOfSize:14.0];
	UIFont *textFont = [UIFont systemFontOfSize:12.0];
	CGSize numberSize;
	CGSize textSize;
	
	for(int i = 0; i < 49; i++) {
		// calculate y vals based on current hour
		y_val += kHalfHourDiff;
		
		// if i represents an hour
		if(i % 2 == 0) {
			CGContextSetShouldAntialias(g, YES);
			
			// draw text string
			NSString *text = nil;
			// AM
			if(i < 24 || i == 48) {
				text = @"AM";
			}
			// PM
			else if(i > 24 && i < 48) {
				text = @"PM";
			}
			
			if(text != nil) {
				textSize = [text sizeWithFont:textFont];
				[[UIColor grayColor] set];
				[text drawInRect:CGRectMake(kSideLineBuffer - 7 - textSize.width,
											y_val - (textSize.height / 2),
											textSize.width, 
											textSize.height)
						withFont:textFont];
			}
			
			// draw time string
			NSInteger arrayIndex = i / 2;
			NSString *number = [timeStrings objectAtIndex:arrayIndex];
			numberSize = [number sizeWithFont:numberFont];
			[[UIColor blackColor] set];
			if(i == 24) {
				[number drawInRect:CGRectMake(kSideLineBuffer - 7 - numberSize.width, 
											  y_val - floor(numberSize.height / 2) - 1,
											  numberSize.width,
											  numberSize.height)
						  withFont:numberFont
					 lineBreakMode:UILineBreakModeTailTruncation
						 alignment:UITextAlignmentRight];
			} else {
				[number drawInRect:CGRectMake(0, 
											  y_val - floor(numberSize.height / 2) - 1,
											  kSideLineBuffer - textSize.width - 10,
											  numberSize.height)
						  withFont:numberFont
					 lineBreakMode:UILineBreakModeTailTruncation
						 alignment:UITextAlignmentRight];
			}
			
			// draw hour line
			CGContextSetShouldAntialias(g, NO);
			CGContextSetRGBStrokeColor(g, 0.0, 0.0, 0.0, .3);
			const CGFloat pattern[2] = {1.0, 0.0};
			CGContextSetLineDash(g, 0, pattern, 2);
		}
		else {
			// draw half hour line
			CGContextSetRGBStrokeColor(g, 0.0, 0.0, 0.0, .2);
			
			const CGFloat pattern[2] = {1.0, 1.0};
			CGContextSetLineDash(g, 0, pattern, 2);
		}
		
		// set path origin
		CGContextMoveToPoint(g, kSideLineBuffer, y_val);
		
		// set path end point
		CGContextAddLineToPoint(g, self.frame.size.width, y_val);
		
		// stroke the path
		CGContextStrokePath(g);
	}
}
@end

@implementation GCCalendarDayView

@synthesize date;

#pragma mark create and destroy view
+ (void)initialize {
	if(self == [GCCalendarDayView class]) {
		timeStrings = [[NSArray arrayWithObjects:@"12",
						@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11",
						[[NSBundle mainBundle] localizedStringForKey:@"NOON" value:@"" table:@"GCCalendar"],
						@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", nil]
					   retain];
	}
}
- (void)dealloc {
	self.date = nil;
	
    [super dealloc];
}
- (void)reloadData {
	// get new events for date
	events = [GCCalendar calendarEventsForDate:date];
	
	// drop all subviews
	[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[allDayView release];
	[todayView release];
	[scrollView release];
	
	// create all day view
	allDayView = [[GCCalendarAllDayView alloc] initWithEvents:events];
	[allDayView sizeToFit];
	allDayView.frame = CGRectMake(0, 0, self.frame.size.width, allDayView.frame.size.height);
	allDayView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self addSubview:(UIView *)allDayView];
	
	// create scroll view
	scrollView = [[UIScrollView alloc] init];
	scrollView.frame = CGRectMake(0, allDayView.frame.size.height, self.frame.size.width,
								  self.frame.size.height - allDayView.frame.size.height);
	scrollView.contentSize = CGSizeMake(self.frame.size.width, 1078);
	scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	[self addSubview:scrollView];
	
	// create today view
	todayView = [[GCCalendarTodayView alloc] initWithEvents:events];
	todayView.frame = CGRectMake(0, 0, self.frame.size.width, 1078);
	todayView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[scrollView addSubview:todayView];
}
- (void)setContentOffset:(CGPoint)p {
	scrollView.contentOffset = p;
}
- (CGPoint)contentOffset {
	return scrollView.contentOffset;
}

@end
