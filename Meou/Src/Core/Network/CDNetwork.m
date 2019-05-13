//
//  CDUserNetwork.m
//  Fitroom3D
//
//  Created by 杨国龙 on 15/4/8.
//  Copyright (c) 2015年 Cloudream. All rights reserved.
//

#import "CDNetwork.h"
#import "MJExtension.h"
#import "AppMacro.h"
#import "CDService.h"
#import "NSString+Category.h"
//NSDictionary
//NSMutableDictionary

@implementation CDNetwork

#pragma mark - login
//- (void)login:(NSString *)param success:(NetworkSuccess)success failure:(NetworkFailure)failure
//{
//    param.action = ACTION_USER_LOGIN;
//    [super sendRequestToServiceByGet:param.keyValues success:^(id result) {
//        success(result);
//        
//    } failure:^(id reason) {
//        failure(reason);
//    } requestSerializer:YES responseSerializer:NO];
//
//}


- (void)obtainVCodeWithNum:(NSString *)phone success:(NetworkSuccess)success failure:(NetworkFailure)failure
{
    DLog(@"开始请求验证码。。。");
    NSAssert(![phone isEqualToString:@""], @"手机号不正常");
    NSAssert(phone != nil, @"手机号不正常");
    
    NSMutableDictionary *RowParams = [NSMutableDictionary dictionary];
    [RowParams setValue:phone forKey:@"telno"];

    [super sendRequestToServiceByPost:[self connectionParamter:getVCode withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];
    
}

- (void)regist:(NSString *)phone
      password:(NSString *)password
      authcode:(NSString *)authcode
       success:(NetworkSuccess)success
       failure:(NetworkFailure)failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    
    [RowParams setValue:phone  forKey:@"telno"];
    [RowParams setValue:authcode forKey:@"code"];
    [RowParams setValue:[password md5Str] forKey:@"password"];

    [super sendRequestToServiceByPost:[self connectionParamter:regist withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];

}

- (void)resetPasswordWithPhone:(NSString *)phone
                      authcode:(NSString *)authcode
                   newPassword:(NSString *)newPassword
                       success:(void (^)(NSString *result))success
                       failure:(void (^)(NSString * reason))failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    [RowParams setValue:phone  forKey:@"telno"];
    [RowParams setValue:authcode forKey:@"code"];
    [RowParams setValue:[newPassword md5Str] forKey:@"newpassword"];

    [super sendRequestToServiceByPost:[self connectionParamter:resetPassword withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];
    
}

- (void)getProductListWithStar:(long long)star
                        length:(long long)length
                      lastTime:(long long)lastTime
                       success:(void (^)(id result))success
                       failure:(void (^)(NSString * reason))failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    
    [RowParams setValue:[[NSNumber numberWithLongLong:star] stringValue] forKey:@"offset"];
    [RowParams setValue:[[NSNumber numberWithLongLong:length] stringValue] forKey:@"limit"];
    [RowParams setValue:@"ios" forKey:@"fe_type"];
    [RowParams setValue:[[NSNumber numberWithLongLong:lastTime] stringValue] forKey:@"create_time"];
    
    
    [super sendRequestToServiceByPost:[self connectionParamter:getProductList withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            if (result[@"data"]) {
                 success(result[@"data"]);
            }else{
                failure(@"没有更多数据...");
            }
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];
    
}


- (void)getAppAdsWithSuccess:(void (^)(id result))success
                     failure:(void (^)(NSString * reason))failure
{
  
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    [super sendRequestToServiceByPost:[self connectionParamter:getAppIndex withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
                success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];
}

- (void)loginWithPhone:(NSString *)phone password:(NSString *)password success:(NetworkSuccess)success failure:(NetworkFailure)failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    [RowParams setValue:phone forKey:@"telno"];
    [RowParams setValue:[password md5Str] forKey:@"password"];
    
    [super sendRequestToServiceByPost:[self connectionParamter:login withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];

}

- (void)getPersonInfoWithUserId:(NSString *)userId
                      userToken:(NSString *)userToken
                        success:(void (^)(id result))success
                        failure:(void (^)(NSString * reason))failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    [RowParams setValue:userId forKey:@"userid"];
//  [RowParams setValue:userToken forKey:@"usertoken"];
    
    [super sendRequestToServiceByPost:[self connectionParamter:getPersonInfo withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];

    
}



- (void)setPersonInfoWithName:(NSString *)name
                          sex:(Sex)sex addr:(NSString *)addr
                          age:(NSString *)age
                        headerImagePath:( NSString *)imagePath
                        email:(NSString *)email
                       cardno:(NSString *)cardno
                       userid:(NSString *)userId
                    userToken:(NSString *)userToken
                      success:(void (^)(id result))success
                      failure:(void (^)(NSString * reason))failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    [RowParams setValue:userId forKey:@"userid"];
    //  [RowParams setValue:userToken forKey:@"usertoken"];
    [RowParams setValue:name forKey:@"name"];
    [RowParams setValue:[NSNumber numberWithInt:sex] forKey:@"sex"];
    
    [RowParams setValue:age forKey:@"age"];
    [RowParams setValue:email forKey:@"email"];
    [RowParams setValue:addr forKey:@"addr"];
    [RowParams setValue:cardno forKey:@"cardno"];
    [RowParams setValue:imagePath forKey:@"imgurl"];
    
    [super sendRequestToServiceByPost:[self connectionParamter:setPersonInfo withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];
    
}

- (void)getAppNewsWithLastTime:(long long)lastTime
                       success:(void (^)(id result))success
                       failure:(void (^)(NSString * reason))failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
    [RowParams setValue:[NSNumber numberWithLongLong:lastTime] forKey:@"needTime"];
    
    [super sendRequestToServiceByPost:[self connectionParamter:getAppNews withDic:RowParams] url:@"http://msapi.cloudream.net/rpc.php?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" success:^(id result) {
        if (success) {
            success(result);
        }
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];
    
}

-(void)fileUploadImage:(UIImage *)image success:(NetworkFailure)success failure:(NetworkFailure)failure
{
    NSMutableDictionary * RowParams = [NSMutableDictionary dictionary];
//    [RowParams setValue:@"1442056218" forKey:@"time"];
//    [RowParams setValue:@"6a04039b565f8b7e8fced79faff73238" forKey:@"token"];
    
    [super uploadImgaeToServiceByPostWithURL:@"http://msapi.cloudream.net/file/commonIndex/uploadUserFace?time=1442056218&token=6a04039b565f8b7e8fced79faff73238" Params:RowParams images:@[image] success:^(id result) {
        if (success) {
            success(result);
        }
       
    } failure:^(id reason) {
        if (failure) {
            failure(reason);
        }
    } requestSerializer:NO responseSerializer:YES];
    
}


-(void)getTdDataWithTdNumber:(NSString *)tdNumber success:(void (^)(id result))success failure:(void (^)(NSString * reason))failure
{
     [super postRequestWithURL:nil content:tdNumber success:^(id result) {
          success (result);
     } failure:^(id reason) {
          failure (reason);
     }];
}

- (NSDictionary *)connectionParamter:(ParamClass )paramClass
                             withDic:(NSDictionary *)dic
{
    NSMutableDictionary *paramdic = [NSMutableDictionary dictionary];
    NSString *method;
    switch (paramClass) {
        case login:
            method = LOGIN;
            break;
        case regist:
            method = REGIST;
            break;
        case getVCode:
            method = GET_VCODE;
            break;
        case getProductList:
            method = GET_PRODUCT_LIST;
            break;
        case getAppIndex:
            method = GET_APP_INDEX;
            break;
        case getPersonInfo:
            method = GET_PERSON_INFO;
            break;
        case setPersonInfo:
            method = SET_PERSION_INFO;
            break;
        case getAppNews:
            method = GET_APP_NEWS;
            break;
        case resetPassword:
            method = RESET_PASSWORD;
            break;
        default:
            break;
    }
    
    NSAssert(method!=nil, @"请求类不正确");
    
    [paramdic setValue:method forKey:@"method"];
    [paramdic setValue:@"12" forKey:@"id"];
    [paramdic setValue:@"2.0" forKey:@"jsonrpc"];
    if (dic) {
        [paramdic setValue:@[dic] forKey:@"params"];
    }
    return paramdic;
    
}
@end
