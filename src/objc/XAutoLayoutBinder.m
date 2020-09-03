//
//  XAutoLayoutBinder.m
//  Demo
//
//  Created by NicholasXu on 2019/12/10.
//

#import "XAutoLayoutBinder.h"
#import "XAutoLayoutBinder+Private.h"

#define AdoptedAnchor(DIRECT) \
do {\
    if (@available(iOS 11.0, *)) {\
    self.anchor = (_isSafeArea) ? self.payload.safeAreaLayoutGuide.DIRECT##Anchor:  self.payload.DIRECT##Anchor;\
    } else {\
    self.anchor = self.payload.DIRECT##Anchor;\
}\
}while(0)

@interface XALKViewBinder ()

@property (nonatomic, copy) XALKViewBinder * (^ to)(UIView *view);

@property (nonatomic, copy) void (^ xalkLayout)(void);

@property (nonatomic, copy) XALKViewBinder * (^ multiply)(CGFloat multiplier);
@property (nonatomic, copy) XALKViewBinder * (^ constant)(CGFloat constants);

@end

@implementation XALKViewBinder

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.value1 = XALKAutoLayoutValue.new;
        self.value2 = XALKAutoLayoutValue.new;
        self.useAnchor = false;
        [self configBlocks];
    }
    return self;
}

- (void)configBlocks
{
    __weak typeof(self) wself = self;
    __strong typeof(wself) sself = wself;

    self.to = ^XALKViewBinder *_Nonnull (UIView *_Nonnull view) {
        sself.slave = [view secondaryBinder];
        sself.slave.useAnchor = sself.useAnchor;
        return sself.slave;
    };

    self.multiply = ^XALKViewBinder *_Nonnull (CGFloat multiplier) {
        sself.value1.mutiplier = multiplier;
        return sself;
    };

    self.constant = ^XALKViewBinder *_Nonnull (CGFloat constants) {
        sself.value1.constants = constants;
        return sself;
    };

    self.xalkLayout = ^{
        //if (!wself.value1) return;
        if (!sself.master && !sself.value1.payload) {//if slave
            return;
        } else if (!sself.value1.payload) {
            return;
        }
        //NSLog(@"%s %d, %d", __func__, sself.master.value1.attribute, sself.value1.attribute);

        UIView *v1 = sself.master.value1.payload, *v2 = sself.value1.payload;
        BOOL isMaster = NO;
        if (sself.master) {//slave
            v1 = sself.master.value1.payload;
            v2 = sself.value1.payload;
            isMaster = NO;
        } else {//master
            v1 = sself.value1.payload;
            v2 = nil;//wself.slave.value1.payload;
            isMaster = YES;
        }

        //Generate constraint
        
        NSLayoutConstraint *constraint;
        if (!isMaster) {//Slave
            if (sself.useAnchor) {
                switch (sself.master.value1.relation) {
                    case NSLayoutRelationEqual: {
                        constraint = [sself.master.value1.anchor constraintEqualToAnchor:sself.value1.anchor constant:sself.master.value1.constants];
                    }
                    break;
                    case NSLayoutRelationLessThanOrEqual: {
                        constraint = [sself.master.value1.anchor constraintLessThanOrEqualToAnchor:sself.value1.anchor constant:sself.master.value1.constants];
                    }
                    break;
                    case NSLayoutRelationGreaterThanOrEqual: {
                        constraint = [sself.master.value1.anchor constraintGreaterThanOrEqualToAnchor:sself.value1.anchor constant:sself.master.value1.constants];
                    }
                    break;
                }
                [constraint setActive:true];
            } else {
                constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)sself.master.value1.attribute relatedBy:(NSLayoutRelation)sself.master.value1.relation toItem:v2 attribute:(NSLayoutAttribute)sself.value1.attribute multiplier:sself.master.value1.mutiplier constant:sself.master.value1.constants];
            }
        } else {//Master
            if (sself.useAnchor) {
                switch (sself.value1.relation) {
                    case NSLayoutRelationEqual: {
                        constraint = [sself.value1.anchor constraintEqualToAnchor:sself.value2.anchor constant:sself.value1.constants];
                    }
                    break;
                    case NSLayoutRelationLessThanOrEqual: {
                        constraint = [sself.value1.anchor constraintLessThanOrEqualToAnchor:sself.value2.anchor constant:sself.value1.constants];
                    }
                    break;
                    case NSLayoutRelationGreaterThanOrEqual: {
                        constraint = [sself.value1.anchor constraintGreaterThanOrEqualToAnchor:sself.value2.anchor constant:sself.value1.constants];
                    }
                    break;
                }
                constraint.active = true;
            } else {
                constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)sself.value1.attribute relatedBy:(NSLayoutRelation)sself.value1.relation toItem:v2 attribute:(NSLayoutAttribute)sself.value1.attribute multiplier:sself.value1.mutiplier constant:sself.value1.constants];
            }
        }
        
        //Install constraint
        [v1.superview addConstraint:constraint];
    };
}

