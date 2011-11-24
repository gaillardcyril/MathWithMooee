//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ObjectToFind.h"

@interface Level14 : CCLayer
{
	CGSize size;
	BOOL pausePagePresent;
	NSInteger numberofIterations;
	NSDictionary *levelItems;
    NSMutableArray *spriteShape;
    NSInteger randNumberIndex1;
	BOOL gameHasStarted;
	ALuint instructionSoundID;
}
+(id) scene;
-(void) startPlaying;

@property(nonatomic,retain) NSMutableArray *spriteShape;


@end
