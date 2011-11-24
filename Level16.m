//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level16.h"
#import "CurrentLevel.h"
#import "TransitionPage.h"
#import "SharedFunctions.h"


@implementation Level16
//@synthesize row;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level16 *layer = [Level16 node];
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
		
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:16]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];
		// ask director the the window size
		size = [[CCDirector sharedDirector] winSize];
		
		numberofIterations = 0;
		
		displayBackground(self, @"Level1BG.png");
		displayPauseButton(self);
		displayMooee (self );
		
		levelItems = read_pList();
			
	}
	return self;
}


- (void) showPausePage: (CCMenuItem *) menuItem
{	
	pausePagePresent = YES;
}

- (void) repeatSound: (CCMenuItem *) menuItem
{	

}

- (void) dealloc
{
	[super dealloc];
}
@end