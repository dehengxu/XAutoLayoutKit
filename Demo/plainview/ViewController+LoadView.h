//
//  ViewController+LoadView.h
//  Demo
//
//  Created by Deheng Xu on 2020/1/8.
//

#import <UIKit/UIKit.h>


#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewController (LoadView)

- (void)_loadViewsNewAPI;

//Eval api
- (void)_loadConstraintsNewAPI_A;
- (void)_loadConstraintsNewAPI_B;
- (void)_loadConstraintsNewAPI_C;

//Old api
- (void)_loadConstraintsA;
- (void)_loadConstraintsB;
- (void)_loadConstraintsC;

@end

NS_ASSUME_NONNULL_END
