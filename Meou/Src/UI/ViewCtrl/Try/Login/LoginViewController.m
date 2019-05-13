//
//  LoginViewController.m
//  Meou
//
//  Created by 杨国龙 on 15/10/12.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "LoginViewController.h"
#import "CDService.h"
#import "NSString+Category.h"
#import "RegistViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLeftBarItem];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    [self.view endEditing:YES];
//}
- (IBAction)loginButtonClick:(UIButton *)sender {
   
    [self.view showHUDWith:@"正在登录"];
    [[CDService shareInstance]loginWithphone:_accountTextField.text password:_passwordTextField.text success:^(id result) {
        
        [self.view hideHUD];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSString *reason) {
        
        [self.view hideHUD];
        [self.view showHUDWith:reason hideAfterDelay:ACTIVITY_SHOW_TIME];
    }];
    
}

- (IBAction)eyeBtnClick:(UIButton *)sender {
    self.passwordTextField.secureTextEntry = !self.passwordTextField.secureTextEntry;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RegistViewController *VC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"modifyPWD"]) {
        VC.action = ModifyPWDAction;
    }else if([segue.identifier isEqualToString:@"register"]){
        VC.action = RegisterAction;
    }
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
