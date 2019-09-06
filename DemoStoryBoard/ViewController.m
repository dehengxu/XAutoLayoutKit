//
//  ViewController.m
//  DemoStoryBoard
//
//  Created by DehengXu on 15/2/6.
//
//

#import "ViewController.h"
#import "NSLayoutConstraint+Convenient.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.blackView.translatesAutoresizingMaskIntoConstraints = NO;
//    [NSLayoutConstraint addConstraintOnView:self.view withItem:self.blackView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"%@", self.blackView.constraints);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
