//
//  ObjectToFind.h
//  FrenchieTeachieObjects
//
//  Created by Cyril Gaillard on 29/09/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ObjectToFind : CCSprite <CCTargetedTouchDelegate> {
	BOOL isTouched;
	BOOL disableTouch;

}
@property (readwrite,retain) CCParticleSystem *emitter;

-(BOOL) objectHasBeenFound:(NSInteger)objectTag;
-(BOOL) objectHasBeenTouched;
-(void) disableTouch:(BOOL)disable;
-(void) touchAcknowledge;
-(CGPoint) objectPosition;

@end
