//
//  XTHomeSectionView.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/8.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTHomeSectionView.h"

@implementation XTHomeSectionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.onelabel.textColor = [XTColor colorWithHexString:@"303030"];
    self.onelabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.twolabel.textColor = [XTColor colorWithHexString:@"303030"];
    self.twolabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.threelabel.textColor = [XTColor colorWithHexString:@"303030"];
    self.threelabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.fourlabel.textColor = [XTColor colorWithHexString:@"303030"];
    self.fourlabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.fivelabel.textColor = [XTColor colorWithHexString:@"303030"];
    self.fivelabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.sixlabel.textColor = [XTColor colorWithHexString:@"303030"];
    self.sixlabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.threelabel.textColor = [XTColor colorWithHexString:@"303030"];
    self.threelabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.lineView.backgroundColor = [XTColor colorWithHexString:BACK_COLOR];
    _recruitButton.layer.cornerRadius = 3;
    _recruitButton.layer.shadowOpacity = 0.8;
    _recruitButton.layer.shadowColor = [XTColor colorWithHexString:DARK_COLOR].CGColor;
    _recruitButton.layer.shadowOffset = CGSizeMake(0, 1);
    _recruitButton.layer.shadowRadius = 1;
    _serviceButton.layer.cornerRadius = 3;
    _serviceButton.layer.shadowOpacity = 0.8;
    _serviceButton.layer.shadowColor = [XTColor colorWithHexString:DARK_COLOR].CGColor;
    _serviceButton.layer.shadowOffset = CGSizeMake(0, 1);
    _serviceButton.layer.shadowRadius = 1;

}


@end
