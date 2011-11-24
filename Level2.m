//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level2.h"
#import "DBWrapper.h"
#import "MooeeMathAppDelegate.h"
#import "CurrentLevel.h"

#import "LevelSelection.h"
#import "SharedFunctions.h"

@implementation Level2
@synthesize numberToFindArray;
@synthesize pickedNumbers;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level2 *layer = [Level2 node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(void) showSelectionPage 
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[LevelSelection scene] withColor:ccc3(0,0,0)]];
}

- (void) repeatSound: (CCMenuItem *) menuItem
{
	if (gameHasStarted) {
		[self playNumberSound];
	}
	else {
		playGameInstructions (&instructionSoundID);
	}
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    //CCLOG(@"Layer has been touched");    
	
	[[SimpleAudioEngine sharedEngine] stopEffect:instructionSoundID];
    [self loadObjectsToFind];
	gameHasStarted=YES;
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	
	[self startPlaying];
	
    return TRUE;    
}

			
-(void) onExit
{
	[super onExit];
}


-(void)startPlaying
{
	//CCLOG(@"the number of iterations is %d and total number of objects is %d",numberofIterations,[objectList count]);
	
	//CCLOG(@" startPlaying number of Iterations: %d",numberofIterations);
	if (numberofIterations < [[levelItems objectForKey:@"Images"] count]) {
		
		do {
			currentNumberIndex = CCRANDOM_0_1()*[[levelItems objectForKey:@"Images"] count];
		} while ([pickedNumbers containsObject:[NSNumber numberWithInt:currentNumberIndex]]);
		
		[pickedNumbers addObject:[NSNumber numberWithInt:currentNumberIndex]];
		
		//currentNumberIndex = 3;
		CCLOG(@"the picked number is%d",currentNumberIndex);
		//CCLOG(@"array of objects %d", [numberToFindArray count]);
		[self playNumberSound];
	}
	else {
		gameEnded(self);
	}

}

-(void) playNumberSound
{
	if (correctSpriteSoundID) {
		[[SimpleAudioEngine sharedEngine] stopEffect:correctSpriteSoundID];
	}
    correctSpriteSoundID = [[SimpleAudioEngine sharedEngine] playEffect: [[levelItems objectForKey:@"Sounds"] objectAtIndex:currentNumberIndex]];
}

- (void) showPausePage: (CCMenuItem *) menuItem
{	
	pausePagePresent=YES;
    
}

-(void)checkAnswer: (CCMenuItem *) menuItem{
    if (menuItem.tag==currentNumberIndex){
        CCNode *menuItem = [numberMenu getChildByTag:currentNumberIndex];
        [menuItem runAction:[CCFadeOut actionWithDuration:0.5]];
        
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moopie.mp3"];
        
    }
    else{
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moono.mp3"];
    }
    numberofIterations++;
    [self startPlaying];
}

-(void) loadObjectsToFind
{
	NSInteger numberIndex;
	NSInteger xCoordObj;
	NSInteger yCoordObj;
	
    NSString *frameName;
    numberMenu = [CCMenu menuWithItems: nil];
	for (numberIndex = 0; numberIndex < [[levelItems objectForKey:@"Images"] count]; numberIndex++) {
        frameName = [NSString stringWithFormat:@"NumberH%02d.png",numberIndex];
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
		CCSprite *numberToFind = [CCSprite spriteWithSpriteFrameName:frameName];
        
		CCMenuItemSprite *numberSprite = [CCMenuItemSprite itemFromNormalSprite:numberToFind selectedSprite:nil target:self selector:@selector(checkAnswer:)];
        
		xCoordObj = [[[levelItems objectForKey:@"XCoord"]objectAtIndex:numberIndex] intValue]*2.13;
		yCoordObj = [[[levelItems objectForKey:@"YCoord"]objectAtIndex:numberIndex] intValue]*2.4;
		
		numberSprite.tag = numberIndex;
		numberSprite.position = ccp(xCoordObj,yCoordObj);
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
		[numberMenu addChild:numberSprite];
	}
    [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    [self addChild:numberMenu];
    numberMenu.position=ccp(0,0);
	
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// ask director the the window size
		size = [[CCDirector sharedDirector] winSize];
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:2]];
		[[CurrentLevel sharedCurrentLevel]setCurrentScore:[NSNumber numberWithInt:0]];
        
		numberofIterations = 0;
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
		CCSpriteBatchNode *levelBatch = loadBatchNode(self, @"level2Sprites");		
		displayBackground (levelBatch,@"Level2BG.png");		
		displayPauseButton(self);
		displayMooee (self );
		
		levelItems = read_pList();
		
		pickedNumbers = [[NSMutableArray alloc] init];
        
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
    }
	return self;
}

- (void) dealloc
{
	[pickedNumbers release];
	[super dealloc];
}
@end
