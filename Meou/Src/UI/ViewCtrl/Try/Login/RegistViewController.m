//
//  RegistViewController.m
//  Meou
//
//  Created by 杨国龙 on 15/10/12.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "RegistViewController.h"
#import "VCButton.h"
#import "NSString+Category.h"
#import "CDService.h"
@interface RegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet VCButton *getVCodeButton;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTitleView];
}

- (void)initTitleView
{
    if (_action == RegisterAction) {

           self.navigationItem.title =@"注册";
    }else if(_action == ModifyPWDAction){
        self.navigationItem.title =@"重置密码";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)getVcodeButtonClick:(UIButton *)sender {
        [[CDService shareInstance] authcodeByPhone:_phoneTextField.text success:^(NSString *result) {
            
           [self.view showHUDWith:result hideAfterDelay:ACTIVITY_SHOW_TIME];
        } failure:^(NSString *reason) {
            [self.view hideHUD];
            [self.view showHUDWith:reason hideAfterDelay:ACTIVITY_SHOW_TIME];
        }];
    [_getVCodeButton startCountDown];

}
- (IBAction)registButtonClick:(UIButton *)sender {
//    if (![_phoneTextField.text isMobileNumber]) {
//        
//        [self.view showHUDWith:@"请填写正确手机号码" hideAfterDelay:ACTIVITY_SHOW_TIME];
//        return;
//    }
//    if (_passWordTextField.text.length > 16 && _passWordTextField.text.length < 6) {
//        [self.view showHUDWith:@"请输入6~16位密码" hideAfterDelay:ACTIVITY_SHOW_TIME];
//        return;
//    }
    if (_action == RegisterAction) {
        [self regist];
    }else if(_action == ModifyPWDAction){
       [self modifyPWD];
    }
}

- (void)modifyPWD
{
    [self.view showHUDWith:@""];
    [[CDService shareInstance] resetPasswordWithPhone:_phoneTextField.text authcode:_codeTextField.text newPassword:_passWordTextField.text success:^(NSString *result) {
        [super leftBarItemPress:nil];
        [self.view showHUDWith:result hideAfterDelay:ACTIVITY_SHOW_TIME];
    } failure:^(NSString *reason) {
        [self.view hideHUD];
        [self.view showHUDWith:reason hideAfterDelay:ACTIVITY_SHOW_TIME];
    }];
}

- (void)regist
{
    [self.view showHUDWith:@"正在注册"];
    [[CDService shareInstance] regist:_phoneTextField.text password:_passWordTextField.text repassword:_passWordTextField.text authcode:_codeTextField.text success:^(NSString *result) {
         [super leftBarItemPress:nil];
        
        [self.view showHUDWith:result hideAfterDelay:ACTIVITY_SHOW_TIME];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MyAccount" bundle:nil];
        UIViewController *destinationVC = [storyboard instantiateViewControllerWithIdentifier:@"ResetUserInfoViewController"];
        [self.navigationController popToViewController:destinationVC animated:YES];
    } failure:^(NSString *reason) {
        
        [self.view hideHUD];
        [self.view showHUDWith:reason hideAfterDelay:ACTIVITY_SHOW_TIME];
        
    }];
}

- (IBAction)eyeBtnClick:(UIButton *)sender {
    self.passWordTextField.secureTextEntry = !self.passWordTextField.secureTextEntry;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end
