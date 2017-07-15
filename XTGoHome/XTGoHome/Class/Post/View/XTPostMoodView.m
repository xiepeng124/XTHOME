//
//  XTPostMoodView.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/11.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTPostMoodView.h"

@interface XTPostMoodView ()

@end

@implementation XTPostMoodView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.contentView = [[UITextView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 150)];
    _contentView.font = [UIFont fontWithName:FONT_REGULAR size:15];
    _contentView.textColor = [XTColor colorWithHexString:LIGHT_GARY_COLOR];
    _contentView.text = @"请发表您的心情(不超过两百字)";
    _contentView.backgroundColor = [XTColor colorWithHexString:WHITE_COLOR];
    _contentView.layer.cornerRadius = 3;
    _contentView.layer.masksToBounds = YES;
    self.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
  
         
    [self addSubview:_contentView];

}


@end
