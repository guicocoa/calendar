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

@implementation GCCalendarTile

@synthesize event;

- (id)init {
	if (self = [super init]) {
		self.clipsToBounds = YES;
		self.userInteractionEnabled = YES;
		self.multipleTouchEnabled = NO;
		
		titleLabel = [[UILabel alloc] init];
		titleLabel.backgroundColor = [UIColor clearColor];
		titleLabel.textColor = [UIColor whiteColor];
		titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
		titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
		
		descriptionLabel = [[UILabel alloc] init];
		descriptionLabel.backgroundColor = [UIColor clearColor];
		descriptionLabel.textColor = [UIColor whiteColor];
		descriptionLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
		descriptionLabel.font = [UIFont systemFontOfSize:12.0f];
		
		backgroundView = [[UIImageView alloc] init];
		backgroundView.alpha = 0.90f;
		
		[self addSubview:backgroundView];
		[self addSubview:titleLabel];
		[self addSubview:descriptionLabel];
	}
	
	return self;
}
- (void)dealloc {
	self.event = nil;
	
	[super dealloc];
}
- (void)setEvent:(GCCalendarEvent *)e {
	[event release];
	event = e;
	[event retain];
	
	// set bg image
	NSString *colorString = [event.color capitalizedString];
	NSString *colorImageName = [NSString stringWithFormat:@"CalendarBubble%@.png", colorString];
	UIImage *bgImage = [UIImage imageNamed:colorImageName];
	backgroundView.image = [bgImage stretchableImageWithLeftCapWidth:6 topCapHeight:13];
	
	// set title
	titleLabel.text = event.eventName;
	descriptionLabel.text = event.eventDescription;
	
	[self setNeedsDisplay];
}
- (void)layoutSubviews {
	CGRect myBounds = self.bounds;
	
	backgroundView.frame = myBounds;
	
	CGSize stringSize = [titleLabel.text sizeWithFont:titleLabel.font];
	titleLabel.frame = CGRectMake(6,
								  3,
								  myBounds.size.width - 12,
								  stringSize.height);
	
	if (event.allDayEvent) {
		descriptionLabel.frame = CGRectZero;
	}
	else {
		stringSize = [descriptionLabel.text sizeWithFont:descriptionLabel.font];
		descriptionLabel.frame = CGRectMake(6,
											titleLabel.frame.size.height + 2,
											myBounds.size.width - 12,
											stringSize.height);
	}
}

#pragma mark touch handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)e {
	// show touch-began state
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)e {
	
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)e {
	UITouch *touch = [touches anyObject];
	
	if (CGRectContainsPoint(self.frame, [touch locationInView:self])) {
		[self touchesCancelled:touches withEvent:e];
		
		// perform click action
		[[NSNotificationCenter defaultCenter] postNotificationName:CGCalendarTileTouchNotification
															object:self];
	}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)e {
	// show touch-end state
}

@end
