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

#pragma mark - NSLayoutConstraint category

@interface NSLayoutConstraint (Convenient)


@end

#pragma mark - UIView category

@interface UIView (LayoutConstraint)

- (instancetype)alk_enableAutoLayout;
- (instancetype)alk_disableAutoLayout;

#pragma mark - set size

- (instancetype)setSameSizeWithView:(UIView *)view;
- (instancetype)setSameWidthWithView:(UIView *)view;
- (instancetype)setSameHeightWithView:(UIView *)view;
- (instancetype)setConstraintSize:(CGSize)size;
- (instancetype)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView __deprecated_msg("should use -(instancetype)setConstraintSize: instead after 0.2.0");
- (instancetype)setConstraintWidth:(CGFloat)width;
- (instancetype)setConstraintWidth:(CGFloat)width onSuperView:(UIView *)superView __deprecated_msg("should use -(instancetype)setConstraintWidth: instead after 0.2.0");
- (instancetype)setConstraintHeight:(CGFloat)height;
- (instancetype)setConstraintHeight:(CGFloat)height onSuperView:(UIView *)superView __deprecated_msg("should use -(instancetype)setConstraintHeight: instead after 0.2.0");

#pragma mark - follow position

- (instancetype)followCenterXOfView:(UIView *)v1;
- (instancetype)followCenterYOfView:(UIView *)v1;
- (instancetype)followCenterOfView:(UIView *)v1;

- (instancetype)followX:(CGFloat)x OfView:(UIView *)v1 __deprecated_msg("should use alignTo... serial methods to instead");
- (instancetype)followY:(CGFloat)y OfView:(UIView *)v1 __deprecated_msg("should use alignTo... serial methods to instead");
- (instancetype)followPositionOfView:(UIView *)v1 __deprecated_msg("should use alignToPoint serial methods to instead");
    
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

- (instancetype)above:(CGFloat)above ofView:(UIView *)v1;
- (instancetype)below:(CGFloat)behide ofView:(UIView *)v1;
- (instancetype)ahead:(CGFloat)ahead ofView:(UIView *)v1;
- (instancetype)after:(CGFloat)after ofView:(UIView *)v1;

@end
