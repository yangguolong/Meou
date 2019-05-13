//
//  ICUserCache.h
//  Fitroom3D
//
//  Created by 杨国龙 on 15/4/8.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDUser.h"

@interface CDUserCache : NSObject

+ (instancetype)shareInstance;

/**
 *  保存当前登陆的用户信息
 *
 *  @param aUser 只需要用户账号 密码 TOKEN
 */
- (void)saveCurrentUser:(CDUser *)aUser;

/**
 *  获取用户信息
 *
 *  @return 返回用户的账号密码
 */
- (CDUser *)getUserForLogin;

/**
 *  清除账户信息
 */
- (void)clearUserCache;





@end
