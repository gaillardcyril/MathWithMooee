//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "TransitionPage.h"
#import "LevelSelection.h"



@implementation TransitionPage

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];	
	// 'layer' is an autorelease object.
	TransitionPage *layer = [TransitionPage node];
	// add layer as a child to scene
	[scene addChild: layer];
	// return the scene
	return scene;
}

-(id) init

{
	if( (self=[super init] )) {

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		activeLevel = [CurrentLevel sharedCurrentLevel];
		
		CCSprite *pausePgBgnd = [CCSprite spriteWithFile:@"LevelSelectionBG.png"];
		pausePgBgnd.position = ccp(size.width/2,size.height/2);
		[self addChild:pausePgBgnd];
		
		CCMenuItemImage *menuItemResetGame =[CCMenuItemImage itemFromNormalImage:@"resetButton.png"
																   selectedImage: @"resetButton.png"
																		  target:self
																		selector:@selector(resetCurrentLevel:)];
		CCMenuItemImage *menuItemLevelSelGame =[CCMenuItemImage itemFromNormalImage:@"levelSelButton.png"
																	  selectedImage: @"levelSelButton.png"
																			 target:self
																		   selector:@selector(gotoLevelSelection:)];
		CCMenuItemImage *menuItemNextGame =[CCMenuItemImage itemFromNormalImage:@"fastForwardButton.png"
																  selectedImage: @"fastForwardButton.png"
																		 target:self
																	   selector:@selector(gotoNextLevel:)];
		
		CCMenu *transitionPageMenu = [CCMenu menuWithItems:menuItemResetGame,menuItemLevelSelGame,menuItemNextGame, nil];
		[transitionPageMenu alignItemsHorizontallyWithPadding:20 ];
		transitionPageMenu.position = ccp(size.width/2,size.height/2+10);
		
		[self addChild:transitionPageMenu];
		
		
		NSNumber *levelNumber = [[CurrentLevel sharedCurrentLevel] levelNumber];
		score = [[[CurrentLevel sharedCurrentLevel] currentScore]intValue];
		NSString *levelNumberPaused;
		CCLOG(@"the current level is %d",[[[CurrentLevel sharedCurrentLevel] currentScore]intValue]);
		
		id flashingSprite = [CCSequence actions:
							 [CCFadeOut actionWithDuration: 0.4],					 
							 [CCFadeIn actionWithDuration: 0.4],					  
							 nil];
		
		if (score > 8) {
			levelNumberPaused = [NSString stringWithFormat:@"Level %d Cleared",[levelNumber intValue]];
			
			[menuItemNextGame runAction:[CCRepeatForever actionWithAction: flashingSprite]];
		}
		else {
			levelNumberPaused = [NSString stringWithFormat:@"Level %d Failed",[levelNumber intValue]];
			[menuItemResetGame runAction:[CCRepeatForever actionWithAction: flashingSprite]];
		}
		
		CCLabelBMFont *levelPaused = [CCLabelBMFont labelWithString:levelNumberPaused fntFile:@"Oogie.fnt"];
		//CCLabelTTF *levelPaused =  [CCLabelTTF labelWithString:levelNumberPaused fontName:@"OogieBoogie" fontSize:60];
		levelPaused.position  = ccp(size.width/2,size.height-[levelPaused contentSize].height/2);
		//levelPaused.color = ccc3(85,130,194);
		[self addChild:levelPaused z:2];
		
		CCSprite *normalMoee = [CCSprite spriteWithFile:@"NormalMooee.png"];
		normalMoee.position = ccp([normalMoee contentSize].width/2,[normalMoee contentSize].height/2);
		[self addChild:normalMoee z:2];
		
		[self performSelector:@selector(tellInstructions) withObject:nil afterDelay:1.0f];
		
	}	
	return self;
}

-(void) tellInstructions
{

	if (score > 8){
	instructionsSoundId = [[SimpleAudioEngine sharedEngine] playEffect:@"youpigamewon.mp3"];
	}
	else {
		instructionsSoundId = [[SimpleAudioEngine sharedEngine] playEffect:@"ohnogamelost.mp3"];
	}

}

- (void) resetCurrentLevel: (CCMenuItem *) menuItem
{	
	//[[CCDirector sharedDirector] popScene];
	CCLOG(@"the current level is %d",[[activeLevel levelNumber] intValue]);
	NSString *levelToLoad = [NSString stringWithFormat:@"Level%d", [[activeLevel levelNumber] intValue]];
	[[CCDirector sharedDirector] replaceScene:[NSClassFromString(levelToLoad) scene]];
}

- (void) gotoLevelSelection: (CCMenuItem *) menuItem
{
	[[CCDirector sharedDirector] replaceScene:[LevelSelection scene]];
}

- (void) gotoNextLevel: (CCMenuItem *) menuItem
{ 
	NSInteger nextLevel = [[activeLevel levelNumber] intValue] + 1;
	NSString *levelToLoad = [NSString stringWithFormat:@"Level%d", nextLevel];
	[[CCDirector sharedDirector] replaceScene:[NSClassFromString(levelToLoad) scene]];
}

@end
