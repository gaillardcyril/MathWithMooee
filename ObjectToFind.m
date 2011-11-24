//
//  ObjectToFind.m
//  FrenchieTeachieObjects
//
//  Created by Cyril Gaillard on 29/09/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "ObjectToFind.h"


@implementation ObjectToFind
@synthesize emitter;

- (CGRect)rect
{
	CGSize s = [self.texture contentSize];
	return CGRectMake(-s.width / 2, -s.height / 2, s.width, s.height);
}

- (void)onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:self.tag swallowsTouches:YES];
	[super onEnter];
	disableTouch=YES;
}

- (void)onExit
{
	//NSLog(@"I am leaving object");
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}	

-(void)dealloc
{
	//NSLog(@"I am leaving object");
	[super dealloc];
}

- (BOOL)containsTouchLocation:(UITouch *)touch
{
	return CGRectContainsPoint(self.rect, [self convertTouchToNodeSpaceAR:touch]);
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	//CCLOG(@"something got touched");
	if (disableTouch) {		
		NSLog(@"item disabled");
		//NSLog(@"item touched Tag %d",self.tag);
		return NO;		
	}

	if ( ![self containsTouchLocation:touch] )	
	{	NSLog(@" you touched something but not an object");	
		isTouched = NO;
		return NO;
	}		
	NSLog(@" you touched  an object");
	isTouched = YES;
	return YES;
}

- (void)disableTouch:(BOOL)disable
{
	disableTouch = disable;
	//NSLog(@"disabling objects");
}


-(BOOL) objectHasBeenFound:(NSInteger)objectTag
{
	if ((objectTag == self.tag) && isTouched)
	{
		NSLog(@"You touched the object %d",objectTag);
		isTouched = NO;
		//self.visible = NO;
		return YES;
		
	}
	return NO;
}
-(CGPoint) objectPosition
{
	return self.position;
}
-(BOOL) objectHasBeenTouched
{
	return isTouched;
}
-(void)touchAcknowledge
{
	isTouched = NO;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
	//isTouched = NO;
}

@end
