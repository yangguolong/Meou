//
//  BaseViewCtrl.m
//  Fitroom3D
//
//  Created by 杨国龙 on 15/4/7.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import "BaseViewCtrl.h"
#import "BitmapUtils.h"
#import "AppMacro.h"
#import "UIColor+Util.h"
//#import "CDLoginViewCtrl.h"
@interface BaseViewCtrl () <UITextFieldDelegate,UIAlertViewDelegate>

@end

@implementation BaseViewCtrl

- (void)dealloc
{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.viewControllers.count > 1) {
        
        [self setupLeftBarItem];
    }
}

- (NSString *)leftBarItemHightIcon
{
    return @"btn_back_high";
}

- (void)setupLeftBarItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 15, 20);
//    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btn addTarget:self action:@selector(leftBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setBackgroundImage:[UIImage imageWithName:[self leftBarItemIcon]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:[self leftBarItemIcon]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:[self leftBarItemHightIcon]] forState:UIControlStateHighlighted];

    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)setupRightBarItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 40);
    [btn addTarget:self action:@selector(rightBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageWithName:[self rightBarItemIcon]] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageWithName:[self rightBarItemIcon]] forState:UIControlStateHighlighted];

    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
    
}

- (void)setupRightTitle:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(rightBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn setAttributedTitle:[self attributedStrWithText:[btn titleForState:UIControlStateNormal] Color:[UIColor whiteColor]] forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem =barItem;
    
}



/** 设置字体属性 */
- (NSMutableAttributedString *)attributedStrWithText:(NSString *)text Color:(UIColor *)color
{
    NSMutableAttributedString *attriButedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attriButedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, [attriButedStr length])];
    
    [attriButedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [attriButedStr length])];
    
    return attriButedStr;
}

- (void)leftBarItemPress:(id)sender
{
//     [self.navigationController popViewControllerAnimated:YES];
    if (self.navigationController.viewControllers.count > 1 ) {
        [self.navigationController popViewControllerAnimated:YES];
    
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

- (void)rightBarItemPress:(id)sender
{
    
}

- (NSString *)leftBarItemIcon
{
    return @"back";
}

- (NSString *)rightBarItemIcon
{
    return @"icon_refresh";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/** 点击返回键，隐藏键盘 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
}

@end
