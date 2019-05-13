//
//  CDUserService.m
//  Fitroom3D
//
//  Created by 杨国龙 on 15/4/8.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import "CDService.h"
#import "CDNetwork.h"

#import "MJExtension.h"
#import "AppMacro.h"
#import "CDProduct.h"
#import "CDUserCache.h"
#import "NSString+Category.h"
#import "CDDocument.h"
#import "CDBanner.h"
#import "CDHomePageResult.h"

NSString * const NotificationForReminderLogin = @"NSNotificationForReminderLogin";

@interface CDService ()

// 用户网络请求
@property (nonatomic ,strong) CDNetwork *network;
@property (nonatomic ,readwrite,assign)BOOL isLogin;
@property (nonatomic,assign)NSInteger  modelSelectIndex;
/** 收藏的产品id  */

@end


@implementation CDService
{
    BOOL changeStatus;
}

+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    
    static CDService *_userService = nil;
    
    dispatch_once(&onceToken, ^{
        _userService = [[self alloc] init];
    });
    return _userService;
}
-(NSInteger)currenSelectModelIndex{
    return self.modelSelectIndex;
}

-(void)setCurrenSelectModelIndex:(NSInteger)index{
    self.modelSelectIndex = index;
}

-(CDUser *)currentUser{
    return self.user;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.network = [[CDNetwork alloc] init];
//        self.user = [[CDUser alloc] init];
        
    }
    return self;
}


- (CDUser *)user
{
    if (_user == nil) {
        _user = [[CDUserCache shareInstance] getUserForLogin];
    }
    return _user;
}

