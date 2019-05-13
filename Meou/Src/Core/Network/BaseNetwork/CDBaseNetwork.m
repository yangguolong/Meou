//
//  BaseNetwork.m
//  MinLED
//
//  Created by Yigol on 14/12/10.
//  Copyright (c) 2014年 injoinow. All rights reserved.
//

#import "CDBaseNetwork.h"
#import <AFNetworking/AFNetworking.h>
#import "CDNetworkStatus.h"
#import "AppMacro.h"
#import "NSString+Category.h"
#import "MJExtension.h"

#define key @"test"
#define app_secret_key @"app_secret"
#define app_secret_value @"test001"
#define token_key @"token"


@interface CDBaseNetwork ()
/** 请求管理类 */
@property (nonatomic, strong) AFHTTPRequestOperationManager *manager;
/** 请求队列 */
@property (nonatomic, strong) AFHTTPRequestOperation *currentRequestOperation;



@end
@implementation CDBaseNetwork


- (void)sendRequestToServiceByPost:(NSDictionary *)params url:(NSString *)url
                           success:(NetworkSuccess)success
                           failure:(NetworkFailure)failure
                 requestSerializer:(BOOL)isRequestSerializer
                responseSerializer:(BOOL)isResponseSerializer
{
    DLog(@"请求开始，请求方式为：POST");
    BOOL b = [self configureRequest:isRequestSerializer responseSerializer:isResponseSerializer];
 
    if (!b) {
        failure(@"没有网络");
        return;
    }
    
//    NSString *URL = @"http://msapi.cloudream.net/rpc.php?surveyor=guest&termno=t01&time=1442056218&token=2b77b1adfab16fcbd73ca427cdbdec0f";
    DLog(@"请求的URL为：%@",url);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
//    [request setValue:@"application/x-www-form-urlencoded"
//   forHTTPHeaderField:@"Contsetent-Type"];
    
    // 添加body
   NSString *str = [params JSONString];
    
    DLog(@"设置请求参数：%@",str);
    if (str) {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:data];

    }
 
    self.currentRequestOperation =
    [self.manager HTTPRequestOperationWithRequest:request
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              ;
                                              
//                                              NSString *result =[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//                                              NSMutableDictionary *resultDic = [NSMutableDictionary DICTIONARYWITH]
//                                                DLog(@"请求结果:%@", );
                                              if([responseObject objectForKey:@"error"]){
                                                  DLog(@"请求失败:%@", responseObject);
                                                  
                                                  if (responseObject[@"error"][@"message"]) {
                                                      DLog(@"失败原因:%@", responseObject[@"error"][@"message"]);
                                                        failure(responseObject[@"error"][@"message"]);
                                                  }
                
                                              }else if(responseObject[@"result"]){
                                                  
                                              success(responseObject[@"result"]);
                                               DLog(@"请求成功:%@", responseObject[@"result"]);
                                              }else{
                                               DLog(@"请求结果:%@", responseObject);
                                              }
                                          }
                                          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              
                                              DLog(@"请求结果失败 原因:%@", error.localizedDescription);
                                              failure(error.localizedDescription);
                                              // 失败后的处理
                                          }];
    [self.manager.operationQueue addOperation:self.currentRequestOperation];
    DLog(@"请求结束")
}


- (BOOL)configureRequest:(BOOL)isRequestSerializer
      responseSerializer:(BOOL)isResponseSerializer
{
//    DLog(@"设置请求配置开始。");
    
    if (![[CDNetworkStatus shareInstance] haveNetWork]) {
//        DLog(@"没有网络");
        return NO;
    }
    
    self.manager = [AFHTTPRequestOperationManager manager];
    
    // 假如当前的请求队列存在，取消请求。防止重复请求。
    if (self.currentRequestOperation) {
        [self.currentRequestOperation cancel];
    }
    
//    self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/xml"];
    
    self.manager.requestSerializer.timeoutInterval = 30;
    
    // 请求参数是否需要序列化。
    if (isRequestSerializer) {
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    // 返回参数是否需要序列化。
    if (isResponseSerializer) {
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer]; //AFJSONResponseSerializer
    }
    
    DLog(@"设置请求配置  结束。");
    return YES;
}

