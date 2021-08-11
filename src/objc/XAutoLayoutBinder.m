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
    } else if (@available(iOS 9.0, *)) {\
    self.anchor = self.payload.DIRECT##Anchor;\
}\
}while(0)

typedef NS_OPTIONS (long, AttributeState) {
    SETUP_NONE      = 0,
    SETUP_TOP       = 1,
    SETUP_BOTTOM      = 1 << 1,
    SETUP_LEFT      = 1 << 2,
    SETUP_RIGHT     = 1 << 3,
    SETUP_WIDTH     = 1 << 4,
    SETUP_HEIGHT    = 1 << 5,
    SETUP_CENTERX = 1 << 6,
    SETUP_CENTERY = 1 << 7,
    SETUP_LEADING = 1 << 8,
    SETUP_TRAILING = 1 << 9,
};

@interface XALKViewBinder () {
    AttributeState _attributeState;
    BOOL _constantState;
}

@property (nonatomic, copy) XALKViewBinder * (^ to)(UIView *view);

@property (nonatomic, copy) UIView* (^ xalkLayout)(void);
@property (nonatomic, copy) UIView* (^ end)(void);

@property (nonatomic, copy) XALKViewBinder * (^ multiply)(CGFloat multiplier);
@property (nonatomic, copy) XALKViewBinder * (^ constant)(CGFloat constants);

@property (nonatomic, copy) XALKViewBinder * (^ multiplyNumber)(NSNumber* multiplier);
@property (nonatomic, copy) XALKViewBinder * (^ constantNumber)(NSNumber* constants);

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

    self.to = ^XALKViewBinder *_Nonnull (UIView *_Nonnull view) {
		__strong typeof(wself) self = wself;
        //BOOL b = view.translatesAutoresizingMaskIntoConstraints;
		self.slave = view.secondaryBinder;
//		self.slave.useAnchor = self.useAnchor;
//        if (self.isSafeArea) {
//            [self.slave safeArea];
//        }
        return self.slave;
    };

    self.multiply = ^XALKViewBinder *_Nonnull (CGFloat multiplier) {
        __strong typeof(wself) self = wself;
		self.value1.mutiplier = multiplier;
        return self;
    };

    self.constant = ^XALKViewBinder *_Nonnull (CGFloat constants) {
        __strong typeof(wself) self = wself;
        self->_constantState = YES;
		self.value1.constants = constants;
        return self;
    };

	self.multiplyNumber = ^XALKViewBinder* _Nonnull (NSNumber *multiplier) {
		__strong typeof(wself) self = wself;
		self.value1.mutiplier = multiplier.floatValue;
		return self;
	};

	self.constantNumber = ^XALKViewBinder* _Nonnull (NSNumber* constant) {
		__strong typeof(wself) self = wself;
		self.value1.constants = constant.floatValue;
		return self;
	};
    
    self.xalkLayout = ^UIView* {
        __strong typeof(wself) self = wself;

		UIView *v1 = nil;
		if (self.master) {
			v1 = self.master.value1.payload;
		}else {
			v1 = self.value1.payload;
		}

		NSLayoutConstraint *constraint = [self xalkConstraint];
        if (!constraint) return v1;

        //Install constraint
        [v1.superview addConstraint:constraint];
		return v1;
    };

	self.end = self.xalkLayout;
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
    _attributeState |= SETUP_WIDTH;
    [self.value1 width];
    return self;
}

- (XALKViewBinder *)height
{
    _attributeState |= SETUP_HEIGHT;
    [self.value1 height];
    return self;
}

- (XALKViewBinder *)centerX
{
    _attributeState |= SETUP_CENTERX;
    [self.value1 centerX];
    return self;
}

- (XALKViewBinder *)centerY
{
    _attributeState |= SETUP_CENTERY;
    [self.value1 centerY];
    return self;
}

- (XALKViewBinder *)leading
{
    _attributeState |= SETUP_LEADING;
    [self.value1 leading];
    return self;
}

- (XALKViewBinder *)trailing
{
    _attributeState |= SETUP_TRAILING;
    [self.value1 trailing];
    return self;
}

- (XALKViewBinder *)top
{
    _attributeState |= SETUP_TOP;
    [self.value1 top];
    return self;
}

- (XALKViewBinder *)left
{
    _attributeState |= SETUP_LEFT;
    [self.value1 left];
    return self;
}

- (XALKViewBinder *)bottom
{
    _attributeState |= SETUP_BOTTOM;
    [self.value1 bottom];
    return self;
}

- (XALKViewBinder *)right
{
    _attributeState |= SETUP_RIGHT;
    [self.value1 right];
    return self;
}

