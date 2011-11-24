//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "SettingsPage.h"
#import "HomePage.h"


@implementation SettingsPage
//@synthesize row;


-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// ask director the the window size
		size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *homePgBgnd = [CCSprite spriteWithFile:@"LevelSelectionBG.jpg"];
		
		// position the label on the center of the screen
		homePgBgnd.position =  ccp( size.width /2 , size.height/2 );
		// add the label as a child to this Layer
		[self addChild:homePgBgnd z:1];
		
		
		CCMenuItemImage *menuResetGame =[CCMenuItemImage itemFromNormalImage:@"resetAllGames.png"
																	  selectedImage: nil
																			 target:self
																		   selector:@selector(resetAllGames:)];	
	
		CCMenu *settingsMenu = [CCMenu menuWithItems:menuResetGame, nil];
		settingsMenu.position = ccp(size.width/2, size.height/2);
		
		[settingsMenu alignItemsHorizontallyWithPadding:60];
		[self addChild:settingsMenu z:2];
		
		CCMenuItem *itemBackArrow = [CCMenuItemImage itemFromNormalImage:@"backArrow.png" selectedImage:@"backArrow.png" target: self selector: @selector(goBackHome:)];
		CCMenu *backHomeMenu = [CCMenu menuWithItems:itemBackArrow, nil];
		backHomeMenu.position = ccp(30,30);
		[self addChild:backHomeMenu z:2];
				
	}
	return self;
}


- (void) resetAllGames: (CCMenuItem *) menuItem
{	
}

-(void)goBackHome:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[HomePage scene]];
}

@end
