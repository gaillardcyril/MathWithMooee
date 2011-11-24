//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level3.h"
#import "DBWrapper.h"
#import "MooeeMathAppDelegate.h"
#import "CurrentLevel.h"
#import "LevelSelection.h"
#import "SharedFunctions.h"

@implementation Level3

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level3 *layer = [Level3 node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
	
	[self startPlaying];
	
    return TRUE;    
}

-(void) playNumberSound
{
    NSInteger soundIdx = [[[CurrentLevel sharedCurrentLevel].idxArray objectAtIndex:randomIdx] intValue];
    NSString *soundStr = [NSString stringWithFormat:@"Number%d.mp3",soundIdx];
    [[SimpleAudioEngine sharedEngine] playEffect:soundStr]; 
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
    CCMenuItemSprite *planeItem;
    CCSprite *planeSprite;
    for(NSInteger i=0;i<3;i++)
    {
        NSInteger idxToDisplay = [[[CurrentLevel sharedCurrentLevel].idxArray objectAtIndex:i] intValue];
        NSString *planeStr = [NSString stringWithFormat:@"Plane%02d.png",idxToDisplay];
        planeSprite = [CCSprite spriteWithSpriteFrameName:planeStr];
        planeItem =[CCMenuItemSprite itemFromNormalSprite:planeSprite selectedSprite:nil target: self selector: @selector(checkAnswer:)];  
        planeItem.tag = i;
        
        [planesMenu addChild:planeItem];
    }  
}

-(void)startPlaying
{
    if (numberIterations>0) {
        [self removeChild:planesMenu cleanup:YES];
        planesMenu=nil;
    } 
    if (numberIterations <= kLoopNumber_10) {            
        planesMenu = [CCMenu menuWithItems:nil];
        randomIdx = floor(arc4random()%3);
        [[CurrentLevel sharedCurrentLevel].idxArray shuffle];
        [self placePlanes];
        [self addChild:planesMenu];        
        [planesMenu alignItemsVertically];
        [self playNumberSound];
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
		
		// ask director the the window size
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:3]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];	
		
		numberIterations = 0;
		
		CCSpriteBatchNode *levelBatch = loadBatchNode(self, @"level3Sprites");
        
		displayBackground (levelBatch,@"level3BG.png");		
    
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
	return self;
}

- (void) dealloc
{
    [super dealloc];
}
@end
