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

@interface Level13 : CCLayer
{
	CGSize size;
	ALuint instructionSoundID;
	NSMutableArray *spriteToChoose;
	NSInteger numberofIterations;
	NSDictionary *levelItems;
	
	NSInteger randNumberIndex1;
	
	NSMutableArray *spriteNumbers;
	NSMutableArray *pickedNumbers;
	
	BOOL foundNumber;
	BOOL touchedObject;

	BOOL gameHasStarted;
	BOOL pausePagePresent;
}
+(id) scene;

-(void) playNumberSound;
-(void) startPlaying;

@end
