//
//  INCycleScrollView.m
//  INCycleScrollView
//
//  Created by Yigol Chan on 15/5/31.
//  Copyright (c) 2015年 Injoinow. All rights reserved.
//

#import "INCycleScrollView.h"
#import "INCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "CDBanner.h"

static NSString *cellID = @"INCycleCellIdentifier";
static const CGFloat kPageControlHeight = 30.0f;
static const CGFloat kItemsCoefficient = 10.0f;
static const NSTimeInterval kDefaultAutoScrollTimeInterval = 3.0f;

@interface INCycleScrollView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *mainView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, strong) NSArray *imageUrlsArray;
@property (nonatomic, assign) NSInteger totalItemsCount;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation INCycleScrollView

+ (instancetype)cycleScrollViewWithFrame:(CGRect)frame imageURLs:(NSArray *)imageURLs
{
    INCycleScrollView *cycleScrollView = [[INCycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.imageUrlsArray = imageURLs;
    return cycleScrollView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initCustomViews];
    }
    return self;
}

- (void)initCustomViews
{
//    [_mainView updateConstraintsIfNeeded];
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = self.frame.size;
    _flowLayout.sectionInset = UIEdgeInsetsZero;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _mainView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _mainView.delegate = self;
    _mainView.dataSource = self;
    _mainView.pagingEnabled = YES;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.showsHorizontalScrollIndicator = NO;
//    _mainView.backgroundColor = [UIColor lightGrayColor];
    [self.mainView registerClass:[INCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    [self addSubview:_mainView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height + kPageControlHeight, self.bounds.size.width,kPageControlHeight)];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.backgroundColor = [UIColor redColor];
    [self addSubview:_pageControl];
    
    _autoScrollTimeInterval = kDefaultAutoScrollTimeInterval;
}

- (void)setImageUrlsArray:(NSArray *)imageUrlsArray
{
    _imageUrlsArray = imageUrlsArray;
    
    if (imageUrlsArray.count > 1) {
        _totalItemsCount = imageUrlsArray.count * kItemsCoefficient;
    } else {
        _totalItemsCount = imageUrlsArray.count;
    }
    [self layoutSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _mainView.contentInset = UIEdgeInsetsZero;
    
    if (!self.imageUrlsArray.count) {
        return;
    }
    
    [self.mainView reloadData];
    
    self.pageControl.numberOfPages = self.imageUrlsArray.count;
    
    if (self.imageUrlsArray.count == 1) {
        self.mainView.scrollEnabled = NO;
        return;
    }
    
    if (self.mainView.contentOffset.x == 0 && self.totalItemsCount) {
        // 首先滚动到中间，方便以后的向前 向后滑动
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.totalItemsCount/2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    // 最小时间间隔为0.3s
    if (self.autoScrollTimeInterval >= 0.3) {
        [self setupTimer];
    }
}

- (void)setupTimer
{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)automaticScroll
{
    if (!self.totalItemsCount) {
        return;
    }
    
    NSInteger currentIndex = self.mainView.contentOffset.x / self.bounds.size.width;
    NSInteger targetIndex = currentIndex + 1;
    //当滚动到最后一个的时候，马上回到中间
    if (targetIndex == self.totalItemsCount) {
        targetIndex = self.totalItemsCount/2;
        [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
    [self.mainView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    INCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
   
    // 这里改成了使用模型加载
    CDBanner *banner = self.imageUrlsArray[indexPath.item % self.imageUrlsArray.count];
    [cell.inImageView sd_setImageWithURL:[NSURL URLWithString:banner.imagePath]];
//    [cell.inImageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a0daf6b29b16fdfad83995aed2b2b866/7acb0a46f21fbe096c56ce8d6d600c338744ad1a.jpg"]];
    
    self.pageControl.currentPage = indexPath.item % self.imageUrlsArray.count;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cycleScrollview:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollview:self didSelectItemAtIndex:indexPath.item % self.imageUrlsArray.count];
    }
}

#pragma mark - viewsMethod
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (_timer) {
        if (_timer.isValid) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}

- (void)dealloc
{
    _mainView.delegate = nil;
    _mainView.dataSource = nil;
}

@end
