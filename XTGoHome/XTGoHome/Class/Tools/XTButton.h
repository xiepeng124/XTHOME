//
//  XTButton.h
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/13.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XTButton : UIButton<CAAnimationDelegate>
@property (nonatomic, assign) CGFloat maxLeft;
@property (nonatomic, assign) CGFloat maxRight;
@property (nonatomic, assign) CGFloat maxHeight;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, strong) NSArray *images;

- (instancetype)initWithFrame:(CGRect)frame maxLeft:(CGFloat)maxLeft maxRight:(CGFloat)maxRight maxHeight:(CGFloat)maxHeight;

- (void)generateBubbleWithImage:(UIImage *)image;

- (void)generateBubbleInRandom;
@end
