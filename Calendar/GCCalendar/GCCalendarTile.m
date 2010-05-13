//
//  GCCalendarTile.m
//  GCCalendar
//
//	GUI Cocoa Common Code Library
//
//  Created by Caleb Davenport on 1/23/10.
//  Copyright GUI Cocoa Software 2010. All rights reserved.
//

#import "GCCalendarTile.h"
#import "GCCalendarEvent.h"
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
		descriptionLabel.lineBreakMode = UILineBreakModeWordWrap;
		descriptionLabel.numberOfLines = 0;
		
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
		descriptionLabel.frame = CGRectMake(6,
											titleLabel.frame.size.height + 2,
											myBounds.size.width - 12,
											myBounds.size.height - 14 - titleLabel.frame.size.height);
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
	
	if ([self pointInside:[touch locationInView:self] withEvent:nil]) {
		[self touchesCancelled:touches withEvent:e];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:__GCCalendarTileTouchNotification
															object:self];
	}
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)e {
	// show touch-end state
}

@end
