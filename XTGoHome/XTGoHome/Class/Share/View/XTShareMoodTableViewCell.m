//
//  XTShareMoodTableViewCell.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/15.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTShareMoodTableViewCell.h"
@interface XTShareMoodTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation XTShareMoodTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.shareImageView.layer.cornerRadius = 3;
    self.shareImageView.layer.masksToBounds = YES;
    UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
    collectionflowlayout.minimumLineSpacing=5;
    _shareCollectionView.collectionViewLayout = collectionflowlayout;
    [self.shareCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ImageCell"];
    [self.shareCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"imageHeader"];
    [self.shareCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"imagefooter"];
    self.shareCollectionView.delegate = self;
    self.shareCollectionView.dataSource = self;
        // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
