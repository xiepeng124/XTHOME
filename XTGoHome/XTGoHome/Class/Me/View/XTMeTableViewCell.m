//
//  XTMeTableViewCell.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/11.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTMeTableViewCell.h"

@implementation XTMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.menuTitle.textColor = [XTColor colorWithHexString:DARK_GARY_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
