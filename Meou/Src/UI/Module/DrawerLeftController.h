//
//  DrawerLeftController.h
//  Meou
//
//  Created by 杨国龙 on 15/9/24.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    LoginVC = 0,
    ModifyPWDVC,
    MyCollectionOfMeouVC,
    ShopCartVC,
    MessageVC,
    PowerVC,
    UserInfoVC,
}ViewCtrl;
@protocol DrawerLeftControllerDelegate <NSObject>

@optional;

-(void)drawerLeftController:(UIViewController *)VC wantToCtrl:(ViewCtrl )destinationVC;


@end


@interface DrawerLeftController : UITableViewController

@property (nonatomic,weak,nullable) id<DrawerLeftControllerDelegate> drawerLeftdelegate;

@end
