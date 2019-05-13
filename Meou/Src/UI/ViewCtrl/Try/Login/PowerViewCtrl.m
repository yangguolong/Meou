//
//  PowerViewCtrl.m
//  Meou
//
//  Created by 杨国龙 on 15/10/17.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "PowerViewCtrl.h"

@interface PowerViewCtrl ()

@end

@implementation PowerViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backButtonClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
