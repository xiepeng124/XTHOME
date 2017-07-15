//
//  XTHomeCollectionReusableView.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/8.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTHomeCollectionReusableView.h"

@implementation XTHomeCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [XTColor colorWithHexString:WHITE_COLOR];
    self.menuTitle.textColor = [XTColor colorWithHexString:DARK_COLOR];
    self.lineView.backgroundColor = [XTColor colorWithHexString:BACK_COLOR];
    // Initialization code
}

@end
