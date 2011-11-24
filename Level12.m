//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level12.h"
#import "LevelSelection.h"
#import "CurrentLevel.h"
#import "MooeeMathAppDelegate.h"
#import "SharedFunctions.h"


@implementation Level12


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level12 *layer = [Level12 node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}


-(void) showSelectionPage 
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[LevelSelection scene] withColor:ccc3(0,0,0)]];
}

-(void)checkAnswer: (CCMenuItem *) menuItem{
    
    if (menuItem.tag==randomIdx) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moopie.mp3"];
        score++;
    }
    else{
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moono.mp3"];
    }
    numberIterations++;
    [self startPlaying];
}

-(void)placeShapes{
    NSMutableArray *shapesToPlace=[[NSMutableArray alloc] initWithObjects:@"Shape00.png",@"Shape00.png",@"Shape01.png",@"Shape01.png", nil];
    CCMenuItemSprite *numberItem;
    CCSprite *numberSprite;
    for(NSInteger i=0;i<3;i++)
    {
        NSInteger idxToDisplay = [[[CurrentLevel sharedCurrentLevel].idxArray objectAtIndex:i] intValue];
        NSString *numberStr = [NSString stringWithFormat:@"Number%02d.png",idxToDisplay];
        numberSprite = [CCSprite spriteWithSpriteFrameName:numberStr];
        numberItem =[CCMenuItemSprite itemFromNormalSprite:numberSprite selectedSprite:nil target: self selector: @selector(checkAnswer:)];  
        numberItem.tag = i;
        
        [numbersMenu addChild:numberItem];
    }  
}

-(void) startPlaying{
    if (numberIterations>0) {
        [self removeChild:numbersMenu cleanup:YES];
        numbersMenu=nil;
    } 
    if (numberIterations <= kLoopNumber_10) {            
        numbersMenu = [CCMenu menuWithItems:nil];
        randomIdx = floor(arc4random()%3);
        [[CurrentLevel sharedCurrentLevel].idxArray shuffle];
                
        [numbersMenu alignItemsHorizontally];

    }
    else{
        gameEnded(self);
    }
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
        
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:1]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];
		// ask director the the window size
        
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
		CCSpriteBatchNode *levelBatch = loadBatchNode(self, @"level12Sprites");
		displayBackground (levelBatch,@"Level12BG.png");
        
        numberIterations = 0; 
        score=0;
        [self startPlaying];
    }
    return self;
}


-(void)dealloc{
    [super dealloc];
}    
@end
