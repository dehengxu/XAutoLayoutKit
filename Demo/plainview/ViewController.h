//
//  ViewController.h
//  PlaygroundLab
//
//  Created by DehengXu on 14/10/17.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) UIView *v1, *v2, *v3, *v4, *objectOfReference;
@property (nonatomic, strong) UIView *lineH, *lineV;

@property (nonatomic, strong) IBOutlet UIScrollView *scroll;

@property (readonly) UIScrollView *scrollView;

//Old api
//#if __has_include("NSLayoutConstraint+XALK")
- (void)_loadConstraintsXALKCategory_A;
- (void)_loadConstraintsXALKCategory_B;
- (void)_loadConstraintsXALKCategory_C;
//#endif

@end

