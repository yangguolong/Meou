//
//  TabbarViewController.h
//  CDN
//
//  Created by Yigol on 14/12/20.
//  Copyright (c) 2014年 injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>



@class MMDrawerController;
@interface TabbarViewController : UITabBarController

@property (nonatomic,strong) MMDrawerController * drawerController;

- (void)selectedButtonItemWithIndex:(NSInteger)index;

@end
