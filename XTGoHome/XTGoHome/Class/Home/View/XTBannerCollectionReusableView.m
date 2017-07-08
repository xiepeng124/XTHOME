//
//  XTBannerCollectionReusableView.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/8.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTBannerCollectionReusableView.h"
@interface XTBannerCollectionReusableView ()<SDCycleScrollViewDelegate>
@end

@implementation XTBannerCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}
-(void)createView{
    self.cycleScrollView =[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.46) delegate:self placeholderImage:[UIImage imageNamed:@"smallboy"]];
      self.cycleScrollView.autoScrollTimeInterval=2;
    [self addSubview:self.cycleScrollView];
    self.homeSetionView = [[XTHomeSectionView alloc]init];
    self.homeSetionView = [[[NSBundle mainBundle]loadNibNamed:@"HomeSectionView" owner:nil options:nil]lastObject];
    self.homeSetionView.frame = CGRectMake(0, SCREEN_WIDTH*0.46, SCREEN_WIDTH, 272);
    [self addSubview:self.homeSetionView];
}
@end
