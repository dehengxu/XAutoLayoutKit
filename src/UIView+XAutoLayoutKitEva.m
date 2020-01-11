//
//  UIView+XAutoLayoutKitEva.m
//  Demo
//
//  Created by NicholasXu on 2019/12/10.
//

#import "UIView+XAutoLayoutKitEva.h"

@implementation ALKViewBinder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.value1 = ALKAutoLayoutValue.new;
        self.value2 = ALKAutoLayoutValue.new;

        [self configBlocks];
    }
    return self;
}

- (void)configBlocks
{
    __weak typeof(self)wself = self;

    self.equal = ^ALKViewBinder * _Nonnull{
        wself.value1.relation = ALKLayoutRelationEqual;
        return wself;
    };

    self.lessThanOrEqual = ^ALKViewBinder * _Nonnull{
        wself.value1.relation = ALKLayoutRelationLessThanOrEqual;
        return wself;
    };

    self.greatThanOrEqual = ^ALKViewBinder * _Nonnull{
        wself.value1.relation = ALKLayoutRelationGreaterThanOrEqual;
        return wself;
    };

    self.width = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeWidth;
        return wself;
    };
    self.height = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeHeight;
        return wself;
    };
    self.centerX = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeCenterX;
        return wself;
    };
    self.centerY = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeCenterY;
        return wself;
    };
    self.leading = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeLeading;
        return wself;
    };
    self.trailing = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeTrailing;
        return wself;
    };
    self.top = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeTop;
        return wself;
    };
    self.left = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeLeft;
        return wself;
    };
    self.bottom = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeBottom;
        return wself;
    };
    self.right = ^ALKViewBinder * _Nonnull{
        wself.value1.attribute = ALKLayoutAttributeRight;
        return wself;
    };

    self.to = ^ALKViewBinder * _Nonnull(UIView * _Nonnull view) {
        //wself.value2.payload = view;
        wself.slave = ALKViewBinder.new;
        wself.slave.value1.payload = view;
        return wself.slave;
    };

    self.multiply = ^ALKViewBinder * _Nonnull(CGFloat multiplier) {
        wself.value1.mutiplier = multiplier;
        return wself;
    };

    self.constant = ^ALKViewBinder * _Nonnull(CGFloat constants) {
        wself.value1.constants = constants;
        return wself;
    };

    self.alkLayout = ^{
        //if (!wself.value1) return;
        if (!wself.master && !wself.value1.payload) {//if slave
            return;
        }else if (!wself.value1.payload) {
            return;
        }
        NSLog(@"%s %d, %d", __func__, wself.master.value1.attribute, wself.value1.attribute);

        UIView *v1 = wself.master.value1.payload, *v2 = wself.value1.payload;
        BOOL isMaster = NO;
        if (wself.master) {//slave
            v1 = wself.master.value1.payload;
            v2 = wself.value1.payload;
            isMaster = NO;
        }else {//master
            v1 = wself.value1.payload;
            v2 = nil;//wself.slave.value1.payload;
            isMaster = YES;
        }

        //follow

        //inner

        //around

//        NSArray *constraints = @[
//            [NSLayoutConstraint constraintWithItem:v1 attribute:wself.value1.attribute relatedBy:wself.value1.relation toItem:v2 attribute:wself.value2.attribute multiplier:wself.value1.mutiplier constant:wself.value1.constants],
//        ];

        NSLayoutConstraint *constraint;
        if (!isMaster) {//Slave
            constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)wself.master.value1.attribute relatedBy:(NSLayoutRelation)wself.master.value1.relation toItem:v2 attribute:(NSLayoutAttribute)wself.value1.attribute multiplier:wself.master.value1.mutiplier constant:wself.master.value1.constants];
        }else {//Master
            constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)wself.value1.attribute relatedBy:(NSLayoutRelation)wself.value1.relation toItem:v2 attribute:(NSLayoutAttribute)wself.value1.attribute multiplier:wself.value1.mutiplier constant:wself.value1.constants];
        }

        [v1.superview addConstraint:constraint];
    };

}

- (void)setSlave:(ALKViewBinder *)slave
{
    _slave = slave;
    _slave.master = self;
}

