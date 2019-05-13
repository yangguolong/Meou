//
//  UserInfoViewController.m
//  Meou
//
//  Created by 杨国龙 on 15/10/13.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "UserInfoViewController.h"
#import "CDService.h"
#import <UIImageView+WebCache.h>
@interface UserInfoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[CDService shareInstance] getPersonInfoWithSuccess:^(id result) {
        CDUser * aUser = result;
        _userNameLabel.text = aUser.name;
        _sexLabel.text = aUser.sex;
        _ageLabel.text = aUser.age;
        _phoneLabel.text = aUser.phone;
        _emailLabel.text = aUser.email;
        _addressLabel.text = aUser.addr;
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:aUser.header_icon] placeholderImage:[UIImage imageNamed:@"icon_default_pic_small"]];
        
    } failure:^(NSString *reason) {
        
    }];
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

@end
