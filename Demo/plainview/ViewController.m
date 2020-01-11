//
//  ViewController.m
//  PlaygroundLab
//
//  https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/AutolayoutPG/AutoLayoutinCode/AutoLayoutinCode.html#//apple_ref/doc/uid/TP40010853-CH11-SW1
//  https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/
//
//  https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/DebuggingTricksandTips.html
// https://developer.apple.com/library/archive/technotes/tn2154/_index.html#//apple_ref/doc/uid/DTS40013309-CH1-TNTAG2
// https://developer.apple.com/documentation/uikit/uiscrollview?language=objc 
//
//  Created by DehengXu on 14/10/17.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

#import "ViewController.h"

#import "XAutoLayoutKit.h"
#import "ViewController+LoadView.h"
#import <Demo-Swift.h>

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

    self.objectOfReference = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 150)].alk_enableAutoLayout;
    
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

    self.view.alpha = 0.8;
    
    //[self _loadConstraintsA];
    //[self _loadConstraintsB];
    //[self _loadConstraintsC];
    //[self _loadConstraintsD];
    //[self _loadConstraintsE];
    //[self _loadConstraintsNewAPI_A];
    //[self _loadConstraintsNewAPI_B];
    [self _loadConstraintsNewAPI_C];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    NSLog(@"constraints :%lu", self.view.constraints.count);
    NSLog(@"%s objectOfReference: %@", __func__, NSStringFromCGRect(self.objectOfReference.frame));
    NSLog(@"%s lineH: %@", __func__, NSStringFromCGRect(self.lineH.frame));

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"content: %@", NSStringFromCGSize(self.scrollView.contentSize));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"%s objectOfReference: %@", __func__, NSStringFromCGRect(self.objectOfReference.frame));
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"%s objectOfReference: %@", __func__, NSStringFromCGRect(self.objectOfReference.frame));
    NSLog(@"%s lineH: %@", __func__, NSStringFromCGRect(self.lineH.frame));
}

- (UIScrollView *)scrollView
{
    if (self.scroll) {
        return self.scroll;
    }
    if ([self.view isKindOfClass:UIScrollView.class]) {
        return (UIScrollView *)self.view;
    }
    return nil;
}

@end
