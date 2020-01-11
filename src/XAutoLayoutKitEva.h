//
//  XAutoLayoutKitEva.h
//  XAutoLayoutKit
//
//  Created by Deheng Xu on 2020/1/11.
//

#ifndef XAutoLayoutKitEva_h
#define XAutoLayoutKitEva_h

typedef enum : NSUInteger {
    ALKValueUnknown = 0,
    ALKValueSize,
    ALKVAlueWidth,
    ALKValueHeight,
} ALKValueType;

typedef enum: NSInteger {
    ALKActionInner,
    ALKActionAround,
    ALKActionFollow
} ALKAction;

typedef NS_ENUM(NSInteger, ALKAttribute) {
        ALKLayoutAttributeLeft = NSLayoutAttributeLeft,
        ALKLayoutAttributeRight,
        ALKLayoutAttributeTop,
        ALKLayoutAttributeBottom,
        ALKLayoutAttributeLeading,
        ALKLayoutAttributeTrailing,
        ALKLayoutAttributeWidth,
        ALKLayoutAttributeHeight,
        ALKLayoutAttributeCenterX,
        ALKLayoutAttributeCenterY,
        ALKLayoutAttributeLastBaseline,
    #if TARGET_OS_IPHONE
        ALKLayoutAttributeBaseline NS_SWIFT_UNAVAILABLE("Use 'lastBaseline' instead") = NSLayoutAttributeLastBaseline,
    #else
        ALKLayoutAttributeBaseline = NSLayoutAttributeLastBaseline,
    #endif
        ALKLayoutAttributeFirstBaseline API_AVAILABLE(macos(10.11), ios(8.0)),

    #if TARGET_OS_IPHONE
        ALKLayoutAttributeLeftMargin API_AVAILABLE(ios(8.0)),
        ALKLayoutAttributeRightMargin API_AVAILABLE(ios(8.0)),
        ALKLayoutAttributeTopMargin API_AVAILABLE(ios(8.0)),
        ALKLayoutAttributeBottomMargin API_AVAILABLE(ios(8.0)),
        ALKLayoutAttributeLeadingMargin API_AVAILABLE(ios(8.0)),
        ALKLayoutAttributeTrailingMargin API_AVAILABLE(ios(8.0)),
        ALKLayoutAttributeCenterXWithinMargins API_AVAILABLE(ios(8.0)),
        ALKLayoutAttributeCenterYWithinMargins API_AVAILABLE(ios(8.0)),
    #endif

        ALKLayoutAttributeNotAnAttribute = 0
};

typedef NS_ENUM(NSInteger, ALKRelation) {
    ALKLayoutRelationEqual = NSLayoutRelationEqual,
    ALKLayoutRelationLessThanOrEqual =  NSLayoutRelationLessThanOrEqual,
    ALKLayoutRelationGreaterThanOrEqual = NSLayoutRelationGreaterThanOrEqual
};

NS_ASSUME_NONNULL_BEGIN

/// Represent a constraint rule
@interface ALKAutoLayoutValue : NSObject

- (instancetype)equal;
- (instancetype)lessThanOrEqual;
- (instancetype)greatThanOrEqual;

- (instancetype)width;
- (instancetype)height;

- (instancetype)top;
- (instancetype)left;
- (instancetype)bottom;
- (instancetype)right;

- (instancetype)leading;
- (instancetype)trailing;

- (instancetype)centerX;
- (instancetype)centerY;

- (instancetype)to:(UIView *)view;

@end

@interface ALKViewBinder: NSObject

@property (nonatomic, assign) CGFloat multiplier;
@property (nonatomic, assign) CGFloat constants;

@property (nonatomic, readonly) ALKViewBinder * _Nonnull (^to)(UIView *view);

@property (nonatomic, readonly) void(^alkLayout)();

// MARK: - Relation

@property (nonatomic, readonly, nonnull) ALKViewBinder * equal;
@property (nonatomic, readonly, nonnull) ALKViewBinder * lessThanOrEqual;
@property (nonatomic, readonly, nonnull) ALKViewBinder * greatThanOrEqual;

// MARK: - Attribute

@property (nonatomic, readonly) ALKViewBinder * width;
@property (nonatomic, readonly) ALKViewBinder * height;

@property (nonatomic, readonly) ALKViewBinder * centerX;
@property (nonatomic, readonly) ALKViewBinder * centerY;
@property (nonatomic, readonly) ALKViewBinder * leading;
@property (nonatomic, readonly) ALKViewBinder * trailing;

@property (nonatomic, readonly) ALKViewBinder * top;
@property (nonatomic, readonly) ALKViewBinder * left;
@property (nonatomic, readonly) ALKViewBinder * bottom;
@property (nonatomic, readonly) ALKViewBinder * right;

@property (nonatomic, readonly) ALKViewBinder *(^multiply)(CGFloat multiplier);
@property (nonatomic, readonly) ALKViewBinder *(^constant)(CGFloat constants);

@end

@interface UIView (XAutoLayoutKitEva)

@property (nonatomic, readonly) ALKViewBinder *alkBinder;
- (ALKViewBinder *)alkBinder;

@end

NS_ASSUME_NONNULL_END

#endif /* XAutoLayoutKitEva_h */
