//
//  NSLayoutConstraint+XALK.h
//  Demo
//
//  Created by Deheng Xu on 2020/1/11.
//

#import <UIKit/UIKit.h>

#ifndef XALK_WARN_UNUSED_RESULT
#define XALK_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#endif

#ifndef XALK_DEPRECATED_MSG
#define XALK_DEPRECATED_MSG(x) __deprecated_msg(x)
#endif

NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (XALK)

+ (NSArray *)defaultConstraintsWithFormat:(NSString *)format views:(NSDictionary *)views XALK_WARN_UNUSED_RESULT;
+ (void)setConstraintsWithView:(UIView *)view size:(CGSize)size;
+ (void)followViewCenterX:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenterY:(UIView *)v1 withView:(UIView *)v2;
+ (void)followViewCenter:(UIView *)v1 withView:(UIView *)v2;

+ (void)addConstraintOnView:(UIView *)view withItem:(UIView *)view1 attribute:(NSLayoutAttribute)attr1 relatedBy:(NSLayoutRelation)relation toItem:(id)view2 attribute:(NSLayoutAttribute)attr2 multiplier:(CGFloat)multiplier constant:(CGFloat)c;

+ (void)addConstraintsOnView:(id)view withVisualFormat:(NSString *)format options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views;


@end

NS_ASSUME_NONNULL_END
