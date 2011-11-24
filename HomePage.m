//
//  HelloWorldLayer.m
//  MooeeMath
//
//  Created by Cyril Gaillard on 16/12/10.
//  Copyright Voila Design 2010. All rights reserved.
//

// Import the interfaces
#import "HomePage.h"
#import "LevelSelection.h"
#import "SettingsPage.h"

// HelloWorld implementation
@implementation HomePage
@synthesize mooee,talkAction,menuItemStartPlaying;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HomePage *layer = [HomePage node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
		
		CCSprite *homePgBgnd = [CCSprite spriteWithFile:@"HomePageBG.jpg"];
		
		// position the label on the center of the screen
		homePgBgnd.position =  ccp( size.width /2 , size.height/2 );
		// add the label as a child to this Layer
		[self addChild:homePgBgnd z:1];
        
		CCSprite *gameheader = [CCSprite spriteWithFile:@"gameHeader.png"];
		
		// position the label on the center of the screen
		gameheader.position =  ccp( size.width /2 ,size.height - 120 );
		// add the label as a child to this Layer
		[self addChild:gameheader z:2];
        
			
		// This loads an image of the same name (but ending in png), and goes through the
        // plist to add definitions of each frame to the cache.
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"MooeeTalk.plist"];        
        
		
		/*-------------------------------Menu HomePage  --------------*/
		menuItemStartPlaying =[CCMenuItemImage itemFromNormalImage:@"startlearning.png"
																 selectedImage: nil
																		target:self
																	  selector:@selector(showLevelMenu:)];
		
		CCMenuItemImage *menuItemCredits =[CCMenuItemImage itemFromNormalImage:@"credits.png"
															  selectedImage: nil
																	 target:self
																   selector:@selector(showCreditsPage:)];
		
		CCMenuItemImage *menuItemSettings =[CCMenuItemImage itemFromNormalImage:@"settings.png"
																 selectedImage: nil
																		target:self
																	  selector:@selector(showSettingsPage:)];
		
        
		CCMenu *menuHomePage = [CCMenu menuWithItems:menuItemStartPlaying, menuItemCredits, menuItemSettings, nil];
		[menuHomePage alignItemsVerticallyWithPadding:5];
		menuHomePage.position =ccp(size.width /2+30 , size.height/2);
		[self addChild:menuHomePage z:2];
		
		
		//----------------------End of HomePage Menu - --------------------------------------//
		
		CCSprite *normalMoee = [CCSprite spriteWithFile:@"NormalMooee.png"];
		normalMoee.position = ccp([normalMoee contentSize].width/2,[normalMoee contentSize].height/2);
		[self addChild:normalMoee z:2];
		
		// Create a sprite sheet
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"MooeeTalk.png"];
        
        // Load up the frames of our animation
        NSMutableArray *talkAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 125; ++i) {
            [talkAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"Mooee%04d.png", i]]];
			//CCLOG(@"Moee%04d.png",i);
        }
		CCAnimation *talkAnim = [CCAnimation animationWithFrames:talkAnimFrames delay:0.04f];
		self.talkAction = [CCAnimate actionWithAnimation:talkAnim restoreOriginalFrame:NO];
		
		self.mooee = [CCSprite spriteWithSpriteFrameName:@"Mooee0001.png"];        
        mooee.position = ccp([normalMoee contentSize].width/2, 45);
        
        [spriteSheet addChild:mooee];
		
		[self addChild:spriteSheet z:2];
		
		[self performSelector:@selector(tellInstructions) withObject:nil afterDelay:1.0f];
		
		CCLOG(@"instrcutions id %d",instructionsSoundId);
	
	}
	return self;
}

-(void) tellInstructions
{
	id flashingSprite = [CCSequence actions:
					  [CCFadeOut actionWithDuration: 0.4],					 
					  [CCFadeIn actionWithDuration: 0.4],					  
					  nil];
	[menuItemStartPlaying runAction:[CCRepeatForever actionWithAction: flashingSprite]];
	instructionsSoundId = [[SimpleAudioEngine sharedEngine] playEffect:@"HomePageInstructions.mp3"];
	CCLOG(@"instrcutions after init id %d",instructionsSoundId);
	[mooee runAction:talkAction];
}


- (void) showLevelMenu: (CCMenuItem *) menuItem 
{
	CCLOG(@"selected Levels");
	[[CCDirector sharedDirector] replaceScene:[LevelSelection scene]];
}
- (void) showCreditsPage: (CCMenuItem *) menuItem 
{
	CCLOG(@"selected Credits");
}
- (void) showSettingsPage: (CCMenuItem *) menuItem 
{
	CCScene *scene = [CCScene node];
	SettingsPage *layer = [SettingsPage node];
	
	[scene addChild:layer];
	[[CCDirector sharedDirector] replaceScene:scene];

}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	CCLOG(@"dealloc");
	if (instructionsSoundId) {
		[[SimpleAudioEngine sharedEngine] stopEffect:instructionsSoundId];
	}
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
