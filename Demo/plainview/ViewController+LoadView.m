//
//  ViewController+LoadView.m
//  Demo
//
//  Created by Deheng Xu on 2020/1/8.
//

#import "ViewController+LoadView.h"
#import <UIKit/UIKit.h>

#import "NSLayoutConstraint+XALK.h"
#import "XAutoLayoutKit.h"
#import "XAutoLayoutKitEva+Private.h"

@implementation ViewController (LoadView)

- (void)_loadConstraints_Size {
    [self.objectOfReference setConstraintSize:CGSizeMake(200, 200)];
    [self.objectOfReference followCenterOfView:self.view];

    [self.v1 setConstraintSize:CGSizeMake(30, 30)];
    [self.v2 setConstraintSize:CGSizeMake(40, 40)];
    [self.v3 setConstraintSize:CGSizeMake(50, 50)];
    [self.v4 setConstraintSize:CGSizeMake(60, 60)];
}

- (void)_loadConstraints_API2G_A
{
    [self _loadConstraints_Size];

    [self.v1 above:10 ofView:self.objectOfReference];
    [self.v1 followCenterXOfView:self.objectOfReference];

    [self.v2 after:10 ofView:self.objectOfReference];
    [self.v2 followCenterYOfView:self.objectOfReference];

    [self.v3 below:10 ofView:self.objectOfReference];
    [self.v3 followCenterXOfView:self.objectOfReference];

    [self.v4 ahead:10 ofView:self.objectOfReference];
    [self.v4 followCenterYOfView:self.objectOfReference];
}

- (void)_loadConstraints_API2G_B {
    [self _loadConstraints_Size];
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

- (void)_loadConstraints_API3G_C
{
    //[self.v1 removeFromSuperview];
    [self.v2 removeFromSuperview];
    [self.v3 removeFromSuperview];
    [self.v4 removeFromSuperview];
    //[self.lineH removeFromSuperview];
    //[self.lineV removeFromSuperview];
    //[self.objectOfReference removeFromSuperview];
    self.lineV.backgroundColor = UIColor.greenColor;

    self.objectOfReference.xalkBinder.equal.centerX.to(self.view).centerX.xalkLayout();
    self.objectOfReference.xalkBinder.equal.centerY.to(self.view).centerY.xalkLayout();
    self.objectOfReference.xalkBinder.equal.width.multiply(0.4).to(self.view).width.xalkLayout();
    self.objectOfReference.xalkBinder.equal.height.multiply(0.4).to(self.view).height.xalkLayout();

    self.lineH.xalkBinder.equal.bottom.constant(-2.0).to(self.objectOfReference).top.xalkLayout();
    self.lineH.xalkBinder.left.equal.to(self.objectOfReference).left.xalkLayout();
    self.lineH.xalkBinder.width.equal.multiply(0.5).to(self.objectOfReference).width.xalkLayout();
        self.lineH.xalkBinder.height.multiply(1.0).constant(2.0).xalkLayout();

    self.lineV.xalkBinder.right.equal.constant(-2.0).to(self.objectOfReference).left.xalkLayout();
    self.lineV.xalkBinder.top.equal.to(self.objectOfReference).top.xalkLayout();
    self.lineV.xalkBinder.width.constant(2.0).xalkLayout();
    self.lineV.xalkBinder.height.multiply(0.5).equal.to(self.objectOfReference).height.xalkLayout();



#if 0 //API style B
    [self.objectOfReference followSize:^(ALKViewBinder * _Nonnull binder) {
        binder.toView = self.view;
        binder.multiplier = 0.5;
    }];
#endif
}

@end
