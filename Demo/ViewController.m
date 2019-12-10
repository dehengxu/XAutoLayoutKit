//
//  ViewController.m
//  PlaygroundLab
//
//  https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutinCode/AutoLayoutinCode.html#//apple_ref/doc/uid/TP40010853-CH11-SW1
//  https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/
//
//  https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/DebuggingTricksandTips.html

//  Created by DehengXu on 14/10/17.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

#import "ViewController.h"

#import "XAutoLayoutKit.h"
#import "UIView+XAutoLayoutKitEva.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //UIView *v1, *v2;
    self.v1 = [[UIView alloc] initWithFrame:CGRectMake(100, 40, 20, 20)].alk_enableAutoLayout;
    self.v2 = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 20, 20)].alk_enableAutoLayout;
    self.v3 = [[UIView alloc] initWithFrame:CGRectMake(100, 40, 20, 20)].alk_enableAutoLayout;
    self.v4 = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 20, 20)].alk_enableAutoLayout;

    self.objectOfReference = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)].alk_enableAutoLayout;
    
    self.v1.backgroundColor = [UIColor redColor];
    self.v2.backgroundColor = [UIColor greenColor];
    self.v3.backgroundColor = [UIColor blueColor];
    self.v4.backgroundColor = [UIColor yellowColor];

    self.objectOfReference.backgroundColor = [UIColor orangeColor];

    [self.view addSubview:self.objectOfReference];
    [self.view addSubview:self.v4];
    [self.view addSubview:self.v3];
    [self.view addSubview:self.v2];
    [self.view addSubview:self.v1];

    self.lineV = UIView.new;
    self.lineH = UIView.new;
    self.lineH.backgroundColor = UIColor.redColor;
    self.lineV.backgroundColor = UIColor.redColor;

    [self.view addSubview:self.lineH];
    [self.view addSubview:self.lineV];

    //self.objectOfReference.center = CGPointMake(self.view.bounds.size.width / 2., self.view.bounds.size.height / 2.);

    self.view.alpha = 0.3;
    
    //[self _loadConstraintsA];
    [self _loadConstraintsNewAPI_B];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    NSLog(@"constraints :%lu", self.view.constraints.count);
}

- (void)_loadViewsNewAPI {
    [self.objectOfReference setConstraintSize:CGSizeMake(200, 200)];
    [self.objectOfReference followCenterOfView:self.view];
    
    [self.v1 setConstraintSize:CGSizeMake(30, 30)];
    [self.v2 setConstraintSize:CGSizeMake(40, 40)];
    [self.v3 setConstraintSize:CGSizeMake(50, 50)];
    [self.v4 setConstraintSize:CGSizeMake(60, 60)];
}

- (void)_loadConstraintsNewAPI_A
{
    [self _loadViewsNewAPI];
    
    [self.v1 above:10 ofView:self.objectOfReference];
    [self.v1 followCenterXOfView:self.objectOfReference];
    
    [self.v2 after:10 ofView:self.objectOfReference];
    [self.v2 followCenterYOfView:self.objectOfReference];
    
    [self.v3 below:10 ofView:self.objectOfReference];
    [self.v3 followCenterXOfView:self.objectOfReference];
    
    [self.v4 ahead:10 ofView:self.objectOfReference];
    [self.v4 followCenterYOfView:self.objectOfReference];
}

- (void)_loadConstraintsNewAPI_B {
    [self _loadViewsNewAPI];
    NSLog(@"version: %@", kXAutoLayoutVersion);
    ///TODO: add layout
    [self.lineH followCenterXOfView:self.objectOfReference];
    [self.lineH followY:-5.0 OfView:self.objectOfReference];
    [self.lineH followWidthOfView:self.objectOfReference];
    [self.lineH setConstraintHeight:2.0];
    
    [self.lineV followCenterYOfView:self.objectOfReference];
    [self.lineV followX:-5.0 OfView:self.objectOfReference];
    [self.lineV followHeightOfView:self.objectOfReference];
    [self.lineV setConstraintWidth:2.0];
    
    [self.lineV followSize:^(ALKViewBinder * _Nonnull binder) {
        [binder toView:self.view];
    }];
}