- (void)setSlave:(XALKViewBinder *)slave
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

- (XALKViewBinder *)equal
{
    [self.value1 equal];
    return self;
}

- (XALKViewBinder *)lessThanOrEqual
{
    [self.value1 lessThanOrEqual];
    return self;
}

- (XALKViewBinder *)greatThanOrEqual
{
    [self.value1 greatThanOrEqual];
    return self;
}

- (XALKViewBinder *)width
{
    [self.value1 width];
    return self;
}

- (XALKViewBinder *)height
{
    [self.value1 height];
    return self;
}

- (XALKViewBinder *)centerX
{
    [self.value1 centerX];
    return self;
}

- (XALKViewBinder *)centerY
{
    [self.value1 centerY];
    return self;
}

- (XALKViewBinder *)leading
{
    [self.value1 leading];
    return self;
}

- (XALKViewBinder *)trailing
{
    [self.value1 trailing];
    return self;
}

- (XALKViewBinder *)top
{
    [self.value1 top];
    return self;
}

- (XALKViewBinder *)left
{
    [self.value1 left];
    return self;
}

- (XALKViewBinder *)bottom
{
    [self.value1 bottom];
    return self;
}

- (XALKViewBinder *)right
{
    [self.value1 right];
    return self;
}

- (instancetype)anchor {
    _useAnchor = YES;
    _value1.useAnchor = _useAnchor;
    _value2.useAnchor = _useAnchor;
    return self;
}

- (instancetype)safeArea
{
    _isSafeArea = YES;
    _value1.isSafeArea = YES;
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

@implementation XALKAutoLayoutValue

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.constants = 0;
        self.mutiplier = 1.0;
    }
    return self;
}

#pragma mark -  relation

- (instancetype)equal
{
    self.relation = XALKLayoutRelationEqual;
    return self;
}

- (instancetype)lessThanOrEqual
{
    self.relation = XALKLayoutRelationLessThanOrEqual;
    return self;
}

- (instancetype)greatThanOrEqual
{
    self.relation = XALKLayoutRelationGreaterThanOrEqual;
    return self;
}

#pragma mark - dimension

- (instancetype)width
{
    self.anchor = self.payload.widthAnchor;
    self.attribute = XALKLayoutAttributeWidth;
    return self;
}

- (instancetype)height
{
    self.anchor = self.payload.heightAnchor;
    self.attribute = XALKLayoutAttributeHeight;
    return self;
}

- (instancetype)top
{
    AdoptedAnchor(top);
    self.attribute = XALKLayoutAttributeTop;
    return self;
}

- (instancetype)left
{
    AdoptedAnchor(left);
    
    self.attribute = XALKLayoutAttributeLeft;
    return self;
}

- (instancetype)right
{
    AdoptedAnchor(right);
    self.attribute = XALKLayoutAttributeRight;
    return self;
}

- (instancetype)bottom
{
    AdoptedAnchor(bottom);
    self.attribute = XALKLayoutAttributeBottom;
    return self;
}

- (instancetype)leading
{
    AdoptedAnchor(leading);
    self.attribute = XALKLayoutAttributeLeading;
    return self;
}

- (instancetype)trailing
{
    AdoptedAnchor(trailing);
    self.attribute = XALKLayoutAttributeTrailing;
    return self;
}

- (instancetype)centerX
{
    AdoptedAnchor(centerX);
    self.attribute = XALKLayoutAttributeCenterX;
    return self;
}

- (instancetype)centerY
{
    AdoptedAnchor(centerY);
    self.attribute = XALKLayoutAttributeCenterY;
    return self;
}

- (instancetype)to:(UIView *)view
{
    self.payload = view;
    return self;
}

@end

@implementation UIView (XAutoLayoutKitEva)

- (XALKViewBinder *)xalkBinder
{
    return [self primaryBinder];
}

- (XALKViewBinder *)primaryBinder {
    XALKViewBinder *b = [XALKViewBinder new];
    b.value1.payload = self;
    self.translatesAutoresizingMaskIntoConstraints = NO;
    return b;
}

- (XALKViewBinder *)secondaryBinder {
	XALKViewBinder *b = [XALKViewBinder new];
	b.value1.payload = self;
	return b;
}

@end
