//
//  XTHomeViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTHomeViewController.h"
#import "XTBannerCollectionReusableView.h"
#import "XTHomeCollectionViewCell.h"
#import "XTHomeHotCollectionViewCell.h"
#import "XTHomeCollectionReusableView.h"
@interface XTHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong ,nonatomic) UICollectionView *homeCollectionView;
@end

@implementation XTHomeViewController
#pragma mark - init (初始化)
//初始化collection view
-(void)initCollectionView{
    UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
    collectionflowlayout.minimumLineSpacing=10;
    collectionflowlayout.minimumInteritemSpacing=5;
   // collectionflowlayout.itemSize=CGSizeMake(SCREEN_WIDTH/2-15, 142);
    //collectionflowlayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    self.homeCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49) collectionViewLayout:collectionflowlayout];
    self.homeCollectionView.delegate=self;
    self.homeCollectionView.dataSource=self;
    self.homeCollectionView.backgroundColor=[XTColor colorWithHexString:WHITE_COLOR];
    [self.homeCollectionView registerClass:[XTBannerCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannerheader"];
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"XTHomeCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeheader"];
    [self.homeCollectionView registerNib:[UINib nibWithNibName:@"XTHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"gestCell"];
        [self.homeCollectionView registerNib:[UINib nibWithNibName:@"XTHomeHotCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"hotCell"];
    [self.homeCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView"];
    [self.view addSubview:_homeCollectionView];

}

#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor redColor];
    [self initCollectionView];
    // Do any additional setup after loading the view.
}

#pragma mark - collection datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    if (section==1) {
        return 3;
    }
    return 5;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        XTHomeCollectionViewCell *cell = (XTHomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"gestCell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.section==2) {
        XTHomeHotCollectionViewCell *cell = (XTHomeHotCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"hotCell" forIndexPath:indexPath];
        return cell;
    }
    return nil;
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

// The view that is returned must be retrieved from a call to -dequeueReusableSupplementaryViewOfKind:withReuseIdentifier:forIndexPath:
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section ==0) {
            XTBannerCollectionReusableView *header = (XTBannerCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"bannerheader" forIndexPath:indexPath ] ;
            return header;

        }
        else{
            XTHomeCollectionReusableView *header = (XTHomeCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"homeheader" forIndexPath:indexPath];
            if (indexPath.section==1) {
                [header.myImage setImage:[UIImage imageNamed:@"recommend"] forState:UIControlStateNormal];
                header.menuTitle.text = @"本周推荐";
                return header;
            }
            return header;
        }
        
        
    }
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
    footer.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
    return footer;
}

#pragma mark - collection delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.46+272);
    }
    return CGSizeMake(SCREEN_WIDTH, 40);
   }
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_WIDTH, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
         return CGSizeMake((SCREEN_WIDTH-40)*0.33, (SCREEN_WIDTH-40)*0.33);
    }
    if (indexPath.section==2) {
         return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.46+46);
    }
    return CGSizeMake(0, 0);
  
   
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==1) {
        return UIEdgeInsetsMake(0, 10, 15, 10);

    }
    if (section == 2) {
        return UIEdgeInsetsMake(10, 0, 10, 0);
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);

   }
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section==2) {
        return 15;
    }
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section==1) {
        return 8;
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
