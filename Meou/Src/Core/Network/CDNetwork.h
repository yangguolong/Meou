//
//  CDUserNetwork.h
//  Fitroom3D
//
//  Created by 杨国龙 on 15/4/8.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import "CDBaseNetwork.h"
#import "AppMacro.h"
#import <UIKit/UIKit.h>


@interface CDNetwork : CDBaseNetwork

/**
 *  登录
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param success  成功处理
 *  @param failure  失败处理
 */
- (void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(NetworkSuccess)success failure:(NetworkFailure)failure;


/**
 *  获取验证码
 *
 *  @param phone   手机号
 *  @param sucess  成功处理
 *  @param failure 失败处理
 */
- (void)obtainVCodeWithNum:(NSString *)phone success:(NetworkSuccess)success failure:(NetworkFailure)failure;




/**
 *  注册接口
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param authcode 验证码
 *  @param success  成功处理
 *  @param failure  失败处理
 */
- (void)regist:(NSString *)phone
      password:(NSString *)password
      authcode:(NSString *)authcode
       success:(NetworkSuccess)success
       failure:(NetworkFailure)failure;

/**
 *  重置密码
 *
 *  @param phone       手机号
 *  @param authcode    验证码
 *  @param newPassword 新密码
 *  @param success     成功处理
 *  @param failure     失败处理
 */
- (void)resetPasswordWithPhone:(NSString *)phone
                      authcode:(NSString *)authcode
                   newPassword:(NSString *)newPassword
                       success:(void (^)(NSString *result))success
                       failure:(void (^)(NSString * reason))failure;

/**
 *  获取商品列表
 *
 *  @param star     起始位置
 *  @param length   长度
 *  @param lastTime 上次请求的时间
 *  @param success  成功处理
 *  @param failure  失败处理
 */
- (void)getProductListWithStar:(long long)star
                        length:(long long)length
                      lastTime:(long long)lastTime
                       success:(void (^)(id result))success
                       failure:(void (^)(NSString * reason))failure;

/**
 *  获取首页数据
 *
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)getAppAdsWithSuccess:(void (^)(id result))success
                     failure:(void (^)(NSString * reason))failure;


/**
 *  上传文件
 *
 *  @param image   图片
 *  @param success 成功处理
 *  @param failure 失败处理
 */
-(void)fileUploadImage:(UIImage *)image
               success:(NetworkFailure)success
               failure:(NetworkFailure)failure;

/**
 *  下载资源
 *
 *  @param param   请求参数
 *  @param success 成功处理
 *  @param failure 失败处理
 */
-(void)resource_download:(NSString *)param
                progress:(NSProgress *)progress
                 success:(NetworkFailure)success
                 failure:(NetworkFailure)failure;

/**
 *  获取用户信息
 *
 *  @param userId    userId
 *  @param userToken userToken
 *  @param success   成功处理
 *  @param failure   失败处理
 */
- (void)getPersonInfoWithUserId:(NSString *)userId
                        userToken:(NSString *)userToken
                        success:(void (^)(id result))success
                        failure:(void (^)(NSString * reason))failure;

/**
 *  修改个人信息
 *
 *  @param name    姓名
 *  @param sex     性别
 *  @param imagePath 头像url
 *  @param addr    地址
 *  @param age     年龄
 *  @param email   邮箱
 *  @param userId  用户id
 *  @param userToken   用户token
 *  @param cardno  身份证号
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)setPersonInfoWithName:(NSString *)name
                          sex:(Sex)sex addr:(NSString *)addr
                          age:(NSString *)age
              headerImagePath:( NSString *)imagePath
                        email:(NSString *)email
                       cardno:(NSString *)cardno
                       userid:(NSString *)userId
                    userToken:(NSString *)userToken
                      success:(void (^)(id result))success
                      failure:(void (^)(NSString * reason))failure;


/**
 *  app消息推送
 *
 *  @param lastTime 上次请求的时间
 *  @param success  成功处理
 *  @param failure  失败处理
 */
- (void)getAppNewsWithLastTime:(long long)lastTime
                       success:(void (^)(id result))success
                       failure:(void (^)(NSString * reason))failure;

/**
 *  获取人体参数
 *
 *  @param param   请求参数
 *  @param success 成功处理
 *  @param failure 失败处理
 */
-(void)getTdDataWithTdNumber:(NSString *)tdNumber success:(void (^)(id result))success failure:(void (^)(NSString * reason))failure;



@end
