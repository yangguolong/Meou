//
//  UIPresentViewController.m
//  TestOSGIOS
//
//  Created by 林涛赵 on 15/5/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import "UIPresentViewController.h"
#import "OSGView.h"

@implementation UIPresentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    OSGView *view = [[OSGView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
//    
//    [self.view addSubview:view];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 50)];
    [button setTitle:@"BACK" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)back
{
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}
@end
