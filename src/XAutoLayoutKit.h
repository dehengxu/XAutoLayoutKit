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

+ (NSArray *)defaultConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views;
+ (void)setConstraintsWithView:(UIView *)view size:(CGSize)size;
+ (void)followViewCenterX:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenterY:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenter:(UIView *)v1 withView:(UIView *)v2;

+ (void)addConstraintOnView:(UIView *)view withItem:(UIView *)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

+ (void)addConstraintsOnView:(id)view withVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

@end

#pragma mark - UIView category

@interface UIView (LayoutConstraint)

- (instancetype)alk_enableAutoLayout __attribute__((warn_unused_result));
- (instancetype)alk_disableAutoLayout __attribute__((warn_unused_result));

#pragma mark - set size

- (instancetype)setSameSizeWithView:(UIView *)view __attribute__((warn_unused_result));
- (instancetype)setSameWidthWithView:(UIView *)view __attribute__((warn_unused_result));
- (instancetype)setSameHeightWithView:(UIView *)view __attribute__((warn_unused_result));
- (instancetype)setConstraintSize:(CGSize)size __attribute__((warn_unused_result));
- (instancetype)setConstraintSize:(CGSize)size onSuperView:(UIView *)superView __attribute__((warn_unused_result)) __deprecated_msg("should use -(instancetype)setConstraintSize: instead after 0.2.0");
- (instancetype)setConstraintWidth:(CGFloat)width __attribute__((warn_unused_result));
- (instancetype)setConstraintWidth:(CGFloat)width onSuperView:(UIView *)superView __attribute__((warn_unused_result)) __deprecated_msg("should use -(instancetype)setConstraintWidth: instead after 0.2.0");
- (instancetype)setConstraintHeight:(CGFloat)height __attribute__((warn_unused_result));
- (instancetype)setConstraintHeight:(CGFloat)height onSuperView:(UIView *)superView __attribute__((warn_unused_result)) __deprecated_msg("should use -(instancetype)setConstraintHeight: instead after 0.2.0");

#pragma mark - follow position

- (instancetype)followCenterXOfView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)followCenterYOfView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)followCenterOfView:(UIView *)v1 __attribute__((warn_unused_result));

- (instancetype)followX:(CGFloat)x OfView:(UIView *)v1 __deprecated_msg("should use alignTo... serial methods to instead") __attribute__((warn_unused_result));
- (instancetype)followY:(CGFloat)y OfView:(UIView *)v1 __deprecated_msg("should use alignTo... serial methods to instead") __attribute__((warn_unused_result));
- (instancetype)followPositionOfView:(UIView *)v1 __deprecated_msg("should use alignToPoint serial methods to instead") __attribute__((warn_unused_result));
    
#pragma mark - follow size
    
- (instancetype)followWidthOfView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)followWidthOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier __attribute__((warn_unused_result));
- (instancetype)followHeightOfView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)followHeightOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier __attribute__((warn_unused_result));
- (instancetype)followSizeOfView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)followSizeOfView:(UIView *)v1 withMultipliers:(NSArray *)multipliers __attribute__((warn_unused_result));

#pragma mark - align of view

- (instancetype)alignToLeft:(CGFloat)margin ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)alignToRight:(CGFloat)margin ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)alignToTop:(CGFloat)margin ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)alignToBottom:(CGFloat)margin ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)alignToCenter:(CGPoint)point ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)alignToPoint:(CGPoint)location ofView:(UIView *)v1 __attribute__((warn_unused_result));

#pragma mark - out of view

- (instancetype)above:(CGFloat)above ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)below:(CGFloat)behide ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)ahead:(CGFloat)ahead ofView:(UIView *)v1 __attribute__((warn_unused_result));
- (instancetype)after:(CGFloat)after ofView:(UIView *)v1 __attribute__((warn_unused_result));

@end
