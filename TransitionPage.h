//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CurrentLevel.h"

@interface TransitionPage : CCLayer
{
	CurrentLevel *activeLevel ;
	NSInteger score;
	ALuint instructionsSoundId;

	
}
-(void) tellInstructions;
+(id) scene;

@end
