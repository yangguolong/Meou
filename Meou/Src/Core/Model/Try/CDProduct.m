//
//  CDProduct.m
//  Meou
//
//  Created by 杨国龙 on 15/10/14.
//  Copyright © 2015年 cloudream. All rights reserved.
//

#import "CDProduct.h"
#import "MJExtension.h"

@implementation CDProduct

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id",@"desc" : @"description"};
}

@end