- (void)setMultiplier:(CGFloat)multiplier
{
    self.value1.mutiplier = multiplier;
}

- (CGFloat)multiplier
{
    return self.value1.mutiplier;
}

- (void)setToView:(UIView *)toView
{
    self.value2.payload = toView;
}

- (UIView *)toView
{
    return self.value2.payload;
}

- (instancetype)toView:(UIView *)view
{
    self.value2.payload = view;
    return self;
}

- (instancetype)follow
{
    self.action = ALKActionFollow;
    return self;
}

- (instancetype)align
{
    self.action = ALKActionInner;
    return self;
}

- (instancetype)above
{
    self.action = ALKActionAround;
    return self;
}

- (void)layout
{
    if (!self.value1) return;
    if (!self.value2) return;
    UIView *v1 = self.value1.payload, *v2 = self.value2.payload;

    //follow

    //inner

    //around

    NSArray *constraints = @[
        [NSLayoutConstraint constraintWithItem:v1 attribute:self.value1.attribute relatedBy:self.value1.relation toItem:v2 attribute:self.value2.attribute multiplier:self.value1.mutiplier constant:self.value1.constants],
    ];
    [v1.superview addConstraints:constraints];
}

- (void)dealloc
{
    NSLog(@"%s", __func__);
}

@end

@implementation ALKAutoLayoutValue

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.constants = 0;
        self.mutiplier = 1.0;
    }
    return self;
}

- (instancetype)equal
{
    self.relation = ALKLayoutRelationEqual;
    return self;
}

- (instancetype)lessThanOrEqual
{
    self.relation = ALKLayoutRelationLessThanOrEqual;
    return self;
}

- (instancetype)greatThanOrEqual
{
    self.relation = ALKLayoutRelationGreaterThanOrEqual;
    return self;
}

- (instancetype)width
{
    self.attribute = ALKLayoutAttributeWidth;
    return self;
}

- (instancetype)height
{
    self.attribute = ALKLayoutAttributeHeight;
    return self;
}

- (instancetype)top
{
    self.attribute = ALKLayoutAttributeTop;
    return self;
}

- (instancetype)left
{
    self.attribute = ALKLayoutAttributeLeft;
    return self;
}

- (instancetype)bottom
{
    self.attribute = ALKLayoutAttributeBottom;
    return self;
}

- (instancetype)leading
{
    self.attribute = ALKLayoutAttributeLeading;
    return self;
}

- (instancetype)trailing
{
    self.attribute = ALKLayoutAttributeTrailing;
    return self;
}

- (instancetype)centerX
{
    self.attribute = ALKLayoutAttributeCenterX;
    return self;
}

- (instancetype)centerY
{
    self.attribute = ALKLayoutAttributeCenterY;
    return self;
}

- (instancetype)to:(UIView *)view
{
    self.payload = view;
    return self;
}

@end

@implementation UIView (XAutoLayoutKitEva)

- (instancetype)alkLayout:(BinderCallback)aBlock
{
    return self;
}

- (instancetype)followSize:(BinderCallback)aBlock
{
    [self followWidth:aBlock];
    [self followHeight:aBlock];
    return self;
}

- (instancetype)followWidth:(BinderCallback)aBlock
{
    ALKViewBinder *binder = self.alkBinder;
    [binder.follow.value1.equal.width to:self];
    aBlock(binder);
    [binder.value2.equal width];
    [binder layout];
    return self;
}

- (instancetype)followHeight:(BinderCallback)aBlock
{
    ALKViewBinder *binder = self.alkBinder;
    [binder.follow.value1.equal.height to:self];
    aBlock(binder);
    [binder.value2.equal height];
    [binder layout];
    return self;
}

- (instancetype)followCenter:(BinderCallback)aBlock
{
    return self;
}

- (instancetype)followCenterX:(BinderCallback)aBlock
{
    return self;
}

- (instancetype)followCenterY:(BinderCallback)aBlock
{
    return self;
}

- (ALKViewBinder *)alkBinder
{
    ALKViewBinder *b = [ALKViewBinder new];
    b.value1.payload = self;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    return b;
}

@end
