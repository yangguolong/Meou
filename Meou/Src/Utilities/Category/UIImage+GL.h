//
//  UIImage+GK.h
//  CloudCrack
//
//  Created by ygl on 14-11-10.
//  Copyright (c) 2014年 goking. All rights reserved.

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

typedef enum : NSUInteger {
    UIImageGrayLevelTypeHalfGray    = 0,
    UIImageGrayLevelTypeGrayLevel   = 1,
    UIImageGrayLevelTypeDarkBrown   = 2,
    UIImageGrayLevelTypeInverse     = 3
} UIImageGrayLevelType;

@interface UIImage (GL)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

+ (UIImage *)middleStretchableImageWithKey:(NSString *)key;
+(UIImage*)imageContentFileWithName:(NSString*)imageName;
+(UIImage*)imageContentFileWithName:(NSString*)imageName ofType:(NSString*)type;

/**
 *  图片缩放处理
 *
 *  @param image   要处理的原图
 *  @param newSize 缩放的大小
 *
 *  @return 返回处理好的图片
 */
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
///剪切
+(UIImage*)imageWithImage:(UIImage*)image cutToRect:(CGRect)newRect;

// 按宽 等比压缩
+ (UIImage *)imageWithImage:(UIImage *)image ratioWidth:(CGFloat)newWidth;

///等比缩放
+(UIImage*)imageWithImage:(UIImage *)image ratioToSize:(CGSize)newSize;
///添加圆角
+(UIImage*)imageWithImage:(UIImage*)image roundRect:(CGSize)size;
///按最短边 等比压缩
+(UIImage*)imageWithImage:(UIImage *)image ratioCompressToSize:(CGSize)newSize;

+(UIImage *)imageWithData2:(NSData *)data scale:(CGFloat)scale;


// 图片处理 0 半灰色  1 灰度   2 深棕色    3 反色
+(UIImage*)imageWithImage:(UIImage*)image grayLevelType:(UIImageGrayLevelType)type;

//色值 变暗多少 0.0 - 1.0
+(UIImage*)imageWithImage:(UIImage*)image darkValue:(float)darkValue;

/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg   http://www.cocoachina.com/bbs/read.php?tid=165823
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL;

/**
 *  生成二维码图片
 *
 *  @param code   内容
 *  @param width  图片宽
 *  @param height 图片高
 *
 *  @return 生成的二维码图片
 */
+ (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

/**
 *  生成条形码
 *
 *  @param code   内容
 *  @param width  图片宽
 *  @param height 图片高
 *
 *  @return 生成的条形码图片
 */
+ (UIImage *)generateBarCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height;

@end

