//
//  BaseNetwork.h
//  MinLED
//
//  Created by Yigol on 14/12/10.
//  Copyright (c) 2014年 injoinow. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  网络操作成功的block处理。
 *
 *  @param result 结果, 是个泛型,具体回调依据业务层注释说明。
 */
typedef void(^NetworkSuccess)(id result);


/**
 *  网络操作失败的block处理。
 *
 *  @param reason 原因。
 */
typedef void(^NetworkFailure)(id reason);

@interface CDBaseNetwork : NSObject


- (void)sendRequestToServiceByPost:(NSDictionary *)params url:(NSString *)url
                           success:(NetworkSuccess)success
                           failure:(NetworkFailure)failure
                 requestSerializer:(BOOL)isRequestSerializer
                responseSerializer:(BOOL)isResponseSerializer;

- (void)postRequestWithURL:(NSString *)url content:(NSString *)text success:(NetworkSuccess)success
                                    failure:(NetworkFailure)failure;

-(void)download3DResource:(NSString *)URLStr progress:(NSProgress *)progress success:(NetworkSuccess)success failure:(NetworkFailure)failure requestSerializer:(BOOL)isRequestSerializer responseSerializer:(BOOL)isResponseSerializer;
/**
 *  通过POST方式上传图片
 *
 *  @param actionName           接口url
 *  @param param                参数
 *  @param images                图片数组
 *  @param success              成功时候的回调
 *  @param failure              失败时候的回调
 *  @param isRequestSerializer  请求参数是否序列化
 *  @param isResponseSerializer 响应参数是否序列化
 */
- (void)uploadImgaeToServiceByPostWithURL:(NSString *)url
                                    Params:(NSDictionary *)param
                            images:(NSArray *)images
                           success:(NetworkSuccess)success
                           failure:(NetworkFailure)failure
                 requestSerializer:(BOOL)isRequestSerializer
                responseSerializer:(BOOL)isResponseSerializer;

/**
 *  通过GET方式请求服务器
 *
 *  @param parms                参数
 *  @param success              成功时候的回调
 *  @param failure              失败时候的回调
 *  @param isRequestSerializer  请求参数是否序列化
 *  @param isResponseSerializer 响应参数是否序列化
 */
- (void)sendRequestToServiceByGet:(NSDictionary *)parms
                          success:(NetworkSuccess)success
                          failure:(NetworkFailure)failure
                requestSerializer:(BOOL)isRequestSerializer
               responseSerializer:(BOOL)isResponseSerializer;


//self.manager.responseSerializer.acceptableContentTypes = [self.manager.responseSerializer.acceptableContentTypes setByAddingObject: @"application/zip"];

-(void)downloadResourceByGet:(NSDictionary *)parms
                    progress:(NSProgress *)progress
                     success:(NetworkSuccess)success
                     failure:(NetworkFailure)failure
           requestSerializer:(BOOL)isRequestSerializer
          responseSerializer:(BOOL)isResponseSerializer;


/**
 *  取消当前的连接。
 */
- (void)requestCancle;

+(NSString *)downloadZipPath;


@end
