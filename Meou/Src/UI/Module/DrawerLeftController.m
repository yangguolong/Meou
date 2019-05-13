//
//  DrawerLeftController.m
//  Meou
//
//  Created by 杨国龙 on 15/9/24.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "DrawerLeftController.h"
#import "TabbarViewController.h"
#import "CDService.h"
#import "UIImage+GL.h"
#import "UIView+ShowHUD.h"

const NSString * m_appleID = @"1014839750";

@interface DrawerLeftController () <UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
// 当前屏幕亮度
@property (assign, nonatomic) CGFloat  currentBrightness;
@property (strong, nonatomic) UIView   *qrCodeContentView;
@property (strong, nonatomic)          UIImageView    *qrCodeSizeImageView;
//@property (weak, nonatomic)   IBOutlet UIImageView    *qrCodeImageView;
@end

@implementation DrawerLeftController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.设置tableView样式
    [self setupTableView];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (IBAction)logout:(UIButton *)sender {
    [[CDService shareInstance] logOut];
    [self changeLoginState];
}

- (void)setupTableView
{
    self.tableView.separatorColor = [UIColor redColor];
     // 设置端距，这里表示separator离左边和右边均80像素
    self.tableView.separatorInset = UIEdgeInsetsMake(0,50, 0, 0);
    //去掉多余分割线
//    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self changeLoginState];
    
}

- (void)changeLoginState
{
    CDUser *user = [[CDService shareInstance] currentUser];
    if (user) {
        _logoutButton.hidden = NO;
        if ([user.name length]>0)
            _userNameLabel.text = user.name;
        else
            _userNameLabel.text = user.phone;
    }else{
          _logoutButton.hidden = YES;
        _userNameLabel.text = @"请登录";
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
             [self score];
            break;
        case 1:
            [self cleanCache];
            break;
        case 2:
            [self toController:ModifyPWDVC];

            break;
        case 3:
            [self toController:PowerVC];
            break;
            
        default:
            break;
    }
   
}



- (IBAction)userInfoMessageViewTap:(UITapGestureRecognizer *)sender {

    
    if ([[CDService shareInstance] currentUser]) {
      
        [self toController:UserInfoVC];

    }else{
        [self toController:LoginVC];
    }
}

/**
 *  收藏按钮点击事件
 *
 *  @param sender
 */
- (IBAction)collectionButtonClick:(UIButton *)sender {
    [self toController:MyCollectionOfMeouVC];
}

- (void)toController:(ViewCtrl)destination
{
    // 跳转到收藏页面
    if (self.drawerLeftdelegate &&[self.drawerLeftdelegate respondsToSelector:@selector(drawerLeftController:wantToCtrl:)]) {
        [self.drawerLeftdelegate drawerLeftController:self wantToCtrl:destination];
    }
}

/**
 *  消息按钮点击事件
 *
 *  @param sender
 */
- (IBAction)messageButtonClick:(UIButton *)sender {
    [self toController:MessageVC];
}

/**
 *  购物车按钮点击事件
 *
 *  @param sender
 */
- (IBAction)shopcarButtonClick:(UIButton *)sender {
    // 跳转到购物车页面
    [self toController:ShopCartVC];
}

/**
 *  二维码按钮点击事件
 *
 *  @param sender
 */
- (IBAction)qrcodeButtonClick:(UIButton *)sender {
  
    [self tapQRCodeBigger];
}

- (void)tapQRCodeBigger
{
        // 调整屏幕亮度
//    _currentBrightness = [UIScreen mainScreen].brightness;
//    [[UIScreen mainScreen] setBrightness:1.0];
    
    // 隐藏导航栏
    self.navigationController.navigationBarHidden = YES;
    
    // 创建全屏背景图
    _qrCodeContentView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _qrCodeContentView.backgroundColor = [UIColor whiteColor];
    
    // 创建image view
    // 生成二维码
        _qrCodeSizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _qrCodeContentView.frame.size.width * 0.7, _qrCodeContentView.frame.size.width * 0.7)];
    self.qrCodeSizeImageView.image = [UIImage generateQRCode:@"http://www.cloudream.net" width:self.qrCodeSizeImageView.frame.size.width height:self.qrCodeSizeImageView.frame.size.width];
    [self.qrCodeSizeImageView setContentMode:UIViewContentModeScaleAspectFit];

    _qrCodeSizeImageView.center = CGPointMake(_qrCodeContentView.frame.size.width / 2.0, _qrCodeContentView.frame.size.height / 2.0);

    [_qrCodeContentView addSubview:_qrCodeSizeImageView];
   
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:_qrCodeContentView];
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:_qrCodeContentView];
    
    _qrCodeContentView.userInteractionEnabled = YES;
    [_qrCodeContentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapQRCodeSmaller)]];
}

/**
 *  点击隐藏二维码
 */
- (void)tapQRCodeSmaller
{
    self.navigationController.navigationBarHidden = NO;
    [_qrCodeContentView removeFromSuperview];
    [_qrCodeSizeImageView removeFromSuperview];
//    [[UIScreen mainScreen] setBrightness:_currentBrightness];
}

/**
 *  清理缓存
 */
- (void)cleanCache
{
    // 1. 计算缓存的大小

    [self.view showHUDWith:@"正在清除缓存..." ];
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        [self.view hideHUD];
        
    }];
}


/**
 *  软件评分
 */
- (void)score
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"跳转到AppStore给应用打分" delegate:self cancelButtonTitle:@"残忍拒绝" otherButtonTitles:@"好的哦", nil];
    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",m_appleID]]];
    }
  
}

@end
