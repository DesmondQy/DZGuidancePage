//
//  DZGuidancePageController.h
//  DZGuidancePage
//
//  Created by 赵卫东 on 2017/5/16.
//  Copyright © 2017年 DZ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DZGuidancePageCell;


typedef void(^DZGuidancePageSetupCellHandler)(DZGuidancePageCell *cell, NSIndexPath *indexPath);
typedef void(^DZGuidancePageFinishHandler)(UIButton *finishBtn);

@interface DZGuidancePageController : UIViewController
- (instancetype)initWithPagesCount:(NSInteger)count setupCellHandler:(DZGuidancePageSetupCellHandler)setupCellHandler finishHandler:(DZGuidancePageFinishHandler)finishHandler ;
@property (strong, nonatomic, readonly) UIPageControl *mPageControl;
@property (strong, nonatomic, readonly) UICollectionView *mCollectionView;
@property (assign, nonatomic, readonly) NSInteger mCount;

@end
