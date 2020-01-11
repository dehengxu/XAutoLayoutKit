//
//  UIView+XAutoLayoutKitEva.m
//  Demo
//
//  Created by NicholasXu on 2019/12/10.
//

#import "UIView+XAutoLayoutKitEva.h"

@interface ALKViewBinder ()

@property (nonatomic, copy) ALKViewBinder *(^to)(UIView *view);
@property (nonatomic, copy) void(^alkLayout)();

@property (nonatomic, copy) ALKViewBinder *(^multiply)(CGFloat multiplier);
@property (nonatomic, copy) ALKViewBinder *(^constant)(CGFloat constants);

@end

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
    __strong typeof(wself)sself = wself;

//    self.equal = ^ALKViewBinder * _Nonnull{
//        wself.value1.relation = ALKLayoutRelationEqual;
//        return wself;
//    };
//
//    self.lessThanOrEqual = ^ALKViewBinder * _Nonnull{
//        wself.value1.relation = ALKLayoutRelationLessThanOrEqual;
//        return wself;
//    };
//
//    self.greatThanOrEqual = ^ALKViewBinder * _Nonnull{
//        wself.value1.relation = ALKLayoutRelationGreaterThanOrEqual;
//        return wself;
//    };

//    self.width = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeWidth;
//        return wself;
//    };
//    self.height = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeHeight;
//        return wself;
//    };
//    self.centerX = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeCenterX;
//        return wself;
//    };
//    self.centerY = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeCenterY;
//        return wself;
//    };
//    self.leading = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeLeading;
//        return wself;
//    };
//    self.trailing = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeTrailing;
//        return wself;
//    };
//    self.top = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeTop;
//        return wself;
//    };
//    self.left = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeLeft;
//        return wself;
//    };
//    self.bottom = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeBottom;
//        return wself;
//    };
//    self.right = ^ALKViewBinder * _Nonnull{
//        wself.value1.attribute = ALKLayoutAttributeRight;
//        return wself;
//    };

    self.to = ^ALKViewBinder * _Nonnull(UIView * _Nonnull view) {
        //wself.value2.payload = view;
        sself.slave = ALKViewBinder.new;
        sself.slave.value1.payload = view;
        return sself.slave;
    };

    self.multiply = ^ALKViewBinder * _Nonnull(CGFloat multiplier) {
        sself.value1.mutiplier = multiplier;
        return sself;
    };

    self.constant = ^ALKViewBinder * _Nonnull(CGFloat constants) {
        sself.value1.constants = constants;
        return sself;
    };

    self.alkLayout = ^{
        //if (!wself.value1) return;
        if (!sself.master && !sself.value1.payload) {//if slave
            return;
        }else if (!sself.value1.payload) {
            return;
        }
        //NSLog(@"%s %d, %d", __func__, sself.master.value1.attribute, sself.value1.attribute);

        UIView *v1 = sself.master.value1.payload, *v2 = sself.value1.payload;
        BOOL isMaster = NO;
        if (sself.master) {//slave
            v1 = sself.master.value1.payload;
            v2 = sself.value1.payload;
            isMaster = NO;
        }else {//master
            v1 = sself.value1.payload;
            v2 = nil;//wself.slave.value1.payload;
            isMaster = YES;
        }

        //follow

        //inner

        //around

        NSLayoutConstraint *constraint;
        if (!isMaster) {//Slave
            constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)sself.master.value1.attribute relatedBy:(NSLayoutRelation)sself.master.value1.relation toItem:v2 attribute:(NSLayoutAttribute)sself.value1.attribute multiplier:sself.master.value1.mutiplier constant:sself.master.value1.constants];
        }else {//Master
            constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)sself.value1.attribute relatedBy:(NSLayoutRelation)sself.value1.relation toItem:v2 attribute:(NSLayoutAttribute)sself.value1.attribute multiplier:sself.value1.mutiplier constant:sself.value1.constants];
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

- (ALKViewBinder *)equal
{
    [self.value1 equal];
    return self;
}

- (ALKViewBinder *)lessThanOrEqual
{
    [self.value1 lessThanOrEqual];
    return self;
}

- (ALKViewBinder *)greatThanOrEqual
{
    [self.value1 greatThanOrEqual];
    return self;
}

- (ALKViewBinder *)width
{
    [self.value1 width];
    return self;
}

- (ALKViewBinder *)height
{
    [self.value1 height];
    return self;
}

- (ALKViewBinder *)centerX
{
    [self.value1 centerX];
    return self;
}

- (ALKViewBinder *)centerY
{
    [self.value1 centerY];
    return self;
}

- (ALKViewBinder *)leading
{
    [self.value1 leading];
    return self;
}

- (ALKViewBinder *)trailing
{
    [self.value1 trailing];
    return self;
}

- (ALKViewBinder *)top
{
    [self.value1 top];
    return self;
}

- (ALKViewBinder *)left
{
    [self.value1 left];
    return self;
}

- (ALKViewBinder *)bottom
{
    [self.value1 bottom];
    return self;
}

- (ALKViewBinder *)right
{
    [self.value1 right];
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@" attribute: %ld, relation: %ld", (NSInteger)self.value1.attribute, (NSInteger)self.value1.relation];
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

//- (instancetype)alkLayout:(BinderCallback)aBlock
//{
//    return self;
//}
//
//- (instancetype)followSize:(BinderCallback)aBlock
//{
//    [self followWidth:aBlock];
//    [self followHeight:aBlock];
//    return self;
//}
//
//- (instancetype)followWidth:(BinderCallback)aBlock
//{
//    ALKViewBinder *binder = self.alkBinder;
//    [binder.follow.value1.equal.width to:self];
//    aBlock(binder);
//    [binder.value2.equal width];
//    [binder layout];
//    return self;
//}
//
//- (instancetype)followHeight:(BinderCallback)aBlock
//{
//    ALKViewBinder *binder = self.alkBinder;
//    [binder.follow.value1.equal.height to:self];
//    aBlock(binder);
//    [binder.value2.equal height];
//    [binder layout];
//    return self;
//}
//
//- (instancetype)followCenter:(BinderCallback)aBlock
//{
//    return self;
//}
//
//- (instancetype)followCenterX:(BinderCallback)aBlock
//{
//    return self;
//}
//
//- (instancetype)followCenterY:(BinderCallback)aBlock
//{
//    return self;
//}

- (ALKViewBinder *)alkBinder
{
    ALKViewBinder *b = [ALKViewBinder new];
    b.value1.payload = self;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    return b;
}

@end
