//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "Level5.h"
#import "DBWrapper.h"
#import "MooeeMathAppDelegate.h"
#import "CurrentLevel.h"
#import "LevelSelection.h"
#import "SharedFunctions.h"

@implementation Level5
@synthesize numberToFindArray;
@synthesize pickedNumbers;
@synthesize movableDominos;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	Level5 *layer = [Level5 node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(void) showSelectionPage 
{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:[LevelSelection scene] withColor:ccc3(0,0,0)]];
}


-(void)startPlaying
{
	if (selectedDomino!=nil) {
		[self removeChild:selectedDomino cleanup:YES];
	}
	//CCLOG(@" startPlaying number of Iterations: %d",numberofIterations);
	if (numberofIterations < kLoopNumber_10) {
        currentNumberIndex = [[idxArray objectAtIndex:numberofIterations] intValue];
		[self playNumberSound];
	}
	else {
		gameEnded(self);
	}
}

-(void) playNumberSound
{
    NSString *soundStr = [NSString stringWithFormat:@"Number%d.mp3",currentNumberIndex];
    [[SimpleAudioEngine sharedEngine] playEffect:soundStr];
}

- (void) showPausePage: (CCMenuItem *) menuItem
{		
}

-(void) loadObjectsToFind
{		
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
    
    NSString *frameName;
	for(int i = 0; i <kLoopNumber_10 ; ++i) {
        frameName = [NSString stringWithFormat:@"Domino%02d.png",i];
		//CCLOG(@"Domino image %@",sDominoImage);
		CCSprite *dominoToDisplay = [CCSprite spriteWithSpriteFrameName:frameName];
        dominoToDisplay.scale=0.5;
		float offsetFraction = ((float)(i+1))/(kLoopNumber_10+1);
		dominoToDisplay.position = ccp(size.width*offsetFraction, size.height/2+100);
		[self addChild:dominoToDisplay z:5];
		[movableDominos addObject:dominoToDisplay];
	}
    
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self findTouchedDomino:touchLocation];      
    return TRUE;    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
	
	if (CGRectContainsPoint(houseToFill.boundingBox, touchLocation)) {
		numberofIterations++;
		[selectedDomino runAction:[CCSequence actions:[CCScaleTo actionWithDuration:0.5f scale:0],[CCCallFunc actionWithTarget:self selector:@selector(startPlaying)] ,nil]];
	}    
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {       
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
    CGPoint translation = ccpSub(touchLocation, oldTouchLocation);    
    [self moveSelectedDomino:translation];    
}

- (void)moveSelectedDomino:(CGPoint)translation {    
    if (selectedDomino) {
        CGPoint newPos = ccpAdd(selectedDomino.position, translation);
        selectedDomino.position = newPos;
    } 
}

- (void)findTouchedDomino:(CGPoint)touchLocation {
    CCSprite * newSprite = nil;
    for (CCSprite *sprite in movableDominos) {
        if (CGRectContainsPoint(sprite.boundingBox, touchLocation)) {            
            newSprite = sprite;
            break;
        }
    }    
    if (newSprite != selectedDomino) {
        [selectedDomino stopAllActions];
        [selectedDomino runAction:[CCRotateTo actionWithDuration:0.1 angle:0]];
        CCRotateTo * rotLeft = [CCRotateBy actionWithDuration:0.1 angle:-4.0];
        CCRotateTo * rotCenter = [CCRotateBy actionWithDuration:0.1 angle:0.0];
        CCRotateTo * rotRight = [CCRotateBy actionWithDuration:0.1 angle:4.0];
        CCSequence * rotSeq = [CCSequence actions:rotLeft, rotCenter, rotRight, rotCenter, nil];
        [newSprite runAction:[CCRepeatForever actionWithAction:rotSeq]];            
        selectedDomino = newSprite;
    }
}

-(void)resetVariables
{
	[pickedNumbers removeAllObjects];
	numberofIterations = 0;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// ask director the the window size
		size = [[CCDirector sharedDirector] winSize];
		[[CurrentLevel sharedCurrentLevel] setLevelNumber:[NSNumber numberWithInt:5]];
		
		numberofIterations = 0;
        
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        
        CCSpriteBatchNode *levelBatch = loadBatchNode(self, @"level5Sprites");
		displayBackground (levelBatch,@"Level5BG.png");
		
		houseToFill = [CCSprite spriteWithSpriteFrameName:@"House.png"];
		houseToFill.position= ccp(800,200);
		[self addChild:houseToFill z:2];
		
		pickedNumbers = [[NSMutableArray alloc] init];
		movableDominos = [[NSMutableArray alloc] init];
		idxArray = [[NSMutableArray alloc] init];
		[self loadObjectsToFind];
		
        for(NSInteger i=0;i<kLoopNumber_10;i++){
            [idxArray addObject:[NSNumber numberWithInt:i]];
        }
        [idxArray shuffle];
		[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
		[self startPlaying];
    }
	return self;
}


- (void) dealloc
{
	[pickedNumbers release];
	[movableDominos release];
	movableDominos=nil;
	[super dealloc];
}
@end