- (void)sendRequestToServiceByPostWithAction:(NSString *)actionName
                                      params:(NSDictionary *)param
                                     success:(NetworkSuccess)success
                                     failure:(NetworkFailure)failure
                           requestSerializer:(BOOL)isRequestSerializer
                          responseSerializer:(BOOL)isResponseSerializer
{
    DLog(@"请求开始，请求方式为：POST");
    
    BOOL b = [self configureRequest:isRequestSerializer responseSerializer:isResponseSerializer];
    
    if (!b) {
        
        failure(@"没有网络");
        
//        DLog(@"请求结束，请求方式为：POST");
        
        return;
    }

    
    self.currentRequestOperation = [self.manager POST:[SERVICE_URL stringByAppendingString:actionName]
                                           parameters:[self addOtherParam:param]
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  
                                                  DLog(@"请求成功结果:%@", responseObject);
                                                  DLog(@"请求结束，请求方式为：POST");
                                                  
                                                  success(responseObject);
//                                                  BaseEntity *bEntity = [[BaseEntity alloc] init];
//                                                  bEntity = [BaseEntity objectWithKeyValues:responseObject];
//                                                  if (bEntity.err == 0) {
//                                                      success(responseObject);
//                                                  }else{
//                                                      failure ([self checkError:bEntity.err]);
//                                                  }
                                                  
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  
                                                  DLog(@"请求结果失败 原因:%@", error.localizedDescription);
                                                  DLog(@"请求结束，请求方式为：POST");
                                                  
                                                  failure(error.localizedDescription);
                                              }];
}

- (void)uploadImgaeToServiceByPostWithURL:(NSString *)url
                                   Params:(NSDictionary *)param
                                   images:(NSArray *)images
                                  success:(NetworkSuccess)success
                                  failure:(NetworkFailure)failure
                        requestSerializer:(BOOL)isRequestSerializer
                       responseSerializer:(BOOL)isResponseSerializer;

{
    DLog(@"请求开始...上传图片，请求方式为：POST");
    
    BOOL b = [self configureRequest:isRequestSerializer responseSerializer:isResponseSerializer];
    
    if (!b) {
        
        failure(@"没有网络");
        
        DLog(@"请求结束，请求方式为：POST");
        
        return;
    }
    
    [self configureRequest:isRequestSerializer responseSerializer:isResponseSerializer];
    self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];

    self.currentRequestOperation = [self.manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {

        if (images) {
            for (NSInteger i = 0 ;i < images.count; i ++) {
                NSData *imageData = UIImagePNGRepresentation(images[i]);
                [formData appendPartWithFileData:imageData name:@"file" fileName:@"1.png" mimeType:@"image/png"];
//                [formData appendPartWithFormData:imageData name:@"file"];

            }
        }
        
    } success:^(AFHTTPRequestOperation * operation, id responseObject) {
       
        
        DLog(@"请求结束，请求方式为：POST");
        
        if([responseObject objectForKey:@"error"]){
            DLog(@"请求失败:%@", responseObject);
            
            if (responseObject[@"error"][@"message"]) {
                DLog(@"失败原因:%@", responseObject[@"error"][@"message"]);
                failure(responseObject[@"error"][@"message"]);
            }
            
        }else if(responseObject[@"result"]){
            
            success(responseObject[@"result"]);
            DLog(@"请求成功:%@", responseObject[@"result"][@"url"]);
        }else{
            DLog(@"请求结果:%@", responseObject);
        }
    

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLog(@"请求结果失败 原因:%@", error.localizedDescription);
        
        DLog(@"请求结束，请求方式为：POST");
        
        failure(error.localizedDescription);
    }];
    
    DLog(@"请求结束 ...上传图片，请求方式为：POST");
}

