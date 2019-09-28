//
//  NSLayoutConstraint+Convenient.m
//  PlaygroundLab
//
//  Created by DehengXu on 14/10/21.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//

#import "NSLayoutConstraint+Convenient.h"

@implementation NSLayoutConstraint (Convenient)

+ (NSArray *)defaultConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views
{
    return [NSLayoutConstraint constraintsWithVisualFormat:format options:0 metrics:nil views:views];
}

+ (void)setConstraintsWithView:(UIView *)view size:(CGSize)size
{
    if (!view.superview) {
        return;
    }
    NSArray *constraints = nil;

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[view(%f)]", size.width] views:NSDictionaryOfVariableBindings(view, view.superview)];
    [view.superview addConstraints:constraints];

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[view(%f)]", size.height] views:NSDictionaryOfVariableBindings(view, view.superview)];
    [view.superview addConstraints:constraints];
}

+ (void)followViewCenterX:(UIView *)v1 withView:(UIView *)v2
{
    if (!v2.superview) {
        return;
    }

    id constraint = [NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterX multiplier:1. constant:0];
    [v2.superview addConstraint:constraint];
}

+ (void)followViewCenterY:(UIView *)v1 withView:(UIView *)v2
{
    if (!v2.superview) {
        return;
    }

    id constraint = [NSLayoutConstraint constraintWithItem:v2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterY multiplier:1. constant:0];
    [v2.superview addConstraint:constraint];
}

+ (void)followViewCenter:(UIView *)v1 withView:(UIView *)v2
{
    [self followViewCenterX:v1 withView:v2];
    [self followViewCenterY:v1 withView:v2];
}

+ (void)addConstraintOnView:(UIView *)view withItem:(UIView *)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(UIView *)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c
{
    id constraint = [self constraintWithItem:view1 attribute:attr1 relatedBy:relation toItem:view2 attribute:attr2 multiplier:multiplier constant:c];

    if (view) {
        [view addConstraint:constraint];
    }
}

+ (void)addConstraintsOnView:(UIView *)view withVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    id constraints = [self constraintsWithVisualFormat:format options:opts metrics:metrics views:views];
    if (view) {
        [view addConstraints:constraints];
    }
}

@end

@implementation UIView (LayoutConstraint)

- (UIView *)x_constraintView
{
    if (!self.translatesAutoresizingMaskIntoConstraints) { return self; }

    self.translatesAutoresizingMaskIntoConstraints = NO;
    return self;
}

- (UIView *)x_nonnConstraintView
{
    if (self.translatesAutoresizingMaskIntoConstraints) { return self; }

    self.translatesAutoresizingMaskIntoConstraints = YES;
    return self;
}

- (void)setSameSizeWithView:(UIView *)view
{
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
}

- (void)setSameWidthWithView:(UIView *)view
{
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
}

- (void)setSameHeightWithView:(UIView *)view
{
    [NSLayoutConstraint addConstraintOnView:[view superview] withItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
}

- (void)setConstraintSize:(CGSize)size
{
    if (!self.superview) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, self.superview);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[self(%f)]", size.width] views:bindViews];
    [self.superview addConstraints:constraints];

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[self(%f)]", size.height] views:bindViews];
    [self.superview addConstraints:constraints];
}

- (void)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView
{
    if (!superView) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, self.superview);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[self(%f)]", size.width] views:bindViews];
    [superView addConstraints:constraints];

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[self(%f)]", size.height] views:bindViews];
    [superView addConstraints:constraints];

}

- (void)setConstraintWidth:(CGFloat)width onSuperView:(UIView *)superView
{
    if (!superView) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, superView);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"[self(%f)]", width] views:bindViews];
    [superView addConstraints:constraints];

}

- (void)setConstraintHeight:(CGFloat)height onSuperView:(UIView *)superView
{
    if (!superView) {
        printf("[XAutoLayout] Current view has not been add to a supeview.\n");
        return;
    }
    NSArray *constraints = nil;
    NSDictionary<NSString *, UIView *> *bindViews = NSDictionaryOfVariableBindings(self, superView);

    constraints = [NSLayoutConstraint defaultConstraintsWithFormat:[NSString stringWithFormat:@"V:[self(%f)]", height] views:bindViews];
    [superView addConstraints:constraints];
}

- (void)followCenterXOfView:(UIView *)v1
{
    [NSLayoutConstraint followViewCenterX:v1 withView:self];
}

- (void)followCenterYOfView:(UIView *)v1
{
    [NSLayoutConstraint followViewCenterY:v1 withView:self];
}

- (void)followCenterOfView:(UIView *)v1
{
    [NSLayoutConstraint followViewCenter:v1 withView:self];
}

- (void)followX:(CGFloat)x OfView:(UIView *)v1
{
    [self alignToLeft:x ofView:v1];
}

- (void)followY:(CGFloat)y OfView:(UIView *)v1
{
    [self alignToTop:y ofView:v1];
}

- (void)followPositionOfView:(UIView *)v1
{
    [self followX:0 OfView:v1];
    [self followY:0 OfView:v1];
}

- (void)followWidthOfView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [self.superview addConstraint:constraint];
}

- (void)followHeightOfView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    [self.superview addConstraint:constraint];
}

- (void)followSizeOfView:(UIView *)v1
{
    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]
    ];
    [self.superview addConstraints:constraints];
}

#pragma mark - align of view

- (void)alignToLeft:(CGFloat)margin ofView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:margin];
    [self.superview addConstraint:constraint];
}

- (void)alignToRight:(CGFloat)margin ofView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeRight multiplier:1.0 constant:-margin];
    [self.superview addConstraint:constraint];
}

- (void)alignToTop:(CGFloat)margin ofView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:margin];
    [self.superview addConstraint:constraint];
}

- (void)alignToBottom:(CGFloat)margin ofView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-margin];
    [self.superview addConstraint:constraint];
}

- (void)alignToCenter:(CGPoint)point ofView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:point.x];
    [self.superview addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:point.y];
    [self.superview addConstraint:constraint];
}

- (void)alignToPoint:(CGPoint)location ofView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:location.x];
    [self.superview addConstraint:constraint];

    constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:v1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:location.y];

    [self.superview addConstraint:constraint];
}

#pragma mark - out of view

- (void)above:(CGFloat)above OfView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:v1 attribute:NSLayoutAttributeTop multiplier:1.0 constant:above];

    [self.superview addConstraint:constraint];
}

- (void)below:(CGFloat)behide OfView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationLessThanOrEqual toItem:v1 attribute:NSLayoutAttributeBottom multiplier:1.0 constant:behide];

    [self.superview addConstraint:constraint];
}

- (void)ahead:(CGFloat)ahead OfView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationLessThanOrEqual toItem:v1 attribute:NSLayoutAttributeLeft multiplier:1.0 constant:ahead];

    [self.superview addConstraint:constraint];
}

- (void)after:(CGFloat)after OfView:(UIView *)v1
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:v1 attribute:NSLayoutAttributeRight multiplier:1.0 constant:after];

    [self.superview addConstraint:constraint];
}


@end


