//
//  ModifyPWDViewController.m
//  Meou
//
//  Created by 杨国龙 on 15/9/28.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "ModifyPWDViewController.h"

@interface ModifyPWDViewController ()

@end

@implementation ModifyPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLeftBarItem];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitButtonClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
