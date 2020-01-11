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
@interface XALKAutoLayoutValue ()

@property (nonatomic, assign) XALKAttribute attribute;
@property (nonatomic, assign) XALKRelation relation;
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

@interface XALKViewBinder ()

// Used for convenience
//@property ALKAction action;

@property (nonatomic, weak) XALKViewBinder *master;
@property (nonatomic, strong) XALKViewBinder *slave;

@property (strong) XALKAutoLayoutValue *value1;
@property (strong) XALKAutoLayoutValue *value2;

//@property (nonatomic, strong) UIView *toView;


//@property (nonatomic, copy) XALKViewBinder *(^align)(void);
//@property (nonatomic, copy) XALKViewBinder *(^follow)(UIView *view);

@end

typedef void(^BinderCallback)(XALKViewBinder *);

NS_ASSUME_NONNULL_END
