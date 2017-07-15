//
//  XTHomeCollectionViewCell.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/8.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTHomeCollectionViewCell.h"

@implementation XTHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [XTColor colorWithHexString:WHITE_COLOR];
    self.perImage.layer.cornerRadius = 3
    ;
    self.perImage.layer.masksToBounds = YES;
    self.personName.textColor = [XTColor colorWithHexString:DARK_COLOR];
    
    // Initialization code
}

@end
