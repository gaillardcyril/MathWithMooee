//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define IMAGE1X 78 
#define IMAGE2X 236
#define IMAGE3X 393
#define IMAGESY 160


@interface Level9 : CCLayer
{
	
    NSInteger numberIterations;
    CCMenu *numbersMenu;
    NSInteger randomIdx;
    NSInteger score;
}
+(id) scene;
-(void)placeNumbers;
-(void) startPlaying;
@end
