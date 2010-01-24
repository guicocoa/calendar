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

@interface GCDatePickerControl ()
@property (nonatomic) BOOL today;
@end

@implementation GCDatePickerControl

@synthesize date, today;

#pragma mark create and destroy view
- (id)init {
	if(self = [super init]) {
		self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GCDatePickerControlBackground.png"]];
		
		// left button
		backButton = [[UIButton alloc] init];
		[backButton setImage:[UIImage imageNamed:@"GCDatePickerControlLeft.png"] forState:UIControlStateNormal];
		backButton.showsTouchWhenHighlighted = NO;
		backButton.adjustsImageWhenHighlighted = NO;
		[backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		// right button
		forwardButton = [[UIButton alloc] init];
		[forwardButton setImage:[UIImage imageNamed:@"GCDatePickerControlRight.png"] forState:UIControlStateNormal];
		forwardButton.showsTouchWhenHighlighted = NO;
		forwardButton.adjustsImageWhenHighlighted = NO;
		[forwardButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
		
		// label
		titleLabel = [[UILabel alloc] init];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.opaque = YES;
		titleLabel.textAlignment = UITextAlignmentCenter;
		titleLabel.shadowColor = [UIColor whiteColor];
		titleLabel.shadowOffset = CGSizeMake(0, 1);
		titleLabel.font = [UIFont boldSystemFontOfSize:20];
		
		[self addSubview:backButton];
		[self addSubview:forwardButton];
		[self addSubview:titleLabel];
		
		self.today = NO;
	}
	
	return self;
}
- (void)dealloc {
	[backButton release];
	backButton = nil;
	
	[forwardButton release];
	forwardButton = nil;
	
	[titleLabel release];
	titleLabel = nil;
	
	self.date = nil;
	
	[super dealloc];
}

#pragma mark view notifications
- (CGSize)sizeThatFits:(CGSize)size {
	return CGSizeMake(size.width, 45.0f);
}
- (void)layoutSubviews {
#define kButtonWidth 40
	[super layoutSubviews];
	
	CGRect tempFrame;
	
	tempFrame = CGRectMake(0, 0, kButtonWidth, 45);
	backButton.frame = tempFrame;
	
	tempFrame = CGRectMake(self.frame.size.width - kButtonWidth, 0, kButtonWidth, 45);
	forwardButton.frame = tempFrame;
	
	tempFrame = CGRectMake(kButtonWidth, 0, self.frame.size.width - (kButtonWidth * 2), 45);
	titleLabel.frame = tempFrame;
}

#pragma mark setters
- (void)setDate:(NSDate *)newDate {
	[date release];
	date = newDate;
	[date retain];
	
	self.today = [GCCalendar dateIsToday:date];
		
	NSDateComponents *comp = [[NSCalendar currentCalendar] components:
							  (NSWeekdayCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit)
															 fromDate:date];
	
	NSInteger weekday = [comp weekday];
	NSInteger month = [comp month];
	NSInteger year = [comp year];
	NSInteger day = [comp day];
	
	NSArray *weekdayStrings = [[GCCalendar dateFormatter] weekdaySymbols];
	NSArray *monthStrings = [[GCCalendar dateFormatter] shortMonthSymbols];
	
	NSString *toDisplay = [NSString stringWithFormat:@"%@ %@ %d %d", 
							[weekdayStrings objectAtIndex:weekday - 1],
							[monthStrings objectAtIndex:month - 1],
							day, year];
	titleLabel.text = toDisplay;
}
- (void)setFrame:(CGRect)newFrame {
	newFrame.size.height = 45;
	super.frame = newFrame;
	
	[self setNeedsLayout];
}
- (void)setToday:(BOOL)newToday {
	today = newToday;
	
	if(today) {
		titleLabel.textColor = [UIColor colorWithRed:0
											   green:(88.0/255.0)
												blue:(238.0/255.0)
											   alpha:1.0];
	} else {
		titleLabel.textColor = [UIColor colorWithRed:(48.0/255.0)
											   green:(65.0/255.0)
												blue:(84.0/255.0)
											   alpha:1.0];
	}
}

#pragma mark button actions
- (void)buttonPressed:(UIButton *)sender {
#define kSecondsInDay (60 * 60 * 24)
	if(sender == backButton) {
		NSDate *newDate = [[NSDate alloc] initWithTimeInterval:-kSecondsInDay sinceDate:date];
		self.date = newDate;
		[newDate release];
	} else if(sender == forwardButton) {
		NSDate *newDate = [[NSDate alloc] initWithTimeInterval:kSecondsInDay sinceDate:date];
		self.date = newDate;
		[newDate release];
	}
	
	[self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
