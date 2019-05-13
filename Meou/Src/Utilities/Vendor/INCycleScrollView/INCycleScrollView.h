//
//  INCycleScrollView.h
//  INCycleScrollView
//
//  Created by Yigol Chan on 15/5/31.
//  Copyright (c) 2015年 Injoinow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INCycleScrollView;

@protocol INCycleScrollViewDelegate <NSObject>

@optional
- (void)cycleScrollview:(INCycleScrollView *)cycleScrollview didSelectItemAtIndex:(NSInteger)index;

@end

@interface INCycleScrollView : UIView
/**
 *  @brief  代理
 */
@property (nonatomic, weak) id <INCycleScrollViewDelegate> delegate;
/**
 *  @brief  图片循环滚动时间间隔，如果不设置，默认3s；如果设为0，表示不滚动
 */
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;


@property (nonatomic, strong) NSArray *imageUrlsArray;

/**
 *  @brief  类方法创建
 *
 *  @param frame     自身的frame
 *  @param imageURLs 图片链接的数组
 *
 *  @return INCycleScrollView
 */
+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame
                               imageURLs:(NSArray *)imageURLs;


@end
