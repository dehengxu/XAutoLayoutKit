//
//  UIView+XAutoLayoutKitEva.h
//  Demo
//
//  Created by NicholasXu on 2019/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    ALKValueUnknown = 0,
    ALKValueSize,
    ALKVAlueWidth,
    ALKValueHeight,
} ALKValueType;

typedef enum: NSInteger {
    ALKActionAlign,
    ALKActionPosition,
    ALKActionFollow
} ALKAction;

typedef NS_ENUM(NSUInteger, ALKAttribute) {
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

@interface ALKAutoLayoutValue : NSObject
@property (nonatomic, assign) ALKValueType type;
@property (assign) ALKAttribute attribute;
@property (nonatomic, strong) NSValue *value;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) UIView *payload;
@property (nonatomic, strong) ALKAutoLayoutValue *target;

@end

@interface ALKViewBinder: NSObject

@property ALKAction action;
@property (strong) ALKAutoLayoutValue *value1;
@property (strong) ALKAutoLayoutValue *value2;

- (instancetype)toView:(UIView *)view;

- (instancetype)follow;
- (instancetype)align;
- (instancetype)below;
- (instancetype)above;
- (instancetype)ahead;
- (instancetype)behide;
- (void)layout;

@end

@interface UIView (XAutoLayoutKitEva)

- (void)followSize:(void(^)(ALKViewBinder *))aBlock;
- (ALKViewBinder *)alkLayoutBinder;

@end

NS_ASSUME_NONNULL_END
