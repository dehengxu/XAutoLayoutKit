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
#import "XAutoLayoutBinder.h"

#ifndef XALK_WARN_UNUSED_RESULT
#define XALK_WARN_UNUSED_RESULT  
//__attribute__((warn_unused_result))
#endif

#ifndef XALK_DEPRECATED_MSG
#define XALK_DEPRECATED_MSG(x) __deprecated_msg(x)
#endif

FOUNDATION_EXTERN NSString *const kXAutoLayoutVersion;

#pragma mark - UIView category

@interface UIView (LayoutConstraint)

- (instancetype)alk_enableAutoLayout ;
- (instancetype)alk_disableAutoLayout ;

#pragma mark - set size

- (instancetype)setSameSizeWithView:(UIView *)view ;
- (instancetype)setSameWidthWithView:(UIView *)view ;
- (instancetype)setSameHeightWithView:(UIView *)view ;
- (instancetype)setConstraintSize:(CGSize)size ;
- (instancetype)setConstraintSize:(CGSize)size onSuperView:(UIView *) superView  XALK_DEPRECATED_MSG("should use -(instancetype)setConstraintSize: instead after 0.2.0");
- (instancetype)setConstraintWidth:(CGFloat)width ;
- (instancetype)setConstraintWidth:(CGFloat)width onSuperView:(UIView *) superView  XALK_DEPRECATED_MSG("should use -(instancetype)setConstraintWidth: instead after 0.2.0");
- (instancetype)setConstraintHeight:(CGFloat)height  ;
- (instancetype)setConstraintHeight:(CGFloat)height onSuperView:(UIView *) superView  XALK_DEPRECATED_MSG("should use -(instancetype)setConstraintHeight: instead after 0.2.0");

#pragma mark - follow position

- (instancetype)followCenterXOfView:(UIView *)v1 ;
- (instancetype)followCenterYOfView:(UIView *)v1 ;
- (instancetype)followCenterOfView:(UIView *)v1 ;

- (instancetype)followX:(CGFloat)x OfView:(UIView *) v1  XALK_DEPRECATED_MSG("should use alignTo... serial methods to instead");
- (instancetype)followY:(CGFloat)y OfView:(UIView *) v1  XALK_DEPRECATED_MSG("should use alignTo... serial methods to instead");
- (instancetype)followPositionOfView:(UIView *) v1  XALK_DEPRECATED_MSG("should use alignToPoint serial methods to instead");

#pragma mark - following APIs

- (instancetype)followWidthOfView:(UIView *)v1 ;
- (instancetype)followWidthOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier ;
- (instancetype)followHeightOfView:(UIView *)v1 ;
- (instancetype)followHeightOfView:(UIView *)v1 withMultiplier:(CGFloat)multiplier ;
- (instancetype)followSizeOfView:(UIView *)v1 ;
- (instancetype)followSizeOfView:(UIView *)v1 withMultipliers:(NSArray *)multipliers ;
- (instancetype)followSafeAreaOfView:(UIView*)v1 ;

#pragma mark - align of view

- (instancetype)alignToLeft:(CGFloat)margin ofView:(UIView *)v1 ;
- (instancetype)alignToRight:(CGFloat)margin ofView:(UIView *)v1 ;
- (instancetype)alignToTop:(CGFloat)margin ofView:(UIView *)v1 ;
- (instancetype)alignToBottom:(CGFloat)margin ofView:(UIView *)v1 ;
- (instancetype)alignToCenter:(CGPoint)point ofView:(UIView *)v1 ;
- (instancetype)alignToPoint:(CGPoint)location ofView:(UIView *)v1 ;

#pragma mark - out of view

- (instancetype)above:(CGFloat)above ofView:(UIView *)v1 ;
- (instancetype)below:(CGFloat)below ofView:(UIView *)v1 ;
- (instancetype)ahead:(CGFloat)ahead ofView:(UIView *)v1 ;
- (instancetype)after:(CGFloat)after ofView:(UIView *)v1 ;

#pragma mark - relate to anchor

- (instancetype)alignToLeft:(CGFloat)margin anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)alignToRight:(CGFloat)margin anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)alignToTop:(CGFloat)margin anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)alignToBottom:(CGFloat)margin anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)alignToCenter:(CGPoint)point anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)alignToPoint:(CGPoint)location anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;

#if 0
- (instancetype)above:(CGFloat)above anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)below:(CGFloat)below anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)ahead:(CGFloat)ahead anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;
- (instancetype)after:(CGFloat)after anchorOfView:(UIView *)v1 withSafeArea:(BOOL)isSafeArea ;

- (instancetype)above:(CGFloat)above anchorOfView:(UIView *)v1 ;
- (instancetype)below:(CGFloat)below anchorOfView:(UIView *)v1 ;
- (instancetype)ahead:(CGFloat)ahead anchorOfView:(UIView *)v1 ;
- (instancetype)after:(CGFloat)after anchorOfView:(UIView *)v1 ;
#endif

@end

//! Project version number for XAutoLayoutKit.
FOUNDATION_EXPORT double XAutoLayoutKitVersionNumber;

//! Project version string for XAutoLayoutKit.
FOUNDATION_EXPORT const unsigned char XAutoLayoutKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <XAutoLayoutKit/PublicHeader.h>