- (instancetype)anchor {
//    if (!_isSafeArea) {
//        NSAssert(false, @"safeArea must called ahead");
//        return self;
//    }
    _useAnchor = YES;
    _value1.useAnchor = _useAnchor;
    _value2.useAnchor = _useAnchor;
    return self;
}

- (instancetype)safeArea
{
    _isSafeArea = YES;
    _value1.isSafeArea = YES;
    [self anchor];
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@" attribute: %ld, relation: %ld", (NSInteger)self.value1.attribute, (NSInteger)self.value1.relation];
}

- (NSLayoutConstraint *)xalkConstraint {
    //if (!wself.value1) return;
    if (self.master && !self.slave) {
        if (self.master->_attributeState && self->_attributeState) {} else {
            NSAssert(false, @"both of views should setup attributes");
        }
    }else if (self.slave && !self.master) {
        if (self->_attributeState && self.slave->_attributeState) {} else {
            NSAssert(false, @"both of views should setup attributes");
        }
    }else {
        NSAssert(self->_constantState, @"layout views setup issues.");// use absolute constant value
    }

    if (!self.master && !self.value1.payload) {//if slave
        return nil;
    } else if (!self.value1.payload) {
        return nil;
    }
    //NSLog(@"%s %d, %d", __func__, sself.master.value1.attribute, sself.value1.attribute);
    
    UIView *v1 = self.master.value1.payload, *v2 = self.value1.payload;
    BOOL isMaster = NO;
    if (self.master) {//slave
        v1 = self.master.value1.payload;
        v2 = self.value1.payload;
        isMaster = NO;
    } else {//master
        v1 = self.value1.payload;
        v2 = nil;
        isMaster = YES;
    }
    
    //Generate constraint
    
    NSLayoutConstraint *constraint;
    if (!isMaster) {//Slave
        if (self.useAnchor) {
            switch (self.master.value1.relation) {
            case NSLayoutRelationEqual: {
                constraint = [self.master.value1.anchor constraintEqualToAnchor:self.value1.anchor constant:self.master.value1.constants];
            }
                break;
            case NSLayoutRelationLessThanOrEqual: {
                constraint = [self.master.value1.anchor constraintLessThanOrEqualToAnchor:self.value1.anchor constant:self.master.value1.constants];
            }
                break;
            case NSLayoutRelationGreaterThanOrEqual: {
                constraint = [self.master.value1.anchor constraintGreaterThanOrEqualToAnchor:self.value1.anchor constant:self.master.value1.constants];
            }
                break;
            }
        } else {
            constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)self.master.value1.attribute relatedBy:(NSLayoutRelation)self.master.value1.relation toItem:v2 attribute:(NSLayoutAttribute)self.value1.attribute multiplier:self.master.value1.mutiplier constant:self.master.value1.constants];
            
        }
    } else {//Master
        if (self.useAnchor) {
            switch (self.value1.relation) {
            case NSLayoutRelationEqual: {
                constraint = [self.value1.anchor constraintEqualToAnchor:self.value2.anchor constant:self.value1.constants];
            }
                break;
            case NSLayoutRelationLessThanOrEqual: {
                constraint = [self.value1.anchor constraintLessThanOrEqualToAnchor:self.value2.anchor constant:self.value1.constants];
            }
                break;
            case NSLayoutRelationGreaterThanOrEqual: {
                constraint = [self.value1.anchor constraintGreaterThanOrEqualToAnchor:self.value2.anchor constant:self.value1.constants];
            }
                break;
            }
        } else {
            constraint = [NSLayoutConstraint constraintWithItem:v1 attribute:(NSLayoutAttribute)self.value1.attribute relatedBy:(NSLayoutRelation)self.value1.relation toItem:v2 attribute:(NSLayoutAttribute)self.value1.attribute multiplier:self.value1.mutiplier constant:self.value1.constants];
        }
    }
    constraint.identifier = @"XALKBinder";
    return constraint;
}

#if false
- (void)dealloc
{
    NSLog(@"%s", __func__);
}
#endif

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
    //self.anchor = self.payload.widthAnchor;
    AdoptedAnchor(width);
    self.attribute = XALKLayoutAttributeWidth;
    return self;
}

- (instancetype)height
{
    AdoptedAnchor(height);
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

//- (instancetype)to:(UIView *)view
//{
//    self.payload = view;
//    return self;
//}

@end

@implementation UIView (XAutoLayoutKitEva)

- (XALKViewBinder *)xalkBinder
{
    return [self primaryBinder];
}

- (XALKViewBinder *)xalk
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
