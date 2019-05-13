//
//  INCollectionViewCell.m
//  INCycleScrollView
//
//  Created by Yigol Chan on 15/5/31.
//  Copyright (c) 2015年 Injoinow. All rights reserved.
//

#import "INCollectionViewCell.h"

@implementation INCollectionViewCell{
    UIScrollView * _scrollview;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollview = [[UIScrollView alloc]initWithFrame:self.bounds];
        
        _scrollview.showsHorizontalScrollIndicator = NO;
        
        _scrollview.showsVerticalScrollIndicator = NO;
        _inImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [_scrollview addSubview:_inImageView];
        
        [self.contentView addSubview:_scrollview];
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    }

@end
