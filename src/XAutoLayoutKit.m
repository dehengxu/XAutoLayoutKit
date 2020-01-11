//
//  NSLayoutConstraint+Convenient.m
//  PlaygroundLab
//
//  Created by DehengXu on 14/10/21.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

#import "XAutoLayoutKit.h"
#import "NSLayoutConstraint+XALK.h"

NSString * const kXAutoLayoutVersion = @"0.3.0-beta";

#pragma mark - UIView category

@implementation UIView (LayoutConstraint)

- (instancetype)alk_enableAutoLayout
{
    if (!self.translatesAutoresizingMaskIntoConstraints) { return self; }

    self.translatesAutoresizingMaskIntoConstraints = NO;
    return self;
}

- (instancetype)alk_disableAutoLayout
{
    if (self.translatesAutoresizingMaskIntoConstraints) { return self; }

    self.translatesAutoresizingMaskIntoConstraints = YES;
    return self;
}

#pragma mark - set size
    
- (instancetype)setSameSizeWithView:(UIView *)view
{
    [self alk_enableAutoLayout];
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    return self;
}

- (instancetype)setSameWidthWithView:(UIView *)view
{
    [self alk_enableAutoLayout];
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    return self;
}

- (instancetype)setSameHeightWithView:(UIView *)view
{
    [self alk_enableAutoLayout];
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    return self;
}

- (instancetype)setConstraintSize:(CGSize)size
{
    [self alk_enableAutoLayout];
    if (!self.superview) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return nil;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, self.superview);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[self(%f)]", size.width] views:bindViews];
    [self.superview addConstraints:constraints];

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[self(%f)]", size.height] views:bindViews];
    [self.superview addConstraints:constraints];
    return self;
}

- (instancetype)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView
{
    [self alk_enableAutoLayout];
    if (!superView) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return nil;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, self.superview);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[self(%f)]", size.width] views:bindViews];
    [superView addConstraints:constraints];

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[self(%f)]", size.height] views:bindViews];
    [superView addConstraints:constraints];
    return self;
}

- (instancetype)setConstraintWidth:(CGFloat)width onSuperView:(UIView *)superView
{
    [self alk_enableAutoLayout];
    if (!superView) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return nil;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, superView);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[self(%f)]", width] views:bindViews];
    [superView addConstraints:constraints];
    return self;
}

- (instancetype)setConstraintWidth:(CGFloat)width
{
    [self alk_enableAutoLayout];
    if (!self.superview) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return nil;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, self.superview);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[self(%f)]", width] views:bindViews];
    [self.superview addConstraints:constraints];
    return self;
}

- (instancetype)setConstraintHeight:(CGFloat)height onSuperView:(UIView *)superView
{
    [self alk_enableAutoLayout];
    if (!superView) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return nil;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, superView);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[self(%f)]", height] views:bindViews];
    [superView addConstraints:constraints];
    return self;
}

- (instancetype)setConstraintHeight:(CGFloat)height
{
    [self alk_enableAutoLayout];
    if (!self.superview) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return nil;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, self.superview);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[self(%f)]", height] views:bindViews];
    [self.superview addConstraints:constraints];
    return self;
}

#pragma mark - follow position
    
- (instancetype)followCenterXOfView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    [NSLayoutConstraint followViewCenterX:v1 withView:self];
    return self;
}

- (instancetype)followCenterYOfView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    [NSLayoutConstraint followViewCenterY:v1 withView:self];
    return self;
}

- (instancetype)followCenterOfView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    [NSLayoutConstraint followViewCenter:v1 withView:self];
    return self;
}

- (instancetype)followX:(CGFloat)x OfView:(UIView *)v1
{
    [self alignToLeft:x ofView:v1];
    return self;
}

- (instancetype)followY:(CGFloat)y OfView:(UIView *)v1
{
    [self alignToTop:y ofView:v1];
    return self;
}

- (instancetype)followPositionOfView:(UIView *)v1
{
    [self alignToLeft:0 ofView:v1];
    [self alignToTop:0 ofView:v1];
    return self;
}
    
#pragma mark - follow size

- (instancetype)followWidthOfView:(UIView *)v1
{
    [self followWidthOfView:v1 withMultiplier:1.0];
    return self;
}
    
- (instancetype)followWidthOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier {
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeWidth multiplier:multiplier constant:0];
    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)followHeightOfView:(UIView *)v1
{
    [self followHeightOfView:v1 withMultiplier:1.0];
    return self;
}
    
- (instancetype)followHeightOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeHeight multiplier:multiplier constant:0];
    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)followSizeOfView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]
    ];
    [self.superview addConstraints:constraints];
    return self;
}

- (instancetype)followSizeOfView:(UIView *)v1 withMultipliers:(NSArray *)multipliers
{
    [self alk_enableAutoLayout];
    CGFloat multiW = 1.0, multiH = 1.0;
    if (multipliers && multipliers.count > 1) {
        if ([multipliers[0] isKindOfClass:NSNumber.class] && [multipliers[1] isKindOfClass:NSNumber.class]) {
            multiW = ((NSNumber *)multipliers[0]).floatValue;
            multiH = ((NSNumber *)multipliers[1]).floatValue;
        }
    }
    NSArray *constraints = @[
                             [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeWidth multiplier:multiW constant:0],
                             [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeHeight multiplier:multiH constant:0]
                             ];
    [self.superview addConstraints:constraints];
    return self;
}
    
#pragma mark - align of view

- (instancetype)alignToLeft:(CGFloat)margin ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)alignToRight:(CGFloat)margin ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)alignToTop:(CGFloat)margin ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)alignToBottom:(CGFloat)margin ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin];
    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)alignToCenter:(CGPoint)point ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:point.x];
    [self.superview addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:point.y];
    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)alignToPoint:(CGPoint)location ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:location.x];
    [self.superview addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:location.y];

    [self.superview addConstraint:constraint];
    return self;
}

#pragma mark - out of view

- (instancetype)above:(CGFloat)above ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:v1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:-above];

    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)below:(CGFloat)behide ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:v1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:behide];

    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)ahead:(CGFloat)ahead ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:v1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-ahead];

    [self.superview addConstraint:constraint];
    return self;
}

- (instancetype)after:(CGFloat)after ofView:(UIView *)v1
{
    [self alk_enableAutoLayout];
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:v1 attribute:NSLayoutAttributeRight multiplier:1.0 constant:after];

    [self.superview addConstraint:constraint];
    return self;
}

@end


