//
//  MultiLayerScene.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 28.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "GameStatus.h"

@implementation GameStatus
@synthesize gameStatusList,statusPlistPath;
@synthesize gameIndex;


static GameStatus *sharedGameStatus;

+(GameStatus*) sharedGameStatus
{
	@synchronized(self)
	{
		if (!sharedGameStatus)
		{
			sharedGameStatus = [[GameStatus alloc] init];
		}
		return sharedGameStatus;
	}
	
}

-(void)updatePListFile{
    [gameStatusList writeToFile:statusPlistPath atomically:YES];
}
-(void) dealloc
{
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