- (void)sendRequestToServiceByGet:(NSDictionary *)parms
                          success:(NetworkSuccess)success
                          failure:(NetworkFailure)failure
                requestSerializer:(BOOL)isRequestSerializer
               responseSerializer:(BOOL)isResponseSerializer
{
    DLog(@"请求开始，请求方式为：GET");
    
    
    BOOL b = [self configureRequest:isRequestSerializer responseSerializer:isResponseSerializer];
    
    if (!b) {

          failure(@"没有网络");
        return;
    }
//    NSMutableString * str = [NSMutableString string];
//    NSDictionary * dic = [self addOtherParam:parms];
//    
//    [dic enumerateKeysAndObjectsUsingBlock:^(id k, id obj, BOOL *stop) {
//        [str appendFormat:@"%@=%@&",k,obj];
//        
//    }];
    
//    DLog(@"%@",[NSString stringWithFormat:@"%@%@",SERVICE_URL,str]);
    
    self.currentRequestOperation = [self.manager GET:SERVICE_URL
                                          parameters:[self addOtherParam:parms] success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              
                                              
                                              DLog(@"请求结果:%@", responseObject);
                                              
//                                              DLog(@"请求结束，请求方式为：GET");
//                                              if (!responseObject) {
//                                                  failure(@"");
//                                                  DLog(@"请求结果空");
//                                                  return ;
//                                              }
                                              // 错误处理
//                                              BaseEntity *bEntity = [[BaseEntity alloc] init];
//                                              bEntity = [BaseEntity objectWithKeyValues:responseObject];
//                                              if (bEntity.err == 0) {
//                                                   success(responseObject);
//                                              }else{
//                                                failure ([self checkError:bEntity.err]);
//                                              }
                                             
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              
                                              DLog(@"请求结果失败 原因:%@", error.localizedDescription);
                                              
                                              DLog(@"请求结束，请求方式为：GET");
                                              
                                              failure(error.localizedDescription);
                                          }];
}
static bool isDownload;

-(void)downloadResourceByGet:(NSDictionary *)parms progress:(NSProgress *)progress success:(NetworkSuccess)success failure:(NetworkFailure)failure requestSerializer:(BOOL)isRequestSerializer responseSerializer:(BOOL)isResponseSerializer{
    DLog(@"请求开始，请求方式为：GET");
    
    if (isDownload) {
        return;
    }
    isDownload = YES;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSMutableString * str = [NSMutableString string];
    
    [[self addOtherParam:parms] enumerateKeysAndObjectsUsingBlock:^(id k, id obj, BOOL *stop) {
        [str appendFormat:@"%@=%@&",k,obj];
        
    }];
    
    
    DLog(@" URL : %@",[NSString stringWithFormat:@"%@%@",SERVICE_URL,str]);

    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVICE_URL,str]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        DLog(@">>>>>>>>>>%f",(float)totalBytesWritten/ (float)totalBytesExpectedToWrite);
    }];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        isDownload = NO;
        DLog(@"File downloaded to: %@", filePath);
        if (error) {
            failure (error);
        }else{
            success (response.suggestedFilename);
        }
        
    }];
    [downloadTask resume];


}


-(void)download3DResource:(NSString *)URLStr progress:(NSProgress *)progress success:(NetworkSuccess)success failure:(NetworkFailure)failure requestSerializer:(BOOL)isRequestSerializer responseSerializer:(BOOL)isResponseSerializer{
    DLog(@"请求开始，请求方式为：GET");
    
//    if (isDownload) {
//        return;
//    }
//    isDownload = YES;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSMutableString * str = [NSMutableString string];
//    
//    [[self addOtherParam:parms] enumerateKeysAndObjectsUsingBlock:^(id k, id obj, BOOL *stop) {
//        [str appendFormat:@"%@=%@&",k,obj];
//        
//    }];
    
    // http://msapi.cloudream.net/index.php/file/file/resource_2015-09-14_1DB75F4F-DA0C-4c15-9A69-F8B7763CB3B7.zip
    DLog(@" URL : %@",URLStr);
    
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",SERVICE_URL,str]];
    NSURL * URL = [NSURL URLWithString:URLStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [manager setDownloadTaskDidWriteDataBlock:^(NSURLSession *session, NSURLSessionDownloadTask *downloadTask, int64_t bytesWritten, int64_t totalBytesWritten, int64_t totalBytesExpectedToWrite) {
        DLog(@">>>>>>>>>>%f",(float)totalBytesWritten/ (float)totalBytesExpectedToWrite);
    }];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        isDownload = NO;
        DLog(@"File downloaded to: %@", filePath);
        if (error) {
            failure (error);
        }else{
            success (response.suggestedFilename);
        }
    }];
    [downloadTask resume];
}

