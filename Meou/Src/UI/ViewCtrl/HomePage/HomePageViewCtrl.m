//
//  HomePageViewCtrl.m
//  Meou
//
//  Created by 杨国龙 on 15/10/10.
//  Copyright © 2015年 dragonstudio. All rights reserved.
//

#import "HomePageViewCtrl.h"
#import "HomePageHeadCollectionReusableView.h"
#import <UIView+MJExtension.h>
#import "CDHomePageResult.h"
#import "CDDocument.h"
#import "QRViewController.h"
#import "TabbarViewController.h"
#import "MMDrawerController.h"

@interface HomePageViewCtrl ()<UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)CDHomePageResult *data;


@end

@implementation HomePageViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1.加载数据
    [self setupDada];
 
    [self setUpRightBarItem];
    [self setUpLeftBarItem];
}

 - (CDHomePageResult *)data
{
    if (_data == nil) {
        _data = [[CDHomePageResult alloc] init];
    }
    return _data;
}
- (void)setupDada
{
    [[CDService shareInstance] getAppAdsWithSuccess:^(id result) {
        _data = result;
        [self.collectionView reloadData];
        
    } failure:^(NSString *reason) {
        
    }];
    
}

- (NSString *)leftBarItemIcon
{
    return @"nav_menu";
}

- (void)leftBarItemPress:(id)sender
{
    MMDrawerController *drawerVC   = ((TabbarViewController *)self.tabBarController).drawerController;
    [drawerVC openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (NSString *)rightBarItemIcon
{
    return @"nav_scan";
}
-(void)rightBarItemPress:(id)sender
{
    QRViewController *qrVC = [[QRViewController alloc] init];
    qrVC.qrUrlBlock = ^(NSString * result){
        NSLog(@"扫描二维码的结果：%@",result);
    };
    [self presentViewController:qrVC animated:YES completion:nil];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.documents.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePgaeCell" forIndexPath:indexPath];
    CDDocument *document = self.data.documents[indexPath.row];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:3];
    [BitmapUtils setImageWithImageView:imageView URLString:document.imagePath];
    UILabel *laybel = (UILabel *)[cell viewWithTag:4];
    laybel.text = [NSString stringWithFormat:@"%@" , document.name];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    HomePageHeadCollectionReusableView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomePageHeadCollectionReusableView" forIndexPath:indexPath];
    headerView.scrollView.newses = self.data.banners;
    headerView.frame = CGRectMake(0, 0, self.view.frame.size.width,  headerView.frame.size.height);
    return headerView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((self.view.mj_w - 30)/3, 130);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
