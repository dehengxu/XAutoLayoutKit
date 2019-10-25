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

FOUNDATION_EXTERN NSString * const kXAutoLayoutVersion;

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

- (instancetype)alk_enableAutoLayout;
- (instancetype)alk_disableAutoLayout;

#pragma mark - set size

- (instancetype)setSameSizeWithView:(UIView *)view;
- (instancetype)setSameWidthWithView:(UIView *)view;
- (instancetype)setSameHeightWithView:(UIView *)view;
- (instancetype)setConstraintSize:(CGSize)size;
- (instancetype)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView;
- (instancetype)setConstraintWidth:(CGFloat)width onSuperView:(UIView *)superView;
- (instancetype)setConstraintHeight:(CGFloat)height onSuperView:(UIView *)superView;

#pragma makr - follow position

- (instancetype)followCenterXOfView:(UIView *)v1;
- (instancetype)followCenterYOfView:(UIView *)v1;
- (instancetype)followCenterOfView:(UIView *)v1;
- (instancetype)followX:(CGFloat)x OfView:(UIView *)v1;
- (instancetype)followY:(CGFloat)y OfView:(UIView *)v1;
- (instancetype)followPositionOfView:(UIView *)v1;
    
#pragma mark - follow size
    
- (instancetype)followWidthOfView:(UIView *)v1;
- (instancetype)followWidthOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier;
- (instancetype)followHeightOfView:(UIView *)v1;
- (instancetype)followHeightOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier;
- (instancetype)followSizeOfView:(UIView *)v1;
- (instancetype)followSizeOfView:(UIView *)v1 withMultipliers:(NSArray *)multipliers;

#pragma mark - align of view

- (instancetype)alignToLeft:(CGFloat)margin ofView:(UIView *)v1;
- (instancetype)alignToRight:(CGFloat)margin ofView:(UIView *)v1;
- (instancetype)alignToTop:(CGFloat)margin ofView:(UIView *)v1;
- (instancetype)alignToBottom:(CGFloat)margin ofView:(UIView *)v1;
- (instancetype)alignToCenter:(CGPoint)point ofView:(UIView *)v1;
- (instancetype)alignToPoint:(CGPoint)location ofView:(UIView *)v1;

#pragma mark - out of view

- (instancetype)above:(CGFloat)above OfView:(UIView *)v1;
- (instancetype)below:(CGFloat)behide OfView:(UIView *)v1;
- (instancetype)ahead:(CGFloat)ahead OfView:(UIView *)v1;
- (instancetype)after:(CGFloat)after OfView:(UIView *)v1;

@end
