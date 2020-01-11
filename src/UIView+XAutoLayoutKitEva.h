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

@interface ALKAutoLayoutValue : NSObject

@property (nonatomic, assign) ALKValueType type;
@property (nonatomic, assign) ALKAttribute attribute;
@property (nonatomic, assign) ALKRelation relation;
@property (nonatomic, assign) CGFloat constants;
@property (nonatomic, assign) CGFloat mutiplier;
@property (nonatomic, strong) UIView *payload;
@property (nonatomic, strong) ALKAutoLayoutValue *target;

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

@property ALKAction action;

@property (nonatomic, weak) ALKViewBinder *master;
@property (nonatomic, strong) ALKViewBinder *slave;

@property (strong) ALKAutoLayoutValue *value1;
@property (strong) ALKAutoLayoutValue *value2;

@property (nonatomic, assign) CGFloat multiplier;
@property (nonatomic, assign) CGFloat constants;
@property (nonatomic, strong) UIView *toView;

@property (nonatomic, readonly) ALKViewBinder *(^to)(UIView *view);

//@property (nonatomic, copy) ALKViewBinder *(^align)(void);
//@property (nonatomic, copy) ALKViewBinder *(^follow)(UIView *view);

@property (nonatomic, readonly) void(^alkLayout)();

// MARK: - Relation

@property (nonatomic, readonly) ALKViewBinder *(^equal)(void);
@property (nonatomic, readonly) ALKViewBinder *(^lessThanOrEqual)(void);
@property (nonatomic, readonly) ALKViewBinder *(^greatThanOrEqual)(void);

// MARK: - Attribute

@property (nonatomic, readonly) ALKViewBinder *(^width)(void);
@property (nonatomic, readonly) ALKViewBinder *(^height)(void);

@property (nonatomic, readonly) ALKViewBinder *(^centerX)(void);
@property (nonatomic, readonly) ALKViewBinder *(^centerY)(void);
@property (nonatomic, readonly) ALKViewBinder *(^leading)(void);
@property (nonatomic, readonly) ALKViewBinder *(^trailing)(void);

@property (nonatomic, readonly) ALKViewBinder *(^top)(void);
@property (nonatomic, readonly) ALKViewBinder *(^left)(void);
@property (nonatomic, readonly) ALKViewBinder *(^bottom)(void);
@property (nonatomic, readonly) ALKViewBinder *(^right)(void);
@property (nonatomic, readonly) ALKViewBinder *(^multiply)(CGFloat multiplier);
@property (nonatomic, readonly) ALKViewBinder *(^constant)(CGFloat constants);

- (instancetype)follow;
- (instancetype)align;
- (instancetype)below;
- (instancetype)above;
//- (instancetype)ahead;
//- (instancetype)behide;
- (void)layout;

@end

typedef void(^BinderCallback)(ALKViewBinder *);

@interface UIView (XAutoLayoutKitEva)

- (ALKViewBinder *)alkBinder;

- (instancetype)alkLayout:(BinderCallback)aBlock;

- (instancetype)followSize:(BinderCallback) aBlock;
- (instancetype)followWidth:(BinderCallback) aBlock;
- (instancetype)followHeight:(BinderCallback) aBlock;
- (instancetype)followCenter:(BinderCallback) aBlock;
- (instancetype)followCenterX:(BinderCallback) aBlock;
- (instancetype)followCenterY:(BinderCallback) aBlock;

@end

NS_ASSUME_NONNULL_END
