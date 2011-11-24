//
//  MultiLayerScene.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 28.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "CurrentLevel.h"
#import "MooeeMathAppDelegate.h"

@implementation CurrentLevel
@synthesize levelNumber, currentScore,idxArray;


static CurrentLevel *sharedCurrentLevel;

+(CurrentLevel*) sharedCurrentLevel
{
	@synchronized(self)
	{
		if (!sharedCurrentLevel)
		{
			sharedCurrentLevel = [[CurrentLevel alloc] init];
            
		}
		return sharedCurrentLevel;
	}
	
}

-(void)initIdxArray{
    [idxArray removeAllObjects];
    for (NSInteger i=0; i<10; i++) {
        [idxArray addObject:[NSNumber numberWithInt:i]];
    }
}


-(void)incrementScore
{
	NSInteger scoreValue = [currentScore intValue];
	scoreValue++;
	[self setCurrentScore:[NSNumber numberWithInt:scoreValue]];
}
-(void) dealloc
{
	// don't forget to call "super dealloc"
	[super dealloc];
    [idxArray release];
}

@end
