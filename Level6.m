//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level6.h"
#import "TransitionPage.h"
#import "LevelSelection.h"
#import "CurrentLevel.h"
#import "MooeeMathAppDelegate.h"
#import "SharedFunctions.h"



@implementation Level6
//@synthesize row;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level6 *layer = [Level6 node];
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
    } 
    if (numberIterations <= kLoopNumber_10) {            
        dominosMenu = [CCMenu menuWithItems:nil];
        randomIdx = floor(arc4random()%3);
        [[CurrentLevel sharedCurrentLevel].idxArray shuffle];
        [self placePlanes];
        [self addChild:dominosMenu z:5];        
        [dominosMenu alignItemsHorizontally];
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
		
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:6]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];
		// ask director the the window size
		[CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        CCSpriteBatchNode *levelBatch = loadBatchNode(self, @"level6Sprites");
        
		numberIterations = 0;
		CCSprite *homePgBgndUpper = [CCSprite spriteWithSpriteFrameName:@"Level6BGH.png"];		
		// position the label on the center of the screen
		homePgBgndUpper.anchorPoint=ccp(0,0 );
		homePgBgndUpper.position =  ccp( 0 , 324);
		// add the label as a child to this Layer
		[levelBatch addChild:homePgBgndUpper z:1];
		
		CCSprite *homePgBgndLower = [CCSprite spriteWithSpriteFrameName:@"Level6BGL.png"];		
		// position the label on the center of the screen
		homePgBgndLower.anchorPoint=ccp(0,0);
		homePgBgndLower.position =  ccp(0,0);
		// add the label as a child to this Layer
		[levelBatch addChild:homePgBgndLower z:3];
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    
	}
	return self;
}

- (void) dealloc
{
	[super dealloc];
}
@end