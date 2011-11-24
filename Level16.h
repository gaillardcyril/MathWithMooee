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

@interface Level16 : CCLayer
{
	CGSize size;
	BOOL pausePagePresent;
	NSInteger numberofIterations;
	NSDictionary *levelItems;
}
+(id) scene;


@end
