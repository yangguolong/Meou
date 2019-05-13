//
//  MJNewsCell.m
//  预习-03-无限滚动
//
//  Created by MJ Lee on 14-5-30.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJNewsCell.h"
#import "CDBanner.h"
#import "BitmapUtils.h"

@interface MJNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation MJNewsCell



- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

- (void)setBanner:(CDBanner *)banner
{
    _banner = banner;
    [BitmapUtils setImageWithImageView:self.iconView URLString:banner.imagePath];
    self.titleLabel.text = [NSString stringWithFormat:@"  %@", banner.name];
}


@end
