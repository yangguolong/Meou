//
//  BaseViewCtrl.h
//  Fitroom3D
//
//  Created by 杨国龙 on 15/4/7.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+ShowHUD.h"

#import "CDService.h"
#import "AppMacro.h"
#import "UIScrollView+MJExtension.h"
#import "UIView+MJExtension.h"
@interface BaseViewCtrl : UIViewController 

/** 设置导航栏左边按钮 */
- (void)setupLeftBarItem;

/** 设置导航栏右边按钮 */
- (void)setupRightBarItem;

/** 导航栏左边按钮点击事件 */
- (void)leftBarItemPress:(id)sender;

/** 导航栏右边按钮点击事件 */
- (void)rightBarItemPress:(id)sender;

/** 返回左边按钮图片 */
- (NSString *)leftBarItemIcon;

/** 返回右边按钮图片 */
- (NSString *)rightBarItemIcon;





@end
