//
//  MultiLayerScene.h
//  ScenesAndLayers
//
//  Created by Steffen Itterheim on 28.07.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "cocos2d.h"

// Using an enum to define tag values has the upside that you can select

// Class forwards: if a class is used in a header file only to define a member variable or return value,
// then it's more effective to use the @class keyword rather than #import the class header file.
// When projects grow large this helps to reduce the time it takes to compile the project.

@interface LevelInstructions : NSObject 
{
	AVAudioPlayer *levelInstructions;
}

// Accessor methods to access the various layers of this scene
+(LevelInstructions*) sharedLevelInstructions;

@property (nonatomic,assign) AVAudioPlayer *levelInstructions;;

@end
