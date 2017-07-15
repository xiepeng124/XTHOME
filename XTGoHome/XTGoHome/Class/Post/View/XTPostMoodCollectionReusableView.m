//
//  XTPostMoodCollectionReusableView.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/12.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTPostMoodCollectionReusableView.h"

@implementation XTPostMoodCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    _postButton.backgroundColor = [XTColor colorWithHexString:DARK_PINK_COLOR];
    [_postButton setTitleColor:[XTColor colorWithHexString:WHITE_COLOR]
                      forState:UIControlStateNormal];
    _postButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:18];
    _postButton.layer.cornerRadius = 4;
   _postButton.layer.shadowOpacity = 0.9;
    //        阴影的颜色
    _postButton.layer.shadowColor = [XTColor colorWithHexString:DARK_PINK_COLOR].CGColor;
    //   阴影的位移
    _postButton.layer.shadowOffset = CGSizeMake(0, 4);
    //       阴影的模糊程度
    self.postButton.layer.shadowRadius = 5;

    // Initialization code
}

@end
