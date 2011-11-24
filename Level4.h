//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Level4 : CCLayer
{
	
	NSMutableArray *numbers;
    NSDictionary *dictionnary;
    NSInteger numberIterations;
    CCMenu *numbersMenu;
    NSInteger randomIdx;
    NSInteger score;
}
+(id) scene;
-(void)placeNumbers;
-(void) startPlaying;

@end
