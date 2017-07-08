//
//  XTClassViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTClassViewController.h"

@interface XTClassViewController ()
@property (strong,nonatomic) UIButton *leftbutton;
@end

@implementation XTClassViewController
//导航栏左边按钮
-(void)initLeftNavigationItem{
    _leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
    [_leftbutton setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
   // [_leftbutton setImage:[UIImage imageNamed:@"teacher_select_on"] forState:UIControlStateSelected];
    //[leftbutton setBackgroundColor:[UIColor blackColor]];
    _leftbutton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:13];
    [_leftbutton setTitleColor:[XTColor colorWithHexString:DARK_GARY_COLOR] forState:UIControlStateNormal];
    _leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //    [leftbutton setImageEdgeInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
   [_leftbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
   // UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
    [_leftbutton setTitle:@"番禺区" forState:UIControlStateNormal];
   // [_leftbutton setTitle:@"取消全选" forState:UIControlStateSelected];
  //  [_leftbutton addTarget:self action:@selector(allRoleSelectedAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc]initWithCustomView:_leftbutton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width=-10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftitem];

}
//导航栏右边按钮
-(void)initRightNavigationItem{
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    rightButton1.image=[UIImage imageNamed:@"message"];
    UIBarButtonItem * rightButton2= [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(receiveMessageAction:)];
    rightButton2.image=[UIImage imageNamed:@"phone"];
    
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width=-10;
     self.navigationItem.rightBarButtonItems=@[rightButton2, rightButton1];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLeftNavigationItem];
    [self initRightNavigationItem];
    // Do any additional setup after loading the view.
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
