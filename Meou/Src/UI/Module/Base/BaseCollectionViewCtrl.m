//
//  BaseCollectionViewCtrl.m
//  Meou
//
//  Created by 杨国龙 on 15/9/28.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "BaseCollectionViewCtrl.h"

@interface BaseCollectionViewCtrl ()

@end

@implementation BaseCollectionViewCtrl

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.navigationController.viewControllers.count > 1) {
        
        [self setUpLeftBarItem];
    }
}
- (void)setUpLeftBarItem{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(leftBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:[self leftBarItemIcon]] forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
    
}

- (void)setUpRightBarItem{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(rightBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[UIImage imageNamed:[self rightBarItemIcon]] forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
    
}

- (void)setUpRightTitle:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn addTarget:self action:@selector(rightBarItemPress:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [btn setAttributedTitle:[self attributedStrWithText:[btn titleForState:UIControlStateNormal]
                                                  Color:[UIColor whiteColor]]
                   forState:UIControlStateNormal];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (NSMutableAttributedString *)attributedStrWithText:(NSString *)text Color:(UIColor *)color{
    
    NSMutableAttributedString *attriButedStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attriButedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15]
                          range:NSMakeRange(0, [attriButedStr length])];
    
    [attriButedStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, [attriButedStr length])];
    
    return attriButedStr;
}
- (void)leftBarItemPress:(id)sender{
    
    if (self.navigationController.viewControllers.count > 1) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        
    }
}

- (void)rightBarItemPress:(id)sender{
    
}

- (NSString *)leftBarItemIcon{
    return @"back";
}

- (NSString *)rightBarItemIcon{
    return @"ico_refresh";
}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
