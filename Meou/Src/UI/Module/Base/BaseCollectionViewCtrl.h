//
//  BaseCollectionViewCtrl.h
//  Meou
//
//  Created by 杨国龙 on 15/9/28.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppMacro.h"
#import "CDService.h"

@interface BaseCollectionViewCtrl : UICollectionViewController
/**
 *  设置导航栏左边按钮
 */
- (void)setUpLeftBarItem;
/**
 *  设置导航栏右边按钮
 */
- (void)setUpRightBarItem;
/**
 *  导航栏左边按钮点击事件
 *
 *  @param sender 按钮
 */
- (void)leftBarItemPress:(id)sender;
/**
 *  导航栏右边按钮点击事件
 *
 *  @param sender 按钮
 */
- (void)rightBarItemPress:(id)sender;

/**
 *  返货左边按钮图片
 *
 *  @return 图片名字
 */
- (NSString *)leftBarItemIcon;

/**
 *  返回右边按钮图片
 *
 *  @return 图片名字
 */
- (NSString *)rightBarItemIcon;

@end
