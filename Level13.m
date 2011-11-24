//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//
//*** implement triangles with bubbles*******/////

#import "Level13.h"
#import "CurrentLevel.h"
#import "TransitionPage.h"
#import "SharedFunctions.h"


@implementation Level13
//@synthesize row;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level13 *layer = [Level13 node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:13]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];
		// ask director the the window size
		size = [[CCDirector sharedDirector] winSize];
		
		numberofIterations = 0;
		
		displayBackground(self, @"Level1BG.png");
		displayPauseButton(self);
		displayMooee (self);
		
		levelItems = read_pList();
        
		gameHasStarted=NO;
			
	}
	return self;
}

-(void) onEnterTransitionDidFinish
{
	if (pausePagePresent)
	{
		//[self schedule:@selector(doStep:)];
		pausePagePresent = NO;
		
		if (!gameHasStarted){
			gameHasStarted=YES;
			[self startPlaying];
		}
		[self playNumberSound];
		
	}
	else {
		playGameInstructions(&instructionSoundID);
	}
	
	[super onEnterTransitionDidFinish];	
}

-(void)playNumberSound
{	
	[[SimpleAudioEngine sharedEngine]playEffect:[[levelItems objectForKey:@"Sounds"] objectAtIndex:randNumberIndex1]];
}

- (void) showPausePage: (CCMenuItem *) menuItem
{	
	pausePagePresent = YES;
}

-(void) startPlaying
{
		
	
	if (numberofIterations < [spriteNumbers count]) {
				
	}
	else {
		[[CCDirector sharedDirector] replaceScene:[TransitionPage scene]];
	}	
}

- (void)doStep:(ccTime)delta
{
		
}

- (void) repeatSound: (CCMenuItem *) menuItem
{
	if (gameHasStarted) {
		[self playNumberSound];
	}
	else {
		playGameInstructions(&instructionSoundID);
	}
}

- (void) dealloc
{
	[super dealloc];
}
@end