//
//  NSLayoutConstraint+Convenient.h
//  PlaygroundLab
//
//  Created by DehengXu on 14/10/21.
//  Copyright (c) 2014年 DehengXu. All rights reserved.
//
//  autolayout, constraints underlier algorithm:
//  https://constraints.cs.washington.edu/cassowary/
//

#import <UIKit/UIKit.h>

@interface NSLayoutConstraint (Convenient)

+ (NSArray *)defaultConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views;
+ (void)setConstraintsWithView:(UIView *)view size:(CGSize)size;
+ (void)followViewCenterX:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenterY:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenter:(UIView *)v1 withView:(UIView *)v2;

+ (void)addConstraintOnView:(UIView *)view withItem:(UIView *)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

+ (void)addConstraintsOnView:(id)view withVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

@end

@interface UIView (LayoutConstraint)

- (UIView *)x_constraintView;
- (UIView *)x_nonnConstraintView;
- (void)setSameSizeWithView:(UIView *)view;
- (void)setConstraintSize:(CGSize)size;
- (void)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView;

#pragma makr - follow center
- (void)followCenterXOfView:(UIView *)v1;
- (void)followCenterYOfView:(UIView *)v1;
- (void)followCenterOfView:(UIView *)v1;
- (void)followX:(CGFloat)x OfView:(UIView *)v1;
- (void)followY:(CGFloat)y OfView:(UIView *)v1;

#pragma mark - align of view

- (void)alignToLeft:(CGFloat)margin ofView:(UIView *)v1;
- (void)alignToRight:(CGFloat)margin ofView:(UIView *)v1;
- (void)alignToTop:(CGFloat)margin ofView:(UIView *)v1;
- (void)alignToBottom:(CGFloat)margin ofView:(UIView *)v1;
- (void)alignToCenter:(CGPoint)point ofView:(UIView *)v1;
- (void)alignToPoint:(CGPoint)location ofView:(UIView *)v1;

#pragma mark - out of view

- (void)above:(CGFloat)above OfView:(UIView *)v1;
- (void)below:(CGFloat)behide OfView:(UIView *)v1;
- (void)ahead:(CGFloat)ahead OfView:(UIView *)v1;
- (void)after:(CGFloat)after OfView:(UIView *)v1;


@end
