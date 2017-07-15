//
//  XTSlideSegmented.h
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/10.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XTSlideSegmentDelegate <NSObject>

- (void)slideSegmentDidSelectedAtIndex:(NSInteger)index;

@end

@interface XTSlideSegmented : UIView
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIColor *itemNormalColor;

@property (nonatomic, strong) UIColor *itemSelectedColor;

@property (nonatomic, assign) BOOL showTitlesInNavBar;

@property (nonatomic, assign) BOOL hideShadow;

@property (nonatomic, weak) id<XTSlideSegmentDelegate>delegate;

@property (nonatomic, assign) CGFloat progress;

//忽略动画
@property (nonatomic, assign) BOOL ignoreAnimation;

@end
