//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

const int DOMINO1X=90;
const int DOMINO2X=236;
const int DOMINO3X=380;
const int DOMINOSY=60;
const int DOMINO_SLIDE_DURATION=3.0f;

@interface Level6 : CCLayer
{
    CCMenu *dominosMenu;
    NSInteger randomIdx;
    NSInteger numberIterations;
}

+(id) scene;
-(void)startPlaying;



@end
