//
//  AppMacro.h
//  MinLin_LED
//
//  Created by Oliver on 15/1/29.
//  Copyright (c) 2015年 Oliver. All rights reserved.
//

#ifndef MinLin_LED_AppMacro_h
#define MinLin_LED_AppMacro_h

#define CHECK_NULL(object) ([object isKindOfClass:[NSNull class]]?nil:object)
#define ACTIVITY_SHOW_TIME  1.5

/********************DEBUG*************************/


#define DEBUG 1

#ifdef DEBUG // 调试

#define DLog(fmt, ...) {NSLog((@"%s [Line %d] DEBUG:--->" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#else       // 发布打包
#define DLog(...)
#endif
/********************DEBUG*************************/

#define SERVICE_URL @"http://120.25.161.124/api/index.php?"

//Category

//判断系统版本
#define IS_iOS7 [UIDevice currentDevice].systemVersion.floatValue >= 7.0&&[UIDevice currentDevice].systemVersion.floatValue < 8.0
#define IS_iOS8 [UIDevice currentDevice].systemVersion.floatValue >= 8.0
//屏幕的宽高
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

/**
 性别
 */
typedef enum {
    Woman = 0,
    Man
}Sex;

/**
 网络请求方法
 */
typedef enum {
    
    login = 0,                      //登录
    getVCode,                       //获取验证码
    regist,                         //注册
    getProductList,                 //获取商品列表
    getAppIndex,                    //获取app首页数据
    getPersonInfo,                  //获取个人信息
    setPersonInfo,                  //设置用户信息
    getAppNews,                     //app消息推送
    resetPassword,                  //重置密码
}ParamClass;

#define LOGIN               @"userLogin"            //登录
#define REGIST              @"registerUser"         //注册
#define GET_VCODE           @"getSms"               //验证码
#define GET_PRODUCT_LIST    @"getProductList"       //商品列表
#define GET_APP_INDEX       @"getAppAds"            //app首页
#define GET_PERSON_INFO     @"getPersonInfo"        //获取个人信息
#define SET_PERSION_INFO    @"modifyPersonInfo"     //设置用户信息
#define GET_APP_NEWS        @"getAppNews"           //app消息推送
#define RESET_PASSWORD      @"getPassword"          //重置密码

#endif
