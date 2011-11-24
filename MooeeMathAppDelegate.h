//
//  MooeeMathAppDelegate.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 16/12/10.
//  Copyright Voila Design 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface MooeeMathAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
	RootViewController *viewController;	
}

@property (nonatomic, retain) UIWindow *window;
@end

// This category enhances NSMutableArray by providing
// methods to randomly shuffle the elements.
@interface NSMutableArray (Shuffling)
- (void)shuffle;
@end
