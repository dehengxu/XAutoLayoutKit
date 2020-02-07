//
//  ScrollViewController.m
//  Demo
//
//  Created by Deheng Xu on 2020/1/8.
//

#import "ScrollViewController.h"

#import "ScrollViewController+Layout.h"

@interface ScrollViewController ()

@property (readonly) UIScrollView *scrollView;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.alwaysBounceVertical = true;
    self.scrollView.alwaysBounceHorizontal = true;
    [self loadSubviewWithFixedSize];
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

@end
