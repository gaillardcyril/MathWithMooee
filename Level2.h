//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface Level2 : CCLayer
{	
	CGSize size;
	BOOL pausePagePresent;
	BOOL gameHasStarted;
	ALuint instructionSoundID;
	NSDictionary *levelItems;
	NSMutableArray *numberToFindArray;
	NSInteger numberofIterations;
	NSInteger currentNumberIndex;
    CCMenu *numberMenu;
	BOOL foundCurrentObject;
	BOOL touchedObject;
	NSMutableArray *pickedNumbers;
	ALuint correctSpriteSoundID;

}

+(id) scene;
-(void) loadObjectsToFind;
-(void) startPlaying;
-(void) playNumberSound;

@property(nonatomic,retain) NSMutableArray *numberToFindArray;
@property(nonatomic,retain) NSMutableArray *pickedNumbers;
@end
