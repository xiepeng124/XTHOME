//
//  XTShareMoodTableViewCell.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/15.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTShareMoodTableViewCell.h"
@interface XTShareMoodTableViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong,nonatomic) NSMutableArray *arrImage;

@end
@implementation XTShareMoodTableViewCell
-(NSMutableArray*)arrImage{
    if(!_arrImage) {
        NSArray *arr1 = @[@"smallboy",@"smallboy",@"smallboy",@"smallboy",@"smallboy",@"smallboy",@"smallboy",@"smallboy"];
//        NSArray *arr2 = @[@"smallboy",@"smallboy",@"smallboy",@"smallboy",@"smallboy",@"smallboy"];
//        NSArray *arr3 = @[@"smallboy",@"smallboy",@"smallboy"];
        _arrImage = [arr1 mutableCopy];
        //_arrImage = [NSMutableArray arrayWithObjects:arr1, nil];

    }
    return _arrImage;
}
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
       return  [self.arrImage count];
    }
    return 3;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:cell.contentView.frame];
        imageview.image =[UIImage imageNamed:self.arrImage[indexPath.row]] ;
        [cell.contentView addSubview:imageview];
        return cell;
    }
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"imageHeader" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            YYLabel *label = [YYLabel new];
            label.font = [UIFont fontWithName:FONT_REGULAR size:14];
            label.textColor = [XTColor colorWithHexString:DARK_TWO_COLOR];
            //label.frame = header.frame;
            //label.text = @"呃黄飞鸿 i 红酒公婆简介赴日机构日 iif 将诶火锅害怕很多快速理赔阿姨服务 i";
            NSString *mytext = @"呃黄飞鸿 i 红酒公婆简介赴日机构日 iif 将诶火锅害怕很多快速理赔阿姨服务 i38439495904hh家；fkf77775";
            NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:mytext];
            //[text yy_setFont:<#(nullable UIFont *)#> range:<#(NSRange)#>]
            //text.yy_lineSpacing = 5;
            CGSize size = CGSizeMake(SCREEN_WIDTH-106, CGFLOAT_MAX);
            YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:size text:text];
            [layout closestLineIndexForPoint:CGPointMake(10,10)];
            [layout closestPositionToPoint:CGPointMake(10,10)];
//            [layout lineIndexForPoint:CGPointMake(10,10)];
            [layout textRangeAtPoint:CGPointMake(10,10)];
            //label.size = layout.textBoundingSize;
            label.textLayout = layout;
            label.frame =CGRectMake(0, 0, SCREEN_WIDTH-106, layout.textBoundingSize.height);
           
            //label.attributedText = text;
            [header addSubview:label];
            return header;
        }
        return header;
    }
    UICollectionViewCell *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"imagefooter" forIndexPath:indexPath];
    return footer;
}




- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
       return  CGSizeMake((SCREEN_WIDTH - 116)*0.33, (SCREEN_WIDTH - 116)*0.33);
    }
    return CGSizeMake(SCREEN_WIDTH - 106, 40);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 10, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(SCREEN_WIDTH - 106,60);
    }
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return  CGSizeMake(SCREEN_WIDTH - 106,40);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
