//
//  TabbarViewController.m
//  CDN
//
//  Created by Yigol on 14/12/20.
//  Copyright (c) 2014年 injoinow. All rights reserved.
//



#import "TabbarViewController.h"
#import "RDVTabBarItem.h"
#import "AppMacro.h"
#import <MMDrawerController.h>
#import "DrawerLeftController.h"
#import "UIImage+Addition.h"
#import "BaseNavigationController.h"
const NSInteger viewCtrlCount = 5;



@interface TabbarViewController ()<UINavigationControllerDelegate,DrawerLeftControllerDelegate>

@property (nonatomic ,strong) UIView *myTabView;

@property (nonatomic,strong)RDVTabBarItem * centerItem;

@end

@implementation TabbarViewController
{
    CGRect centerItemOnViewRect;
    CGRect centerItemOnTabbarRect;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addMyViewControllers];
    
    [self creatCustomTabBar];
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    DrawerLeftController * leftvc = (DrawerLeftController *)self.drawerController.leftDrawerViewController;
    
    leftvc.drawerLeftdelegate = self;
}
#pragma mark - DrawerLeftControllerDelegate
- (void)drawerLeftController:(UIViewController *)VC wantToCtrl:(ViewCtrl)destinationVC
{
    UIViewController * viewCtrl;
    UIStoryboard * storyborad;
    [self.drawerController closeDrawerAnimated:YES completion:nil];
    switch (destinationVC) {
        case LoginVC:
           storyborad = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            viewCtrl = [storyborad instantiateViewControllerWithIdentifier:@"loginNav"];
              [self presentViewController:viewCtrl animated:YES completion:nil];
            break;
        case ModifyPWDVC:
            storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            viewCtrl = [storyborad instantiateViewControllerWithIdentifier:@"ModifyPWDViewControllerNav"];
            [self presentViewController:viewCtrl animated:YES completion:nil];
            break;
        case MyCollectionOfMeouVC:
            [self selectedButtonItemWithIndex:1];
            break;
        case ShopCartVC:
            [self selectedButtonItemWithIndex:3];
            break;
        case MessageVC:
            storyborad = [UIStoryboard storyboardWithName:@"HomePage" bundle:nil];
            viewCtrl = [storyborad instantiateViewControllerWithIdentifier:@"messageNav"];
            [self presentViewController:viewCtrl animated:YES completion:nil];
            break;
        case PowerVC:
            storyborad = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            viewCtrl = [storyborad instantiateViewControllerWithIdentifier:@"PowerViewCtrl"];
             [self presentViewController:viewCtrl animated:YES completion:nil];
            break;
        case UserInfoVC:
            [self selectedButtonItemWithIndex:4];
            break;
        
    }

}


- (void)addMyViewControllers
{
    NSMutableArray *vcArr = [NSMutableArray array];
    for (int i = 0; i < viewCtrlCount; i++) {
        UINavigationController * nav = (UINavigationController *)[self destinationViewControllerWithButtonTag:i];
        nav.delegate = self;
        [vcArr addObject:nav];
    }
    self.viewControllers = vcArr;
}

/** 返回对应的viewController */
- (UIViewController *)destinationViewControllerWithButtonTag:(NSInteger)tag
{
    NSArray * storyboardArr = @[ @"HomePage",
                                 @"Collection",
                                 @"Try",
                                 @"ShopCart",
                                 @"MyAccount"];
    NSString * storyboardId = storyboardArr[tag];
    UIStoryboard * destinationStoryboard = [UIStoryboard storyboardWithName:storyboardId bundle:nil];
    UIViewController * destinationViewController = [destinationStoryboard instantiateViewControllerWithIdentifier:storyboardId];
    
    return destinationViewController;
}

- (void)creatCustomTabBar
{
    CGFloat itemWidth = self.view.bounds.size.width/viewCtrlCount;
    
    NSArray *titleArr = @[@"首页",
                          @"收藏",
                          @"我要试衣",
                          @"购物袋",
                          @"我的账户"
                          ];
    NSArray *imgArray = @[@"button_home_select",
                          @"button_home_collection_select",
                          @"virtualfit_on",
                          @"button_home_shop_select",
                          @"button_my_select"];
    NSArray *unselectimgArray = @[@"button_home",
                          @"button_home_collection",
                          @"virtualfit_off",
                          @"button_home_shop",
                          @"button_my"];

    //tabbar
    self.myTabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    self.myTabView.tag = 100;
    self.myTabView.backgroundColor = [UIColor lightGrayColor];
    self.myTabView.clipsToBounds = NO;
    UIImageView * backgrandImageView = [[UIImageView alloc]initWithFrame:self.myTabView.bounds];
    backgrandImageView.image = [UIImage imageNamed:@"backgroundforbutton"];
    [self.myTabView addSubview:backgrandImageView];
    [self.tabBar addSubview:self.myTabView];
    //item
    for (int i = 0; i < titleArr.count; i++) {
//        RDVTabBarItem *item = [[RDVTabBarItem alloc] init];
        UIButton * item = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (i == 2) {
            item.frame = CGRectMake(i * itemWidth, ( -itemWidth/2) + 10, itemWidth, itemWidth);
            centerItemOnViewRect = item.frame;
            centerItemOnTabbarRect = CGRectMake(i * itemWidth, -itemWidth/2, itemWidth, itemWidth);
            item.layer.cornerRadius = itemWidth/2;

            item.clipsToBounds = YES;
        }else{
            [item setContentEdgeInsets:UIEdgeInsetsMake(5, 20, 5, 20)];
            item.frame = CGRectMake(i * itemWidth, 0, itemWidth, 49);
        }
        [self.myTabView addSubview:item];
        [item setImage:[UIImage imageNamed:[unselectimgArray objectAtIndex:i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:[imgArray objectAtIndex:i]] forState:UIControlStateSelected];
        [item addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
        item.tag = i;
        
        
        if (i == 0) {
            item.selected = YES;
        }

    }
    
    
    
}

- (void)showNoticeWithBadge:(NSNumber *)badge
{
    for (RDVTabBarItem *tt in self.myTabView.subviews) {
        if (tt.tag == 1) {
            if ([badge intValue] > 0) {
                [tt setBadgeValue:[NSString stringWithFormat:@"%@",badge]];
            } else {
                tt.badgeValue = nil;
            }
        }
    }
}
- (void)showNewReplyCountWithBadge:(NSNumber *)badge
{
    for (RDVTabBarItem *tt in self.myTabView.subviews) {
        if (tt.tag == 3) {
            if ([badge intValue] > 0) {
                [tt setBadgeValue:[NSString stringWithFormat:@"%@",badge]];
            } else {
                tt.badgeValue = nil;
            }
        }
    }
}

- (void)click:(RDVTabBarItem *)sender
{
    [self selectedButtonItemWithIndex:sender.tag];
}

- (void)selectedButtonItemWithIndex:(NSInteger)index
{

    DLog(@"selectedTabbarIndex = %ld",(long)index);
    self.selectedIndex = index;
    if (index == 0) {
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    }else{
        [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }
    
   for (UIView *subView in self.myTabView.subviews) {
    
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *item1 = (UIButton *)subView;
    
            if (item1.tag == index) {
                item1.selected = YES;

            } else {
                item1.selected = NO;

            }
        }
    }

}
@end
