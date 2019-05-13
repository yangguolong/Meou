//
//  CDUser.h
//  Meou
//
//  Created by 杨国龙 on 15/9/28.
//  Copyright (c) 2015年 dragonstudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDUser : NSObject

/** 用户id */
@property (nonatomic ,copy)NSString *userid;
/** 用户token */
@property (nonatomic ,copy)NSString *userToken;
/** 手机号 */
@property (nonatomic ,copy)NSString *phone;
/** 密码 */
@property (nonatomic ,copy)NSString *password;
/** 姓名 */
@property (nonatomic ,copy)NSString *name;
/** 性别 */
@property (nonatomic ,copy)NSString *sex;
/** 年龄 */
@property (nonatomic ,copy)NSString *age;
/** 邮箱 */
@property (nonatomic ,copy)NSString *email;
/** 地址 */
@property (nonatomic ,copy)NSString *addr;
/** 身份证号 */
@property (nonatomic ,copy)NSString *cardno;

@property (nonatomic ,copy)NSString *header_icon;

@end
