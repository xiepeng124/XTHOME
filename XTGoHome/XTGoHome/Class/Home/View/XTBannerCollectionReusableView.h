//
//  XTBannerCollectionReusableView.h
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/8.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTHomeSectionView.h"
@interface XTBannerCollectionReusableView : UICollectionReusableView
@property (strong,nonatomic) XTHomeSectionView *homeSetionView;
@property (strong,nonatomic) SDCycleScrollView *cycleScrollView;
@end
