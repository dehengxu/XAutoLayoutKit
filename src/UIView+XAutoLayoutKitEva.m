//
//  UIView+XAutoLayoutKitEva.m
//  Demo
//
//  Created by NicholasXu on 2019/12/10.
//

#import "UIView+XAutoLayoutKitEva.h"

@implementation ALKViewBinder

- (instancetype)toView:(UIView *)view
{
    self.value2.payload = view;
    return self;
}

- (instancetype)follow
{
    self.action = ALKActionFollow;
    return self;
}

- (instancetype)align
{
    self.action = ALKActionAlign;
    return self;
}

- (instancetype)above
{
    self.action = ALKActionPosition;
    return self;
}

- (void)layout
{
    if (!self.value1) return;
    if (!self.value2) return;
    UIView *v1 = self.value1.payload, *v2 = self.value2.payload;
    
    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v2 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:v1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]
    ];
    [v1.superview addConstraints:constraints];
}

@end

@implementation ALKAutoLayoutValue

@end

@implementation UIView (XAutoLayoutKitEva)

- (void)followSize:(void (^)(ALKViewBinder * _Nonnull))aBlock
{
    ALKViewBinder *binder = ALKViewBinder.new;
    binder.action = ALKActionFollow;
    binder.value1 = ALKAutoLayoutValue.new;
    binder.value1.payload = self;
    
    binder.value2 = ALKAutoLayoutValue.new;
    aBlock(binder);
    [binder follow];
    [binder layout];
}

- (ALKViewBinder *)alkLayoutBinder
{
    return [ALKViewBinder new];
}

@end
