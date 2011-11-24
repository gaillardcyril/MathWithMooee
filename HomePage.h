//
//  HelloWorldLayer.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 16/12/10.
//  Copyright Voila Design 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
//#import "CCAnimationHelper.h"

// HelloWorld Layer
@interface HomePage : CCLayer
{
	CCSprite *mooee;
	CCAction *talkAction;
	ALuint instructionsSoundId;
	CCMenuItemImage *menuItemStartPlaying;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
-(void) tellInstructions;
@property (nonatomic, retain) CCSprite *mooee;
@property (nonatomic, retain) CCAction *talkAction;
@property (nonatomic, retain) CCMenuItemImage *menuItemStartPlaying;

@end
