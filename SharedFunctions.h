//
//  SharedFunctions.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 3/01/11.
//  Copyright 2011 Voila Design. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "cocos2d.h"
#define kLoopNumber_10 10

void displayPauseButton (CCLayer *currentLayer);
void displayMooee (CCLayer *currentLayer );
void playGameInstructions (ALuint *instructionSoundID );
void shakeNumberToPick (CCLayer *currentLayer, ALuint *soundID);
void displayBackground (CCSpriteBatchNode *currentBatch, NSString *BGString);
void displayRainbow ( CCLayer *currentlayer);
CCSpriteBatchNode *loadBatchNode (CCLayer *currentLayer, NSString *batchName);
NSDictionary *read_pList();
void gameEnded(CCLayer *currentLayer);
void enableTouchesAllObjects (NSMutableArray *spriteToChoose);
void disableTouchesAllObjects (NSMutableArray *spriteToChoose);

