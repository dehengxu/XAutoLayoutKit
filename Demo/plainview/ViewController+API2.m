//
//  ViewController+LoadView.m
//  Demo
//
//  Created by Deheng Xu on 2020/1/8.
//

#import "ViewController+API2.h"
#import <UIKit/UIKit.h>

#import "NSLayoutConstraint+XALK.h"
#import "XAutoLayoutKit.h"
#import "XAutoLayoutBinder+Private.h"

@implementation ViewController (API2)

- (void)layoutWithAPI2_size {
    [self.objectOfReference setConstraintSize:CGSizeMake(200, 200)];
    [self.objectOfReference followCenterOfView:self.view];

    [self.v1 setConstraintSize:CGSizeMake(30, 30)];
    [self.v2 setConstraintSize:CGSizeMake(40, 40)];
    [self.v3 setConstraintSize:CGSizeMake(50, 50)];
    [self.v4 setConstraintSize:CGSizeMake(60, 60)];
}

- (void)layoutWithAPI2_StyleA
{
    [self layoutWithAPI2_size];

    [self.v1 above:10 ofView:self.objectOfReference];
    [self.v1 followCenterXOfView:self.objectOfReference];

    [self.v2 after:10 ofView:self.objectOfReference];
    [self.v2 followCenterYOfView:self.objectOfReference];

    [self.v3 below:10 ofView:self.objectOfReference];
    [self.v3 followCenterXOfView:self.objectOfReference];

    [self.v4 ahead:10 ofView:self.objectOfReference];
    [self.v4 followCenterYOfView:self.objectOfReference];
}

- (void)layoutWithAPI2_StyleB {
    [self layoutWithAPI2_size];
    NSLog(@"version: %@", kXAutoLayoutVersion);
    
    [self.lineH followCenterXOfView:self.objectOfReference];
    //[self.lineH followY:-5.0 OfView:self.objectOfReference];
    [self.lineH above:5.0 ofView:self.objectOfReference];
    [self.lineH followWidthOfView:self.objectOfReference];
    [self.lineH setConstraintHeight:2.0];

    [self.lineV followCenterYOfView:self.objectOfReference];
    //[self.lineV followX:-5.0 OfView:self.objectOfReference];
    [self.lineV ahead:5.0 ofView:self.objectOfReference];
    [self.lineV followHeightOfView:self.objectOfReference];
    [self.lineV setConstraintWidth:2.0];
    
}


@end
