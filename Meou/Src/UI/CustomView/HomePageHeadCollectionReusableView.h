//
//  HomePageHeadCollectionReusableView.h
//  Meou
//
//  Created by 杨国龙 on 15/10/10.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJNewsView.h"

@interface HomePageHeadCollectionReusableView : UICollectionReusableView


@property (weak, nonatomic)IBOutlet MJNewsView *scrollView;

@end
