//
//  ViewController.m
//  TestOSGIOS
//
//  Created by 杨国龙 on 15/5/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import "ViewController.h"
#import <OSGView.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    OSGView * view = [[OSGView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:view];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
