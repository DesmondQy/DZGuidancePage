//
//  DZGuidancePageController.m
//  DZGuidancePage
//
//  Created by 赵卫东 on 2017/5/16.
//  Copyright © 2017年 DZ. All rights reserved.
//

#import "DZGuidancePageController.h"
#import "DZGuidancePageCell.h"

@interface DZGuidancePageController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (copy, nonatomic) DZGuidancePageSetupCellHandler setupCellHandler;
@property (copy, nonatomic) DZGuidancePageFinishHandler finishHandler;

@property (nonatomic, strong) UICollectionView *mCollectionView;
@property (nonatomic, strong) UIPageControl *mPageControl;
@property (nonatomic, assign) NSInteger mCount;
@end

static NSString *const DZGuidancePageCellId = @"DZGuidancePageCellId";


@implementation DZGuidancePageController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (instancetype)initWithPagesCount:(NSInteger)count setupCellHandler:(DZGuidancePageSetupCellHandler)setupCellHandler finishHandler:(DZGuidancePageFinishHandler)finishHandler {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _mCount = count;
        _setupCellHandler = [setupCellHandler copy];
        _finishHandler = [finishHandler copy];
        // 添加collectionView -- 使用懒加载初始化
        [self.view addSubview:self.mCollectionView];
        // 添加pageControl  -- 使用懒加载初始化
        [self.view addSubview:self.mPageControl];
        // 注册cell
        [self.mCollectionView registerClass:[DZGuidancePageCell class] forCellWithReuseIdentifier:DZGuidancePageCellId];
    }
    return self;
}




#pragma mark - UITableViewDelegate


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DZGuidancePageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DZGuidancePageCellId forIndexPath:indexPath];
    if (indexPath.row != self.mCount-1) {
        cell.finishBtn.hidden = YES;
    }
    else {
        // 随后一页 显示按钮, 并且添加响应方法
        cell.finishBtn.hidden = NO;
        [cell.finishBtn addTarget:self action:@selector(finishBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    // 设置数据
    if (self.setupCellHandler) {
        self.setupCellHandler(cell, indexPath);
    }
    return cell;
}

- (void)finishBtnOnClick:(UIButton *)finishBtn {
    if (self.finishHandler) {
        self.finishHandler(finishBtn);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 向下取整
    NSInteger currentPage = scrollView.contentOffset.x/scrollView.bounds.size.width + 0.5;
    if (self.mPageControl.currentPage != currentPage) {
        self.mPageControl.currentPage = currentPage;
    }
}

#pragma mark - Public  公共方法

#pragma mark - Private  私有方法

#pragma mark - get    懒加载


-(UICollectionView *)mCollectionView{
    if (!_mCollectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = self.view.bounds.size;
        layout.minimumLineSpacing = 0.f;
        layout.minimumInteritemSpacing = 0.f;
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.pagingEnabled = YES;
        collectionView.bounces = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        _mCollectionView = collectionView;
    }
    return _mCollectionView;
}


-(UIPageControl *)mPageControl{
    if (!_mPageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.numberOfPages = self.mCount;
        pageControl.currentPage = 0;
        CGSize pageControlSize = [pageControl sizeForNumberOfPages:self.mCount];
        CGFloat pageControlX = (self.view.bounds.size.width - pageControlSize.width)/2;
        // 距离屏幕下方为 50 请根据具体情况修改吧
        CGFloat pageControlY = (self.view.bounds.size.height - pageControlSize.height - 50.f);
        pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlSize.width, pageControlSize.height);
        _mPageControl = pageControl;
    }
    return _mPageControl;

}




@end