- (void)_loadConstraintsA
{
    NSDictionary *views = NSDictionaryOfVariableBindings(_v1, _v2, _v3, _v4, self.view, _objectOfReference);

    [NSLayoutConstraint setConstraintsWithView:self.objectOfReference size:CGSizeMake(200, 200)];
    [NSLayoutConstraint setConstraintsWithView:self.v1 size:CGSizeMake(30, 30)];
    [NSLayoutConstraint setConstraintsWithView:self.v2 size:CGSizeMake(40, 40)];
    [NSLayoutConstraint setConstraintsWithView:self.v3 size:CGSizeMake(50, 50)];
    [NSLayoutConstraint setConstraintsWithView:self.v4 size:CGSizeMake(60, 60)];
    [NSLayoutConstraint followViewCenter:self.view withView:self.objectOfReference];

    NSArray *constraints = nil;

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_v1]-10-[_objectOfReference]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views];
    [self.view addConstraints:constraints];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[_objectOfReference]-10-[_v2]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.view addConstraints:constraints];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_objectOfReference]-(10)-[_v3]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views];
    [self.view addConstraints:constraints];

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[_v4]-10-[_objectOfReference]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.view addConstraints:constraints];
}


/**
 Load constraint B
 
 https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/DebuggingTricksandTips.html
 
 */
- (void)_loadConstraintsB
{
    NSDictionary *views = NSDictionaryOfVariableBindings(_v1, _v2, _v3, _v4, self.view, _objectOfReference);

    [NSLayoutConstraint setConstraintsWithView:self.objectOfReference size:CGSizeMake(200, 200)];
    [NSLayoutConstraint setConstraintsWithView:self.v1 size:CGSizeMake(30, 30)];
    [NSLayoutConstraint setConstraintsWithView:self.v2 size:CGSizeMake(40, 40)];
    [NSLayoutConstraint setConstraintsWithView:self.v3 size:CGSizeMake(30, 30)];
    [NSLayoutConstraint setConstraintsWithView:self.v4 size:CGSizeMake(40, 40)];
    [NSLayoutConstraint followViewCenter:self.view withView:self.objectOfReference];

    NSArray *constraints = nil;
    id constraint = nil;

    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_v1]-0-[_objectOfReference]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views];
    [self.view addConstraints:constraints];
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"[_v1]-0-[_objectOfReference]" options:NSLayoutFormatAlignAllCenterY metrics:nil views:views];
    [self.view addConstraints:constraints];


//    constraint = [NSLayoutConstraint constraintWithItem:self.v1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeCenterX multiplier:1. constant:0];
//    [self.view addConstraint:constraint];
//    constraint = [NSLayoutConstraint constraintWithItem:self.v1 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeCenterY multiplier:1. constant:0];
//    [self.view addConstraint:constraint];

}

- (void)_loadConstraintsC
{
    [self.v1 setConstraintSize:CGSizeMake(30, 30)];
    [self.v2 setConstraintSize:CGSizeMake(40, 40)];
    [self.v3 setConstraintSize:CGSizeMake(30, 30)];
    [self.v4 setConstraintSize:CGSizeMake(40, 40)];

    [self.objectOfReference setConstraintSize:CGSizeMake(200, 200)];

    id constraint = nil;
    //Align v1 right side with left of objectOfReference and at center axis y.
    constraint = [NSLayoutConstraint constraintWithItem:self.v1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeLeft multiplier:1. constant:0];
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.v1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeCenterY multiplier:1. constant:0];
    [self.view addConstraint:constraint];

    //Align v2 with top of objectOfReference at center axis x of objectOfReference.
    constraint = [NSLayoutConstraint constraintWithItem:self.v2 attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeTop multiplier:1. constant:0];
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.v2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeCenterX multiplier:1. constant:0];
    [self.view addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self.v3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeRight multiplier:1. constant:0];
    [self.view addConstraint:constraint];
    [NSLayoutConstraint followViewCenterY:self.objectOfReference withView:self.v3];

    constraint = [NSLayoutConstraint constraintWithItem:self.v4 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.objectOfReference attribute:NSLayoutAttributeBottom multiplier:1. constant:0];
    [self.view addConstraint:constraint];
    [NSLayoutConstraint followViewCenterX:self.objectOfReference withView:self.v4];


    //Set objectOfReference always at center of view.
    constraint = [NSLayoutConstraint constraintWithItem:self.objectOfReference attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1. constant:0];
    [self.view addConstraint:constraint];
    constraint = [NSLayoutConstraint constraintWithItem:self.objectOfReference attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1. constant:0];
    [self.view addConstraint:constraint];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"%@\n\n%@", _v1, _v2);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