- (void)authcodeByPhone:(NSString *)phone
                success:(void(^)(NSString *result))success
                failure:(void(^)(NSString *reason))failure
{
    DLog(@"获取验证码开始");
    if (phone.length != 11) {
        failure(@"请输入正确的手机号码");
        return;
    }
    
    [_network obtainVCodeWithNum:phone success:^(id result) {
        if (success) {
              success([NSString stringWithFormat:@"验证码已发送到：%@",phone]);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    }];
}

- (void)getProductListWithStar:(long long)star
                        length:(long long)length
                       success:(void (^)(id result))success
                       failure:(void (^)(NSString * reason))failure
{
    [_network getProductListWithStar:star length:length lastTime:1 success:^(id result) {
        
        NSMutableArray *datas = [CDProduct objectArrayWithKeyValuesArray:result];
        if(success){
            success(datas);
        }
        
    } failure:^(NSString *reason) {
        if (failure) {
            failure(reason);
        }
    }];
}

- (void)getAppAdsWithSuccess:(void (^)(id result))success
                     failure:(void (^)(NSString * reason))failure
{
    [_network getAppAdsWithSuccess:^(id result) {
        CDHomePageResult *res = [CDHomePageResult objectWithKeyValues:result];
        if (success) {
            success(res);
        }
    } failure:^(NSString *reason) {
        if (failure) {
            failure(reason);
        }
    }];

}

- (void)getPersonInfoWithSuccess:(void (^)(id result))success
                         failure:(void (^)(NSString * reason))failure
{
    [_network getPersonInfoWithUserId:@"24" userToken:@"" success:^(id result) {
        self.user.addr = result[@"addr"];
        self.user.age = result[@"age"];
        self.user.cardno = result[@"cardno"];
        self.user.email = result[@"email"];
        self.user.name = result[@"name"];
        self.user.sex = result[@"sex"];
        self.user.header_icon = result[@"imgurl"];
        if (success) {
            success(self.user);
        }
        
    } failure:^(NSString *reason) {
        if (failure) {
            failure(reason);
        }
    }];
}


- (void)setPersonInfoWithName:(NSString *)name
                          sex:(Sex)sex addr:(NSString *)addr
                        headerImagePath:(NSString *)imagePath
                          age:(NSString *)age
                        email:(NSString *)email
                       cardno:(NSString *)cardno
                      success:(void (^)(id result))success
                      failure:(void (^)(NSString * reason))failure
{
    
    [_network setPersonInfoWithName:name sex:sex addr:addr age:age headerImagePath:imagePath email:email cardno:cardno userid:@"24" userToken:@"" success:^(id result) {
        if(success){
            success(@"修改成功");
        }
    } failure:^(NSString *reason) {
        if (failure) {
            failure(reason);
        }
    }];
}




- (void)resetPasswordWithPhone:(NSString *)phone
                      authcode:(NSString *)authcode
                    newPassword:(NSString *)newPassword
                       success:(void (^)(NSString *result))success
                       failure:(void (^)(NSString * reason))failure
{
    
    if (phone.length == 0 ) {
        
        failure (@"请输入手机号");
        
        return;
    }
    if(phone.length != 11){
        failure(@"请输入正确的手机号");
        return;
    }
    
    if (authcode.length == 0) {
        
        failure (@"请输入验证码");
        
        return;
    }
    
    if (newPassword.length == 0) {
        
        failure (@"请输入密码");
        
        return;
    }
    

    if (newPassword.length < 6  || newPassword.length >16) {
        failure(@"密码长度只能为6-16");
        return;
    }
    if (![newPassword isEnglishOrNumber]) {
        failure (@"密码只能由数字或字母组成");
        return;
    }
    
    [_network resetPasswordWithPhone:phone authcode:authcode newPassword:newPassword success:^(NSString *result) {
        if (success) {
            success(@"修改密码成功");
        }
   
    } failure:^(NSString *reason) {
        if (failure) {
            failure(reason);
        }
    }];
}

- (void)getAppNewsWithSuccess:(void (^)(id result))success
                      failure:(void (^)(NSString * reason))failure;
{
    [_network getAppNewsWithLastTime:100 success:^(id result) {
        
    } failure:^(NSString *reason) {
        if (failure) {
            failure(reason);
        }
    }];
}

#pragma mark  - Login
//- (void)loginWithParam:(CDLoginParam *)param success:(void (^)(NSString *result))success failure:(void (^)(NSString * reason))failure
//{
//    if(param.email.length == 0){
//        failure(@"请输入账号");
//        return;
//    }
//    if (param.pwd.length == 0) {
//        failure(@"请输入密码");
//        return;
//    }
//      param.pwd = [param.pwd md5Str];
////    NSString *password = param.pwd;
//    [self loginmd5WithParam:param success:success failure:failure];
//}

//- (void)loginmd5WithParam:(CDLoginParam *)param success:(void (^)(NSString *))success failure:(void (^)(NSString *))failure
//{
//    // MD5 加密密码
//    [_network login:param success:^(id result) {
//        
//        CDLoginResult *loginResult = [CDLoginResult objectWithKeyValues:result];
//        CDUser *user = [[CDUser alloc] init];
//        user.user_acount = param.email;
//        user.user_password = param.pwd;
//        user.user_id = loginResult.data.user_id;
//        user.user_token = loginResult.data.user_token;
//        self.user = user;
//        // 缓存到本地
//        [[CDUserCache shareInstance] saveCurrentUser:self.user];
//        
//        self.isLogin = YES;
//        if (success) {
//            success(@"登陆成功");
//        }
//        
//    } failure:^(id reason) {
//        if (failure) {
//            failure(reason);
//        }
//    }];
//
//}

//-(void)autoLoginsucces:(void (^)(NSString *))success failure:(void (^)(NSString *))failure{
//    
//    CDUser * aUser = [[CDUserCache shareInstance]getUserForLogin];
//    // 如果没有缓存 或者已经登录过了 就跳过
//    if (!aUser || _isLogin) {
//        return;
//    }
//    CDLoginParam * loginParam = [[CDLoginParam alloc]init];
//    loginParam.email = aUser.user_acount;
//    loginParam.pwd = aUser.user_password;
//    [self loginmd5WithParam:loginParam success:success failure:failure];
//    
//}


- (void)logOut{
    [[CDUserCache shareInstance] clearUserCache];
    _isLogin = NO;
    self.user = nil;
  
}

#pragma mark - regist
//- (void)registerWithParam:(CDRegisterParam *)param success:(void (^)(NSString *result))success failure:(void (^)(NSString * reason))failure
//{
//    
//    // MD5 加密密码
//    param.pwd = [param.pwd md5Str];
//    [_network regist:param success:^(id result) {
//        
//        CDLoginResult *loginResult = [CDLoginResult objectWithKeyValues:result];
//        CDUser *user = [[CDUser alloc] init];
//        user.user_acount = param.email;
//        user.user_password = param.pwd;
//        user.user_id = loginResult.data.user_id;
//        user.user_token = loginResult.data.user_token;
//        self.isLogin = YES;
//        
//        [[CDUserCache shareInstance] saveCurrentUser:user];
//        
//        success(@"注册成功");
//    } failure:^(id reason) {
//        failure(reason);
//    }];
//}


- (void)regist:(NSString *)phone
      password:(NSString *)password
    repassword:(NSString *)repassword
      authcode:(NSString *)authcode
       success:(void (^)(NSString *result))success
       failure:(void (^)(NSString * reason))failure
{
    if (phone.length == 0 ) {
        
        failure (@"请输入手机号");
        
        return;
    }
    if(phone.length != 11){
        failure(@"请输入正确的手机号");
        return;
    }
    
    if (authcode.length == 0) {
        
        failure (@"请输入验证码");
        
        return;
    }
    
    if (password.length == 0) {
        
        failure (@"请输入密码");
        
        return;
    }
    
    if (repassword.length == 0) {
        
        failure (@"请确认重复密码");
        
        return;
    }
    if (![password isEqualToString:repassword]) {
        
        failure (@"两次输入的密码不一致");
        
        return;
    }
    
    if (password.length < 6  || password.length >16) {
        failure(@"密码长度只能为6-16");
        return;
    }
    if (![password isEnglishOrNumber]) {
        failure (@"密码只能由数字或字母组成");
        return;
    }
    
    [_network regist:phone password:password authcode:authcode success:^(id result) {
        if (success) {
            success(@"注册成功");
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    }];

}


- (void)loginWithphone:(NSString *)phone
              password:(NSString *)password
               success:(void (^)(id result))success
               failure:(void (^)(NSString * reason))failure
{
    DLog(@"begin login...");

    if (phone.length ==0) {
        failure(@"请输入账号");
        return;
    }
    
    if (password.length == 0) {
        failure(@"请输入密码");
        return;
    }
    
    [_network loginWithPhone:phone password:password success:^(id result) {
        self.isLogin = YES;
        CDUser *user = [[CDUser alloc] init];
        user.userid = result[@"userid"];
        user.userToken = result[@"utoken"];
        user.password = password;
        user.phone = phone;
        self.user = user;
        
        if (success) {
            success(@"登录成功");
        }
        
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    }];
}

-(void)uploadfile:(UIImage * )image success:(void (^)(id result))success failure:(void (^)(NSString * reason))failure
{
        [_network fileUploadImage:image success:^(id reason) {
            if (success) {
                success(reason[@"url"]);
            }
        } failure:^(id reason) {
            if (failure) {
                failure(reason);
            }
        }];
}

//-(void)resource3DDownloadWithResURL:(NSString *)res_url progress:(NSProgress *)progress success:(void (^)(id result))success failure:(void (^)(NSString *reason))failure
//{
//
//    
//    [_network download3DResource:res_url progress:nil success:^(id result) {
//        
//        NSString *zippath = [CDBaseNetwork downloadZipPath];
//        
//        NSString *targetpath = [vto3DView getModelDir];
//        DLog(@"target %@",targetpath);
//        NSString *destination = [targetpath stringByAppendingPathComponent:[[result componentsSeparatedByString:@"." ]firstObject]];
////        NSString *filePath =[NSString stringWithFormat:@"%@/%@",destination,[[result componentsSeparatedByString:@"." ]firstObject]];
//        [SSZipArchive unzipFileAtPath:[zippath stringByAppendingPathComponent:result] toDestination:destination progressHandler:^(NSString *entry, unz_file_info zipInfo, long entryNumber, long total) {
//            
//        } completionHandler:^(NSString *path, BOOL succeeded, NSError *error) {
//            NSError * removeError;
//            if (succeeded) {
//                [[NSFileManager defaultManager] removeItemAtPath:[zippath stringByAppendingPathComponent:result] error:&removeError];
//            }
//            if (removeError&&!error) {
//                DLog(@"remove zip Error %@  path: %@",removeError,[zippath stringByAppendingPathComponent:result]);
//            }
//     
//            success(destination);
//            if (error) {
//                failure (error);
//                DLog(@"unarchive error%@",error);
//            }else{
//                DLog(@"unarchive success");
//            }
//        }];
//    } failure:^(id reason) {
//             failure (reason);
//    } requestSerializer:NO responseSerializer:NO];
//    
//}
//
//
//-(void)getTdDataWithTdNumber:(NSString *)tdNumber success:(void (^)(id result))success failure:(void (^)(NSString * reason))failure
//{
////    CDMeasureParam *param = [[CDMeasureParam alloc] init];
////    param.params[@"td_number"] = tdNumber;
////    param.method = @"getTdData";
//    
//    [_network getTdDataWithTdNumber:tdNumber success:^(id res) {
//        CDMeasureResult *mResult = [CDMeasureResult objectWithKeyValues:res];
//        success(mResult.result);
//    } failure:^(NSString *reason) {
//        
//    }];
//    
//}

@end
