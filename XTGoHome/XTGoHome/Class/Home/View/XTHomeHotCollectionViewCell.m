//
//  XTHomeHotCollectionViewCell.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/8.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTHomeHotCollectionViewCell.h"

@implementation XTHomeHotCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [XTColor colorWithHexString:WHITE_COLOR];
    self.videoTitle.textColor = [XTColor colorWithHexString:@"303030"];
    self.videoPerson.textColor = [XTColor colorWithHexString:DARK_GARY_COLOR];
    // Initialization code
}

@end
