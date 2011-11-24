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

@interface Level5 : CCLayer
{	
	CGSize size;
	
	ALuint instructionSoundID;
	ALuint planeSoundId;
	ALuint correctSpriteSoundID;
	
	BOOL gameHasStarted;
	BOOL pausePagePresent;

	NSInteger numberofIterations;
	NSInteger currentNumberIndex;
	BOOL foundCurrentObject;
	BOOL touchedObject;
	NSMutableArray *pickedNumbers;
	NSMutableArray *movableDominos;
	CCSprite *selectedDomino;
	CCSprite *houseToFill;
    
    NSMutableArray *idxArray;
	
}

+(id) scene;
-(void) loadObjectsToFind;
-(void) findTouchedDomino:(CGPoint)touchLocation;
-(void) moveSelectedDomino:(CGPoint)translation;
-(void) startPlaying;
-(void) playNumberSound;

@property(nonatomic,retain) NSArray *numberToFindArray;
@property(nonatomic,retain) NSMutableArray *pickedNumbers;
@property(nonatomic,retain) NSMutableArray *movableDominos;
@end
