//
//  RegistViewController.h
//  Meou
//
//  Created by 杨国龙 on 15/10/12.
//  Copyright © 2015年 cloudream. All rights reserved.
//  注册和修改密码用同一个ViewController

#import "BaseViewCtrl.h"

typedef enum {
    RegisterAction = 0,   //注册
    ModifyPWDAction,      //修改密码

}RegistAction;

@interface RegistViewController : BaseViewCtrl

@property (nonatomic ,assign)RegistAction action;

@end
