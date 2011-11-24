//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <AVFoundation/AVFoundation.h>

#define DOMINO1X 90 
#define DOMINO2X 236
#define DOMINO3X 380
#define DOMY 180
#define DOMINO_SLIDE_DURATION 3.0f

@interface Level7 : CCLayer
{
    CCMenu *dominosMenu;
    NSInteger randomIdx;
    NSInteger numberIterations;
}

+(id) scene;
-(void)startPlaying;


@end
