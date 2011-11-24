//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level7.h"
#import "TransitionPage.h"
#import "LevelSelection.h"
#import "CurrentLevel.h"
#import "MooeeMathAppDelegate.h"
#import "SharedFunctions.h"



@implementation Level7



+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level7 *layer = [Level7 node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
	
	[self startPlaying];
	
    return TRUE;    
}

-(void) placeModel
{
    CGSize size = [[CCDirector sharedDirector] winSize];
    NSInteger numberIdx = [[[CurrentLevel sharedCurrentLevel].idxArray objectAtIndex:randomIdx] intValue];
    NSString *numberStr = [NSString stringWithFormat:@"Number%02d.png",numberIdx];
    CCSprite *numberModel = [CCSprite spriteWithSpriteFrameName:numberStr];
    [self addChild:numberModel];
    numberModel.scale=0.5;
    numberModel.tag=999;
    numberModel.position=ccp(size.width/2, 40);
}


-(void) showSelectionPage 
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[LevelSelection scene] withColor:ccc3(0,0,0)]];
}


-(void) onExit
{
	[super onExit];
}

-(void)checkAnswer: (CCMenuItem *) menuItem{
    
    if (menuItem.tag==randomIdx) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moopie.mp3"];
        
    }
    else{
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moono.mp3"];
    }
    numberIterations++;
    [self startPlaying];
}


-(void)placePlanes{
    CCMenuItemSprite *dominoItem;
    CCSprite *dominoSprite;
    for(NSInteger i=0;i<3;i++)
    {
        NSInteger idxToDisplay = [[[CurrentLevel sharedCurrentLevel].idxArray objectAtIndex:i] intValue];
        NSString *dominoStr = [NSString stringWithFormat:@"Domino%02d.png",idxToDisplay];
        dominoSprite = [CCSprite spriteWithSpriteFrameName:dominoStr];
        dominoItem =[CCMenuItemSprite itemFromNormalSprite:dominoSprite selectedSprite:nil target: self selector: @selector(checkAnswer:)];  
        dominoItem.tag = i;
        
        [dominosMenu addChild:dominoItem];
    }  
}

-(void)startPlaying
{
    if (numberIterations>0) {
        [self removeChild:dominosMenu cleanup:YES];
        dominosMenu=nil;
        [self removeChildByTag:999 cleanup:YES];
    } 
    if (numberIterations <= kLoopNumber_10) {            
        dominosMenu = [CCMenu menuWithItems:nil];
        randomIdx = floor(arc4random()%3);
        [[CurrentLevel sharedCurrentLevel].idxArray shuffle];
        [self placePlanes];
        [self addChild:dominosMenu z:5];        
        [dominosMenu alignItemsHorizontally];
        [self placeModel];
    }
    else{
        gameEnded(self);
    }
    
}

-(void)nothingGotTouched
{	
    numberIterations++;
	[self performSelector:@selector(startPlaying) withObject:nil afterDelay:1.0f];
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:7]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];
		// ask director the the window size
		[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        CCSpriteBatchNode *levelBatch = loadBatchNode(self, @"level7Sprites");
        displayBackground (levelBatch,@"Level7BG.png");
		numberIterations = 0;
		
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
	}
	return self;
}

- (void) dealloc
{

	[super dealloc];
}
@end