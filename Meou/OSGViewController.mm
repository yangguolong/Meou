//
//  OSGViewController.m
//  TestOSGIOS
//
//  Created by 林涛赵 on 15/5/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import "OSGViewController.h"
#import "OSGView.h"

#import "UIPresentViewController.h"
#import "UIPushViewController.h"

@implementation OSGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    OSGView *view = [[OSGView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    
    [self.view addSubview:view];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 50)];
    [button setTitle:@"PUSH" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(pushViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 410, self.view.frame.size.width, 50)];
    [button2 setTitle:@"PRESENT" forState: UIControlStateNormal];
    button2.backgroundColor = [UIColor redColor];
    [button2 addTarget:self action:@selector(presentViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)pushViewController
{
    UIPushViewController *vc = [[UIPushViewController alloc] init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)presentViewController
{
    UIPresentViewController *vc = [[UIPresentViewController alloc] init];
    [self presentViewController:vc animated:true completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
