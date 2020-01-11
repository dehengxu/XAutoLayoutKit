//
//  UIView+XAutoLayoutKitEva.h
//  Demo
//
//  Created by NicholasXu on 2019/12/10.
//

#import <UIKit/UIKit.h>
#import "XAutoLayoutKitEva.h"

NS_ASSUME_NONNULL_BEGIN

/// Represent a constraint rule
@interface ALKAutoLayoutValue ()

//@property (nonatomic, assign) ALKValueType type;
//@property (nonatomic, strong) ALKAutoLayoutValue *target;

@property (nonatomic, assign) ALKAttribute attribute;
@property (nonatomic, assign) ALKRelation relation;
@property (nonatomic, assign) CGFloat constants;
@property (nonatomic, assign) CGFloat mutiplier;
@property (nonatomic, strong) UIView *payload;

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

@interface ALKViewBinder ()

// Used for convenience
//@property ALKAction action;

@property (nonatomic, weak) ALKViewBinder *master;
@property (nonatomic, strong) ALKViewBinder *slave;

@property (strong) ALKAutoLayoutValue *value1;
@property (strong) ALKAutoLayoutValue *value2;

//@property (nonatomic, strong) UIView *toView;


//@property (nonatomic, copy) ALKViewBinder *(^align)(void);
//@property (nonatomic, copy) ALKViewBinder *(^follow)(UIView *view);

@end

typedef void(^BinderCallback)(ALKViewBinder *);

NS_ASSUME_NONNULL_END
