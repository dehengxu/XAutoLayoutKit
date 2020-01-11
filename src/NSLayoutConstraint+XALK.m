//
//  NSLayoutConstraint+XALK.m
//  Demo
//
//  Created by Deheng Xu on 2020/1/11.
//

#import "NSLayoutConstraint+XALK.h"

@implementation NSLayoutConstraint (XALK)

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
