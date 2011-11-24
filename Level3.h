//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

const int FLIGHT_DURATION=6.0f;
const int PLANE1Y=100;
const int PLANE2Y=190;
const int PLANE3Y=280;

@interface Level3 : CCLayer
{	
	
    CCMenu *planesMenu;
    NSInteger randomIdx;
    NSInteger numberIterations;
}

+(id) scene;
-(void)startPlaying;


@end
