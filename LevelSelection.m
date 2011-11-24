//
//  LevelSelection.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import "LevelSelection.h"
#import "GameStatus.h"
#import "HomePage.h"


@implementation LevelSelection
@synthesize levelStatusCode;
//@synthesize row;


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	LevelSelection *layer = [LevelSelection node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		
		levelStatusCode = [[NSMutableArray alloc]init];		
		
		//CCLOG(@"the status of levels are %@",levelStatusCode);
		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *homePgBgnd = [CCSprite spriteWithFile:@"LevelSelectionBG.jpg"];
		
		// position the label on the center of the screen
		homePgBgnd.position =  ccp( size.width /2 , size.height/2 );
		// add the label as a child to this Layer
		[self addChild:homePgBgnd z:1];
		
		CCMenu *levelSelectionMenu = [CCMenu menuWithItems: nil];
		[self addChild:levelSelectionMenu z:2];
		
		for (NSInteger i=1; i<=NUMBER_OF_LEVELS; i++)
		{
			CCMenuItem *cloudLevel = [CCMenuItemImage itemFromNormalImage:@"whitecloud.png" selectedImage:nil target: self selector: @selector(MenuItem:)];		
			cloudLevel.tag=i;
			
			NSInteger statusCode = [[[[[GameStatus sharedGameStatus] gameStatusList] objectForKey:@"GameStatus"] objectAtIndex:i-1] intValue];
			CCLOG(@"the status code is %d",statusCode);
			
			if (statusCode == 0) {
				//load lock picture
				CCSprite *lockPix = [CCSprite spriteWithFile:@"lock.png"];
				[cloudLevel setIsEnabled:NO];
				lockPix.position = ccp([cloudLevel contentSize].width/2 ,[cloudLevel contentSize].height/2); 
				[cloudLevel addChild:lockPix z:3];				
			}
			else if (statusCode == 1)
			{	//load number picture
				NSString *levelNumber = [NSString stringWithFormat:@"%d",i];
				CCLabelTTF *label = [CCLabelTTF labelWithString:levelNumber fontName:@"OogieBoogie" fontSize:48];
				label.position = ccp([cloudLevel contentSize].width/2 ,[cloudLevel contentSize].height/2);
				label.color = BLUE_COLOR;
				[cloudLevel addChild:label z:3]; 				
			}
			else
			{	
				//load lock picture
				CCSprite *checkMarkPix = [CCSprite spriteWithFile:@"greenTick.png"];
				checkMarkPix.position = ccp([cloudLevel contentSize].width/2 ,[cloudLevel contentSize].height/2); 
				[cloudLevel addChild:checkMarkPix z:3];
				
			}
		[levelSelectionMenu addChild:cloudLevel];
		}
		
		CCMenuItem *itemBackArrow = [CCMenuItemImage itemFromNormalImage:@"backArrow.png" selectedImage:@"backArrow.png" target: self selector: @selector(goBackHome:)];
		CCMenu *backHomeMenu = [CCMenu menuWithItems:itemBackArrow, nil];
		backHomeMenu.position = ccp(30,290);
		[self addChild:backHomeMenu z:2];
		
        [self displayMenuInGrid:levelSelectionMenu];
        
		/*NSNumber *itemsPerRow = [NSNumber numberWithInt:5];
		[levelSelectionMenu alignItemsInColumns:itemsPerRow,itemsPerRow,itemsPerRow,itemsPerRow,nil];*/
		levelSelectionMenu.position = ccp(100,size.height-200);
		
	}
	return self;
}


-(void) displayMenuInGrid:(CCMenu *)menu{
    
    NSInteger xPos=20;
    NSInteger yPos=20;
    NSInteger itemPerRow = 5;
    NSInteger xPadding = 200;
    NSInteger yPadding = 150;
    
    for (CCMenuItem* menuItem in menu.children){
        menuItem.position = ccp(xPos,yPos);
        xPos+=xPadding;
        if(menuItem.tag%itemPerRow == 0){
            xPos=20;
            yPos-=yPadding;
        }
    }    
}    


-(void) loadStatusCode:(NSDictionary *) row {

	
}

-(void)MenuItem:(CCMenuItem  *) menuItem {
	
	NSString *levelToLoad = [NSString stringWithFormat:@"Level%d", menuItem.tag];
	[[CCDirector sharedDirector] replaceScene:[NSClassFromString(levelToLoad) scene]];
	
}

-(void)goBackHome:(id)sender {
	[[CCDirector sharedDirector] replaceScene:[HomePage scene]];
}

-(void) dealloc
{
	[levelStatusCode release];
	[super dealloc];
}
@end
