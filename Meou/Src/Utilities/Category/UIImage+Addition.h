//
//  UIImage+Addition.h
//  Pokitfood
//
//  Created by Yigol Chan on 15/4/8.
//  Copyright (c) 2015年 Injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)
/**
 *  @brief  创建带颜色的图片
 *
 *  @param color 颜色
 *
 *  @return 返回图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  @brief  压缩图片的尺寸
 *
 *  @param image   原始图片
 *  @param newSize 需要的尺寸
 *
 *  @return 返回压缩后的图片
 */
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;


- (UIColor *)colorAtPixel:(CGPoint )point;

@end