/**
 *  添加其他参数
 *
 *  @param param
 *
 *  @return
 */
- (NSMutableDictionary *)addOtherParam:(NSMutableDictionary *)param
{
    // 1.设置时间
    uint recordTime = [[NSDate date] timeIntervalSince1970];
    [param setValue:[NSString stringWithFormat:@"%u",recordTime] forKey:@"time"];
    
    // 2.计算token值
   NSString *tokenStr = [self calculationOfTokenWithDictionary:param];
    
    // 3.添加token
    [param setValue:tokenStr forKey:token_key];
   
        NSMutableString * str = [NSMutableString string];
        NSDictionary * dic = param;
    
        [dic enumerateKeysAndObjectsUsingBlock:^(id k, id obj, BOOL *stop) {
            [str appendFormat:@"%@=%@&",k,obj];
    
        }];
    
        DLog(@" URL : %@",[NSString stringWithFormat:@"%@%@",SERVICE_URL,str]);
    
    return param;
}

/**
 *  计算token
 *
 *  @param param
 *
 *  @return
 */
- (NSString *)calculationOfTokenWithDictionary:(NSDictionary *)param
{
    // 1.转换成NSMutableString 排序
    NSMutableString *mString = [NSMutableString string];
    
    // 2.
    NSArray *keys = [param allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSLiteralSearch];
    }];
    
    for (NSString *dictKey in sortedKeys) {
          id value = [param valueForKey:dictKey];
        [mString appendString:dictKey];
        [mString appendString:@"="];
        [mString appendString:[NSString stringWithFormat:@"%@",value]];
    }
//    [mString appendString:app_secret_key];
//    [mString appendString:@"="];
//    [mString appendString:app_secret_value];
    
    // 3.MD5加密 转化成小写
    NSString *md5Str = [[mString md5Str] lowercaseString];
 
    return md5Str;
}

-(NSString *)checkError:(long long)error{
    switch (error) {
        case -1:
            DLog(@"未知错误");
            return @"";
            break;
        case 1:
            DLog(@"无效token");
            return @"无效token";
            break;
        case 2:
            DLog(@"无效app key");
            return @"无效app key";
            break;
        case 3:
            DLog(@"参数有无或者缺少必填参数");
            return @"";
            break;
        case 4:
            DLog(@"无效action");
            return @"";
            break;
        case 5:
            DLog(@"action参数不正确");
            return @"";
            break;
        case 6:
            DLog(@"邮箱已存在");
            return @"邮箱已存在";
            break;
        case 7:
            DLog(@"邮箱或密码不正确");
            return @"邮箱或密码不正确";
            break;
        case 8:
            DLog(@"无效用户Token");
            return @"无效用户Token";
            break;
        case 9:
            DLog(@"邮箱或密码不正确");
            return @"邮箱或密码不正确";
            break;
        case 10:
            DLog(@"收藏不存在");
            return @"收藏不存在";
            break;
        case 11:
            DLog(@"收藏已存在");
            return @"收藏已存在";
            break;
        case 12:
            DLog(@"上传的文件格式错误");
            return @"上传的文件格式错误";
            break;
        case 13:
            DLog(@"上传的文件太大");
            return  @"上传的文件太大";
            break;
        default:
            break;
    }
    return nil;
}

- (void)requestCancle
{
    DLog(@"取消请求  开始。");
    if (self.currentRequestOperation) {
        [self.currentRequestOperation cancel];
    }
    DLog(@"取消请求  结束。");
}

+(NSString *)downloadZipPath{
    
    NSString * zippath= [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)firstObject];

    return zippath;
}

@end
