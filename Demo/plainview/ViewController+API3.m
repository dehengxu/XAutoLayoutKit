//
//  ViewController+API3.m
//  Demo
//
//  Created by NicholasXu on 2020/7/23.
//

#import "ViewController+API3.h"

#import "NSLayoutConstraint+XALK.h"
#import "XAutoLayoutKit.h"
//#import "XAutoLayoutBinder+Private.h"

@implementation ViewController (API3)

- (void)layoutWithAPI3_StyleA
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

- (void)layoutWithAPI3_StyleB {
    [self.v1 removeFromSuperview];
    [self.v2 removeFromSuperview];
    [self.v3 removeFromSuperview];
    [self.v4 removeFromSuperview];
    [self.lineH removeFromSuperview];
    [self.lineV removeFromSuperview];
    
    UIView *o = self.objectOfReference;

    [o alignToTop:0 anchorOfView:self.view withSafeArea:false];
    [o alignToLeft:0 ofView:self.view];
    [o alignToRight:0 ofView:self.view];
    [o alignToBottom:0 anchorOfView:self.view withSafeArea:false];
    
}

- (void)layoutWithAPI3_StyleC {
    [self.v1 removeFromSuperview];
    [self.v2 removeFromSuperview];
    [self.v3 removeFromSuperview];
    [self.v4 removeFromSuperview];
    [self.lineH removeFromSuperview];
    [self.lineV removeFromSuperview];
    
    UIView *o = self.objectOfReference;

    [o alignToTop:0 anchorOfView:self.view withSafeArea:true];
    [o alignToLeft:0 anchorOfView:self.view withSafeArea: true];
    [o alignToRight:0 anchorOfView:self.view withSafeArea: true];
    [o alignToBottom:0 anchorOfView:self.view withSafeArea:true];
}

@end
