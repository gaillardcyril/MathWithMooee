//
//  LevelSelection.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 20/12/10.
//  Copyright 2010 Voila Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define BLUE_COLOR ccc3(85,130,194);
#define NUMBER_OF_LEVELS 20

@interface LevelSelection : CCLayer
{
	NSMutableArray *levelStatusCode;
}
-(void) loadStatusCode:(NSDictionary *) row;
-(void) displayMenuInGrid:(CCMenu *)menu;
+(id) scene;
@property(nonatomic,retain) NSMutableArray *levelStatusCode;
@end
