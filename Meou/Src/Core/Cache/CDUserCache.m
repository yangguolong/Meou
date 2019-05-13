//
//  ICUserCache.m
//  Fitroom3D
//
//  Created by 杨国龙 on 15/4/8.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import "CDUserCache.h"
#define kUserAccount    @"kUserAccount"
#define kUserPassword   @"kUserPassword"
#define kUserToken      @"kUserToken"
#define kUserId         @"kUserId"
//#define kIsOAuthLogin   @"kIsOAuthLogin"

//#define kUserLoginType  @"kUserLoginType"


@implementation CDUserCache

+ (instancetype)shareInstance
{
    static CDUserCache *userCache = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userCache = [[CDUserCache alloc] init];
    });
    
    return userCache;
    
}

- (void)saveCurrentUser:(CDUser *)aUser
{
 
//    [[NSUserDefaults standardUserDefaults] setObject:aUser.user_acount forKey:kUserAccount];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:aUser.user_password forKey:kUserPassword];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:aUser.user_token forKey:kUserToken];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    [[NSUserDefaults standardUserDefaults] setObject:aUser.user_id forKey:kUserId];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (CDUser *)getUserForLogin
{
    CDUser *aUser = [[CDUser alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserAccount] == nil) {
        return nil;
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword] == nil) {
        return nil;
    }
    
//    aUser.user_id = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAccount];
    
//    aUser.user_acount = [[NSUserDefaults standardUserDefaults] objectForKey:kUserAccount];
//    aUser.user_password = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword];
    
//    aUser.userLoginType = [[NSUserDefaults standardUserDefaults] integerForKey:kUserLoginType];
//    aUser.userPassword = [[NSUserDefaults standardUserDefaults] objectForKey:kUserPassword];
    return aUser;
}

- (void)clearUserCache
{
    NSUserDefaults *sUserDefaults = [NSUserDefaults standardUserDefaults];
    
    [sUserDefaults removeObjectForKey:kUserAccount];
    [sUserDefaults removeObjectForKey:kUserId];
    [sUserDefaults removeObjectForKey:kUserPassword];
    [sUserDefaults removeObjectForKey:kUserToken];
    
}



@end
