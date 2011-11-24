//
//  MultiLayerScene.m
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 28.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "LevelInstructions.h"

@implementation LevelInstructions
@synthesize levelInstructions;
// Semi-Singleton: you can access MultiLayerScene only as long as it is the active scene.

static LevelInstructions *sharedCurrentLevel;

+(CurrentLevel*) sharedLevelInstructions
{
	@synchronized(self)
	{
		if (!sharedLevelInstructions)
		{
			sharedLevelInstructions = [[LevelInstructions alloc] init];
		}
		return sharedLevelInstructions;
	}
	
}
-(void)initInstructionsSound
{
	
	NSURL *pathInstructionsSound = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath],@"Level1Instructions.mp3"]];
	levelInstructions = [[AVAudioPlayer alloc] initWithContentsOfURL:pathInstructionsSound error:nil];
	levelInstructions.numberOfLoops=0;
	levelInstructions.delegate=self;

}

-(void)playInstruction
{
	[levelInstructions play];
}
-(void)stopInstruction
{
	[levelInstructions stop];
}

-(void) dealloc
{
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
