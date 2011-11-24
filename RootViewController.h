//
//  RootViewController.h
//  MooeeMath
//
//  Created by Cyril Gaillard on 16/12/10.
//  Copyright Voila Design 2010. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RootViewController : UIViewController {
    NSMutableDictionary *pListContent;
    NSMutableArray *arrayIndexes;
    
}
- (void) copyStatusFile;
@property(nonatomic, retain)NSMutableDictionary *pListContent;
@property(nonatomic, retain)NSMutableDictionary *arrayIndexes;
@end
