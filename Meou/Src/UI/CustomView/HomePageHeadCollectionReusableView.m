//
//  HomePageHeadCollectionReusableView.m
//  Meou
//
//  Created by 杨国龙 on 15/10/10.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "HomePageHeadCollectionReusableView.h"
#import "INCycleScrollView.h"

@implementation HomePageHeadCollectionReusableView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
//        _scrollView = [MJNewsView newsView];
//        _scrollView.frame = self.frame;//CGRectMake(0, 0, WIDTH(self.slideView), HEIGHT(self.slideView));
//        [self addSubview:_scrollView];
    }
    return self;
}

- (void)layoutSubviews
{
    _scrollView.frame = self.frame;
}

@end
