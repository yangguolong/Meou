//
//  CDRegister.h
//  Meou
//
//  Created by 杨国龙 on 15/10/12.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDRegister : NSObject
/** 手机号 */
@property (nonatomic ,copy)NSString *telno;
/** 验证码 */
@property (nonatomic ,copy)NSString *code;
/** 密码 */
@property (nonatomic ,copy)NSString *password;


@end
