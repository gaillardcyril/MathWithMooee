//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ObjectToFind.h"

#define DOMINO1X 170 
#define DOMINO2X 266
#define DOMINO3X 370
#define DOMY 50
#define DOMINO_SLIDE_DURATION 3.0f

@interface Level8 : CCLayer
{
	
	CGSize size;
    CCMenu *numbersMenu;
    NSInteger randomIdx;
	NSInteger numberofIterations;
	CCSprite *animalToPassBy;
    NSDictionary *levelItems;
}
+(id) scene;

-(void) startPlaying;


@property(nonatomic,retain)NSDictionary *levelItems;

@end
