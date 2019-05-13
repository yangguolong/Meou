//
//  AppDelegate.m
//  TestOSGIOS
//
//  Created by 杨国龙 on 15/5/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import "AppDelegate.h"
#import "OSGView.h"
#import "DrawerLeftController.h"
#import "TabbarViewController.h"
#import <MMDrawerController.h>
#import "CDService.h"

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
//    [self testGetAuthCode];
//    [self testGetIndexData];
//    [self testGetPersonInfo];
//    [self testAppNews];
//    [self testSetPersonInfo];
//    [self testLogin];
//    [self testRegist];
//    [self testGetProductList];
//    [self testResetPassword];
    
//    [self testUploadImage];
    
    
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    //tabbar 顶部的黑线
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    MMDrawerController * drawerController;
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DrawerLeftController * leftvc = [storyboard instantiateViewControllerWithIdentifier:@"DrawerLeftController"];
    
    TabbarViewController * tabbar = [storyboard instantiateViewControllerWithIdentifier:@"TabbarViewController"];


//    leftvc.drawerLeftdelegate = tabbar;
    
    drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:tabbar
                             leftDrawerViewController:leftvc
                             rightDrawerViewController:nil];
    
    tabbar.drawerController = drawerController;
    
    [drawerController setShowsShadow:YES];
    [drawerController setRestorationIdentifier:@"MMDrawer"];
    [drawerController setMaximumLeftDrawerWidth:230.0];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    [self.window setRootViewController:drawerController];
    
    return YES;
}

- (void)testUploadImage
{
        [[CDService shareInstance] uploadfile:[UIImage imageNamed:@"red_point"] success:^(id result) {
            
        } failure:^(NSString *reason) {
            
        }];
    
    
}

- (void)testResetPassword
{
    [[CDService shareInstance] resetPasswordWithPhone:@"18165702532" authcode:@"699126" newPassword:@"654321" success:^(NSString *result) {
        
    } failure:^(NSString *reason) {
        
    }];
}

- (void)testAppNews
{
    [[CDService shareInstance]getAppNewsWithSuccess:^(id result) {
        
    } failure:^(NSString *reason) {
        
    }];
}

- (void)testSetPersonInfo
{
    [[CDService shareInstance] setPersonInfoWithName:@"AA" sex:Woman addr:@"南山" headerImagePath:@"http://msapi.cloudream.net/index.php/file/file/resource_2015-10-20_yzm2015102015581110.png" age:@"13" email:@"qwe@qq.com" cardno:@"123456" success:^(id result) {
        
    } failure:^(NSString *reason) {
        
    }];
    
   
}

- (void)testGetPersonInfo
{
    [[CDService shareInstance] getPersonInfoWithSuccess:^(id result) {
        
    } failure:^(NSString *reason) {
        
    }];

}

- (void)testGetIndexData
{
    [[CDService shareInstance] getAppAdsWithSuccess:^(id result) {
        
    } failure:^(NSString *reason) {
        
    }];
}

- (void)testLogin
{
    
        [[CDService shareInstance] loginWithphone:@"18165702532" password:@"123456" success:^(id result) {

        } failure:^(NSString *reason) {

        }];

}

- (void)testRegist
{
        [[CDService shareInstance] regist:@"18165702532" password:@"123456" repassword:@"123456" authcode:@"844675" success:^(NSString *result) {
    
        } failure:^(NSString *reason) {
    
        }];

}

- (void)testGetAuthCode
{
        [[CDService shareInstance] authcodeByPhone:@"18165702532" success:^(NSString *result) {
    
        } failure:^(NSString *reason) {
    
        }];
}

- (void)testGetProductList
{
        [[CDService shareInstance] getProductListWithStar:0 length:20 success:^(id result) {
    
        } failure:^(NSString *reason) {
    
        }];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


-(void)applicationWillTerminate:(UIApplication *)application {

} 


@end
