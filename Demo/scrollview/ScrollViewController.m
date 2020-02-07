//
//  ScrollViewController.m
//  Demo
//
//  Created by Deheng Xu on 2020/1/8.
//

#import "ScrollViewController.h"

#import "ScrollViewController+Layout.h"
#import "ViewModel.h"

@interface ScrollViewController ()

@property (readonly) UIScrollView *scrollView;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.alwaysBounceVertical = true;
    self.scrollView.alwaysBounceHorizontal = true;
    //[self loadSubviewWithFixedSize];
    [self loadDynamicLayouts];
}

- (UIScrollView *)scrollView
{
    if ([self.view isKindOfClass:UIScrollView.class]) {
        return (UIScrollView *)self.view;
    }
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadSubviewWithFixedSize
{
    UIView *sv = [UIView new];
    sv.backgroundColor = UIColor.orangeColor;
    sv.frame = (CGRect){10, 10, 100, 100};
    sv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:sv];

}

- (void)loadSubviewFloating
{
}

- (void)loadDynamicLayouts
{
    CGFloat fontSize = 14.0, iconw = 18.0;

    UIView *icon = [UIView new];
    icon.backgroundColor = UIColor.purpleColor;
    
    UIView *panel = [UIView new];
    UILabel *guideLabel1, *guideLabel2;
    guideLabel1 = [UILabel new];
    guideLabel2 = [UILabel new];
    guideLabel1.font = [UIFont systemFontOfSize:fontSize];
    guideLabel2.font = [UIFont systemFontOfSize:fontSize];
    
    UILabel *titleLabel = [UILabel new];
    guideLabel1.lineBreakMode = NSLineBreakByTruncatingTail;
    
    UILabel *descLabel = [UILabel new];
    titleLabel.font = [UIFont systemFontOfSize:fontSize];
    descLabel.font = [UIFont systemFontOfSize:fontSize];
    titleLabel.textColor = UIColor.darkGrayColor;
    descLabel.textColor = UIColor.darkGrayColor;
    descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    descLabel.numberOfLines = 2;
    
    UIButton *submitButton = [UIButton new];
    submitButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [submitButton setTitleColor:UIColor.darkGrayColor forState:UIControlStateNormal];
    
    ViewModel *vm = [ViewModel new];
    vm.desc = @"XxxxxxXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    vm.title = @"xw123456";
    vm.btnTitle = @"山穷水复疑无路W";
    
    guideLabel1.text = vm.title;
    guideLabel2.text = vm.btnTitle;
    
    titleLabel.text = vm.title;
    [submitButton setTitle:vm.btnTitle forState:UIControlStateNormal];
    submitButton.backgroundColor = UIColor.redColor;
    submitButton.layer.cornerRadius = 5.0;
    panel.frame = (CGRect){0, 100, CGRectGetWidth(self.view.frame), 107 + (vm.desc.length ? 20:0) };
    descLabel.text = vm.desc;
    
    NSLog(@"panel: %@, guideLabel1: %@, guideLabel2: %@", NSStringFromCGSize(panel.frame.size), NSStringFromCGSize(guideLabel1.intrinsicContentSize), NSStringFromCGSize(guideLabel2.intrinsicContentSize));
    CGFloat dy = 10;
    CGFloat edgex = 5.0;
    CGFloat dx = 10.0;
    CGFloat inner = 10.0;
    CGFloat contentWidth = edgex * 2 + iconw + dx + guideLabel1.intrinsicContentSize.width + dx + guideLabel2.intrinsicContentSize.width + inner * 2;
    
    CGRect originFrame = CGRectZero;
    CGSize panelSize = panel.frame.size;

    CGFloat(^midOffset)(CGFloat) = ^(CGFloat w){
        return (panelSize.width - w) / 2.0;
    };
    
    if (contentWidth > CGRectGetWidth(panel.frame)) {
        //triple lines
        NSLog(@"triple lines");
        CGFloat titleWidth = MIN(panelSize.width - (edgex * 2) - iconw - dx, guideLabel1.intrinsicContentSize.width);
        CGFloat(^firstLineOffset)() = ^(){
            CGSize panelSize = panel.frame.size;
            CGFloat contentWidth = edgex * 2 + iconw + dx + titleWidth;
            return ((panelSize.width - contentWidth) / 2.0);
        };
        //Icon
        originFrame = icon.frame;
        originFrame.origin.y = dy;
        originFrame.origin.x = firstLineOffset() + edgex;
        originFrame.size = (CGSize){iconw, iconw};
        icon.frame = originFrame;
        //Title
        originFrame = titleLabel.frame;
        originFrame.origin.x = firstLineOffset() + edgex + iconw + dx;
        originFrame.origin.y = dy;
        originFrame.size.width = titleWidth;
        originFrame.size.height = guideLabel1.intrinsicContentSize.height;
        titleLabel.frame = originFrame;
        //Button
        originFrame = submitButton.frame;
        originFrame.origin.x = midOffset(guideLabel2.intrinsicContentSize.width + inner * 2);
        originFrame.origin.y = CGRectGetMaxY(titleLabel.frame) + 5.0;
        originFrame.size = (CGSize){guideLabel2.intrinsicContentSize.width + inner * 2, guideLabel2.intrinsicContentSize.height + inner * 2};
        submitButton.frame = originFrame;
    }else {
        //double lines
        NSLog(@"double lines");
        CGFloat(^firstLineOffset)() = ^(){
            CGSize panelSize = panel.frame.size;
            CGFloat contentWidth = iconw + dx + guideLabel1.intrinsicContentSize.width + dx + guideLabel2.intrinsicContentSize.width + inner * 2;
            
            return ((panelSize.width - contentWidth) / 2.0);
        };
        
        originFrame = icon.frame;
        originFrame.origin.x = firstLineOffset();
        originFrame.size = (CGSize){iconw, iconw};
        icon.frame = originFrame;
        
        originFrame = titleLabel.frame;
        originFrame.origin.x = firstLineOffset() + iconw + dx;
        originFrame.origin.y = 4;
        originFrame.size = guideLabel1.intrinsicContentSize;
        originFrame.size.width += 20;
        titleLabel.frame = originFrame;
        
        originFrame = submitButton.frame;
        originFrame.origin.x = firstLineOffset() + iconw + dx +  guideLabel1.intrinsicContentSize.width + dx;
        originFrame.size = (CGSize){guideLabel2.intrinsicContentSize.width + inner  * 2, guideLabel2.intrinsicContentSize.height + inner * 2};
        submitButton.frame = originFrame;
    }
    
    [panel addSubview:icon];
    [panel addSubview:titleLabel];
    [panel addSubview:descLabel];
    [panel addSubview:submitButton];
    panel.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:panel];
    
}
    
@end
