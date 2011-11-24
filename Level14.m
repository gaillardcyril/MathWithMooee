//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level14.h"
#import "TransitionPage.h"
#import "LevelSelection.h"
#import "CurrentLevel.h"
#import "MooeeMathAppDelegate.h"
#import "SharedFunctions.h"


@implementation Level14
@synthesize spriteShape;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level14 *layer = [Level14 node];
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
		
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:14]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];
		// ask director the the window size
		size = [[CCDirector sharedDirector] winSize];
		
		numberofIterations = 0;
		
		displayBackground(self, @"Level1BG.png");
		displayPauseButton(self);
		displayMooee (self);
		
        spriteShape = [[NSMutableArray alloc] init];
        
		levelItems = read_pList();
		
        for(NSInteger i=0; i<[levelItems count];i++)
        {
        ObjectToFind *tempSprite = [ObjectToFind spriteWithFile:[[levelItems objectForKey:@"ShapeImages"] objectAtIndex:i]];
            tempSprite.tag=i;
            [spriteShape addObject:tempSprite]; 
        }
        
		gameHasStarted=NO;
		
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
			
	}
	return self;
}

-(void) onEnterTransitionDidFinish
{
	if (pausePagePresent)
	{
		//[self loadObjectsToFind];
		pausePagePresent = NO;
		
		if (!gameHasStarted){
			gameHasStarted=YES;
			//[self startPlaying];
		}
		//[self playNumberSound];
		
	}
	else {
        //NSLog(@"essai");
		playGameInstructions (&instructionSoundID);
	}
	
	[super onEnterTransitionDidFinish];
	
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    //CCLOG(@"Layer has been touched");    
	
	[[SimpleAudioEngine sharedEngine] stopEffect:instructionSoundID];
	gameHasStarted=YES;
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	
    [self startPlaying];
	
    return TRUE;    
}

-(void) startPlaying
{
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