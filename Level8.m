//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level8.h"
#import "TransitionPage.h"
#import "LevelSelection.h"
#import "CurrentLevel.h"
#import "MooeeMathAppDelegate.h"
#import "SharedFunctions.h"



@implementation Level8

@synthesize  levelItems;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level8 *layer = [Level8 node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}



-(void) showSelectionPage 
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[LevelSelection scene] withColor:ccc3(0,0,0)]];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CCLOG(@"Layer has been touched");    	
    [[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[self startPlaying];
    return TRUE;    
}

-(void)placeNumbers{
    CCMenuItemSprite *numberItem;
    CCSprite *numberSprite;
    for(NSInteger i=0;i<3;i++)
    {
        NSInteger idxToDisplay = [[[CurrentLevel sharedCurrentLevel].idxArray objectAtIndex:i] intValue];
        NSString *numberStr = [NSString stringWithFormat:@"Number%02d.png",idxToDisplay];
        numberSprite = [CCSprite spriteWithSpriteFrameName:numberStr];
        numberSprite.scale=0.3;
        numberItem =[CCMenuItemSprite itemFromNormalSprite:numberSprite selectedSprite:nil target: self selector: @selector(checkAnswer:)];  
        numberItem.tag = i;
        
        [numbersMenu addChild:numberItem];
    }  
}

-(void)showAnimals{
    NSInteger randNumberIndex = [[[CurrentLevel sharedCurrentLevel].idxArray objectAtIndex:randomIdx] intValue];
    NSString *typeAnimal = [[levelItems objectForKey:@"TypeAnimal"] objectAtIndex:randNumberIndex];
    NSString *frameName = [NSString stringWithFormat:@"Animal%02d.png",randNumberIndex];
    animalToPassBy = [CCSprite spriteWithSpriteFrameName:frameName];
    CCLOG(@"the animal is %@",typeAnimal);
    if ([ typeAnimal isEqualToString:@"Dolphins"]) {
        animalToPassBy.flipX=YES;
        animalToPassBy.rotation=-80;
        animalToPassBy.position = ccp(100,300);
        [self addChild:animalToPassBy z:999];
        id animalMovement = [CCSpawn actions:[CCJumpTo actionWithDuration:3.0f position:ccp(800,300) height:200 jumps:1],
                             [CCRotateBy actionWithDuration: 3.0f angle: 160],nil];
        
        [[CDAudioManager sharedManager]playBackgroundMusic:@"dolphinsNoise.mp3" loop:NO];
        [[CDAudioManager sharedManager].backgroundMusic setVolume:0.2];
        [animalToPassBy runAction:animalMovement ];
    }
    else if ([ typeAnimal isEqualToString:@"Ducks"]) {
        //animalToPassBy.flipX=YES;
        //animalToPassBy.rotation=-80;
        animalToPassBy.position = ccp(600,110);
        [self addChild:animalToPassBy z:999];
        id animalMovement = [CCMoveTo actionWithDuration:8.0f position:ccp(-100,110)];
        [[CDAudioManager sharedManager]playBackgroundMusic:@"QuackQuack.wav" loop:YES];
        [[CDAudioManager sharedManager].backgroundMusic setNumberOfLoops:5];
        [[CDAudioManager sharedManager].backgroundMusic setVolume:0.2];
        //@"QuackQuack.mp3"[[SimpleAudioEngine sharedEngine]playEffect:@"QuackQuack.mp3"];
        [animalToPassBy runAction:animalMovement ];
    }
    else if ([ typeAnimal isEqualToString:@"Butterflies"]) {
        animalToPassBy.position = ccp(-200,260);
        [self addChild:animalToPassBy z:999];
        id animalMovement = [CCMoveTo actionWithDuration:8.0f position:ccp(700,260)];;
        [[CDAudioManager sharedManager]playBackgroundMusic:@"Butterfly.wav" loop:YES];
        [[CDAudioManager sharedManager].backgroundMusic setNumberOfLoops:3];
        [animalToPassBy runAction:animalMovement];
    }
}

-(void)checkAnswer: (CCMenuItem *) menuItem{
    
    if (menuItem.tag==randomIdx) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moopie.mp3"];        
    }
    else{
        [[SimpleAudioEngine sharedEngine] playEffect:@"Moono.mp3"];
    }
    numberofIterations++;
    [self startPlaying];
}

-(void) onExit
{
	CCLOG(@"I am in onExit");
	[super onExit];
}

-(void) startPlaying
{
	if (numberofIterations>0) {
        [self removeChild:numbersMenu cleanup:YES];
        [self removeChildByTag:999 cleanup:YES];
        numbersMenu=nil;
    } 
	if (numberofIterations < kLoopNumber_10) {
		
        numbersMenu = [CCMenu menuWithItems:nil];
        randomIdx = floor(arc4random()%3);
        
        [[CurrentLevel sharedCurrentLevel].idxArray shuffle];
        NSLog(@"the array is %@",[[CurrentLevel sharedCurrentLevel] idxArray]);
        [self placeNumbers];
        [self addChild:numbersMenu];
       // CGSize size=[[CCDirector sharedDirector] winSize];
        numbersMenu.position = ccp(size.width/2,200);
        [numbersMenu alignItemsHorizontallyWithPadding:20];
        [self showAnimals];    
    }
	else {
		gameEnded(self);
	}	
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:8]];
		[[CurrentLevel sharedCurrentLevel] setCurrentScore:[NSNumber numberWithInt:0]];
		// ask director the the window size
		size = [[CCDirector sharedDirector] winSize];
		
		numberofIterations = 0;
        
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        CCSpriteBatchNode *levelBatch = loadBatchNode(self, @"level8Sprites");
        levelItems = read_pList();
        
		CCSprite *homePgBgnd = [CCSprite spriteWithSpriteFrameName:@"Level8BGH.png"];		
		// position the label on the center of the screen
		homePgBgnd.anchorPoint=ccp(0,0);
		homePgBgnd.position =  ccp(0,260);
		// add the label as a child to this Layer
		[levelBatch addChild:homePgBgnd z:1];
				
		CCSprite *homePgBgndLower = [CCSprite spriteWithSpriteFrameName:@"Level8BGL.png"];		
		// position the label on the center of the screen
		homePgBgndLower.anchorPoint=ccp(0,0);
		homePgBgndLower.position =  ccp(0,0);
		// add the label as a child to this Layer
		[levelBatch addChild:homePgBgndLower z:3];
        
        [[CurrentLevel sharedCurrentLevel] initIdxArray];
        [[CurrentLevel sharedCurrentLevel].idxArray removeObjectAtIndex:0];
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		
	}
	return self;
}
- (void) dealloc
{
  [super dealloc];
}
@end