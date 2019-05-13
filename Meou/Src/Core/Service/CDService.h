//
//  CDUserService.h
//  Fitroom3D
//
//  所有用户操作模块和数据处理的服务类。
//  1.登陆。
//  2.注册。
//  3.找回密码
//
//  Created by 杨国龙 on 15/4/8.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppMacro.h"
#import "CDUser.h"

/**提示登陆通知*/
extern NSString * const NotificationForReminderLogin;
@interface CDService : NSObject
/** 用户信息 */
@property (nonatomic , strong)CDUser *user;
/** 登陆状态 */
@property (nonatomic ,readonly)BOOL isLogin;


@property (nonatomic ,strong)NSMutableArray *collectionPids;


+ (instancetype)shareInstance;


-(CDUser *)currentUser;
///-------------------
/// @name 登录模块接口
///-------------------

/**
 *  退出登录
 */
- (void)logOut;

///-------------------
/// @name 注册模块接口
///-------------------


/**
 *  获取验证码
 *
 *  @param phone   手机号
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)authcodeByPhone:(NSString *)phone
                success:(void(^)(NSString *result))success
                failure:(void(^)(NSString *reason))failure;


/**
 *  注册接口
 *
 *  @param phone    手机
 *  @param password 密码
 *  @param authcode 验证码
 *  @param success  成功处理
 *  @param failure  失败处理
 */
- (void)regist:(NSString *)phone
        password:(NSString *)password
        repassword:(NSString *)repassword
        authcode:(NSString *)authcode
        success:(void (^)(NSString *result))success
        failure:(void (^)(NSString * reason))failure;

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
 *  登录
 *
 *  @param phone    手机号
 *  @param password 密码
 *  @param success  成功处理
 *  @param failure  失败处理
 */
- (void)loginWithphone:(NSString *)phone
              password:(NSString *)password
               success:(void (^)(id result))success
               failure:(void (^)(NSString * reason))failure;

/**
 *  获取商品列表
 *
 *  @param star    起始位置
 *  @param length  长度
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)getProductListWithStar:(long long)star
                        length:(long long)length
                       success:(void (^)(id result))success
                       failure:(void (^)(NSString * reason))failure;

/**
 *  获取手机/PC端测量数据请求，返回测量数据明细
 *
 *  @param deviceId 设备id
 *  @param success  成功处理
 *  @param failure  失败处理
 */
-(void)getTdDataWithTdNumber:(NSString *)tdNumber success:(void (^)(id result))success failure:(void (^)(NSString * reason))failure;

/**
 *  获取首页数据
 *
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)getAppAdsWithSuccess:(void (^)(id result))success
                     failure:(void (^)(NSString * reason))failure;

/**
 *  获取用户信息
 *
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)getPersonInfoWithSuccess:(void (^)(id result))success
                         failure:(void (^)(NSString * reason))failure;

/**
 *  修改个人信息
 *
 *  @param name    姓名
 *  @param sex     性别
 *  @param addr    地址
 *  @param imagePath   头像url
 *  @param age     年龄
 *  @param email   邮箱
 *  @param cardno  身份证号
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)setPersonInfoWithName:(NSString *)name
                          sex:(Sex)sex addr:(NSString *)addr
              headerImagePath:(NSString *)imagePath
                          age:(NSString *)age
                        email:(NSString *)email
                       cardno:(NSString *)cardno
                      success:(void (^)(id result))success
                      failure:(void (^)(NSString * reason))failure;

/**
 *  APP消息推送
 *
 *  @param success 成功处理
 *  @param failure 失败处理
 */
- (void)getAppNewsWithSuccess:(void (^)(id result))success
                      failure:(void (^)(NSString * reason))failure;


/**
 *  上传文件
 *
 *  @param image   图片
 *  @param success 成功处理
 *  @param failure 失败处理
 */
-(void)uploadfile:(UIImage * )image success:(void (^)(id result))success failure:(void (^)(NSString * reason))failure;

/**
 *  下载资源
 *
 *  @param res_id  资源id
 *  @param targetPath 下载路径
 *  @param success 成功处理
 *  @param failure 失败处理
 */
-(void)resource3DDownloadWithResURL:(NSString *)res_url progress:(NSProgress *)progress success:(void (^)(id result))success failure:(void (^)(NSString *reason))failure;




@end
