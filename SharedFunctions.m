//
//  SharedFunctions.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 3/01/11.
//  Copyright 2011 Voila Design. All rights reserved.
//


#import "SharedFunctions.h"
#import "CurrentLevel.h"
#import "ObjectToFind.h"



void gameEnded(CCLayer *currentLayer)
{
    [[CurrentLevel sharedCurrentLevel] initIdxArray];
    [currentLayer performSelector:@selector(showSelectionPage) withObject:nil afterDelay:3.0f];
        
}

//-----------------------Function to the load the batch Node-------------------//
CCSpriteBatchNode *loadBatchNode (CCLayer *currentLayer, NSString *batchName){
    NSString *batchCczName = [batchName stringByAppendingString:@".pvr.ccz"];
    CCSpriteBatchNode *levelBatch = [CCSpriteBatchNode batchNodeWithFile:batchCczName];
    [currentLayer addChild:levelBatch];
    NSString *batchPlistName = [batchName stringByAppendingString:@".plist"];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:batchPlistName];
    return levelBatch;
}

//-----------------------Function to the play the instructions-------------------//

void playGameInstructions (ALuint *instructionSoundID )
{
	if(*instructionSoundID)
		[[SimpleAudioEngine sharedEngine] stopEffect:*instructionSoundID];

		*instructionSoundID = [[SimpleAudioEngine sharedEngine] playEffect:@"Level1Instructions.mp3"];
}	

//-----------------------Function to the pause button-------------------//
void displayBackground (CCSpriteBatchNode *currentBatch, NSString *BGString){
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	CCSprite *homePgBgnd = [CCSprite spriteWithSpriteFrameName:BGString];
	CGSize dSize = [[CCDirector sharedDirector] winSize];
	// position the label on the center of the screen
	homePgBgnd.position =  ccp( dSize.width /2 , dSize.height/2 );
	// add the label as a child to this Layer
	[currentBatch addChild:homePgBgnd z:1];
}


//-----------------------Function to the pause button-------------------//
void displayPauseButton (CCLayer *currentLayer )
{
    CGSize dSize = [[CCDirector sharedDirector] winSize];
	CCMenuItemImage *menuItemPauseGame =[CCMenuItemImage itemFromNormalImage:@"PauseButton.png" selectedImage: @"PauseButton.png" target:currentLayer selector:@selector(showPausePage:)];	

	CCMenu *pauseButtonMenu = [CCMenu menuWithItems:menuItemPauseGame, nil];
	pauseButtonMenu.position = ccp([menuItemPauseGame contentSize].width/2, dSize.height-[menuItemPauseGame contentSize].height/2);

	[currentLayer addChild:pauseButtonMenu z:10];
}


//-----------------------Function to Display Mooee-------------------//
void displayMooee (CCLayer *currentLayer)
{
	CCMenuItemImage *normalMooeePix =[CCMenuItemImage itemFromNormalImage:@"NormalMooee.png"
														selectedImage: @"NormalMooee.png"
															   target:currentLayer
															 selector:@selector(repeatSound:)];	

	CCMenu *normalMooee = [CCMenu menuWithItems:normalMooeePix, nil];
	normalMooee.position = ccp([normalMooeePix contentSize].width/2,[normalMooeePix contentSize].height/2);
	[currentLayer addChild:normalMooee z:5];

}

//-----------------------Shake Sprite-------------------//
void shakeNumberToPick (CCLayer *currentLayer, ALuint *soundID)
{
	id shakeSprite = [CCSequence actions:
					  [CCRotateBy actionWithDuration: 0.1 angle: -10],					 
					  [CCRotateBy actionWithDuration: 0.1 angle: 20],
					  [CCRotateBy actionWithDuration: 0.1 angle: -20],
					  [CCRotateBy actionWithDuration: 0.1 angle: +20],
					  [CCRotateBy actionWithDuration: 0.1 angle: -20],
					  [CCRotateBy actionWithDuration: 0.1 angle: +20],
					  [CCRotateBy actionWithDuration: 0.1 angle: -20],
					  [CCRotateBy actionWithDuration: 0.1 angle: +20],
					  [CCRotateBy actionWithDuration: 0.1 angle: -20],
					  [CCRotateBy actionWithDuration: 0.1 angle: +10],
					  nil];
	
	*soundID = [[SimpleAudioEngine sharedEngine] playEffect:@"dinnerBell.wav"];
	[[currentLayer getChildByTag:0] runAction:shakeSprite];
}

void displayRainbow ( CCLayer *currentlayer)
{
	NSNumber *currentScore = [[CurrentLevel sharedCurrentLevel]currentScore];
	NSInteger scoreNumber = [currentScore intValue];
    CGSize dSize = [[CCDirector sharedDirector] winSize];
	CCSprite *rainbow ;
	if (scoreNumber && scoreNumber < 10) {
		[currentlayer removeChild:[currentlayer getChildByTag:99] cleanup:YES];
		NSString *rainbowToDisplay = [NSString stringWithFormat:@"Rainbow%d.png",scoreNumber];
		rainbow = [CCSprite spriteWithFile:rainbowToDisplay];
		[currentlayer addChild:rainbow z:3];
		rainbow.anchorPoint = ccp(0,0);
		rainbow.tag=99;
		rainbow.position = ccp(dSize.width/10,dSize.height/3);
	}
	

}

NSDictionary *read_pList()
{
    NSInteger curLevel = [[[CurrentLevel sharedCurrentLevel] levelNumber] intValue];
    NSString *pListName = [NSString stringWithFormat:@"Level%d",curLevel];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:pListName ofType:@"plist"];
    
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    
}

void enableTouchesAllObjects (NSMutableArray *spriteToChoose)
{
	for (ObjectToFind *objectToDisplay in spriteToChoose)
	{ 
		[objectToDisplay disableTouch:NO];
	}
}
void disableTouchesAllObjects (NSMutableArray *spriteToChoose)
{
	for (ObjectToFind *objectToDisplay in spriteToChoose)
	{ 
		[objectToDisplay disableTouch:YES];
	}
}


