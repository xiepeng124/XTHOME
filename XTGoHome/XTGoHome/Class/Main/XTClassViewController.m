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
  
    _leftbutton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:13];
    [_leftbutton setTitleColor:[XTColor colorWithHexString:DARK_GARY_COLOR] forState:UIControlStateNormal];
    _leftbutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
  
   [_leftbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    [_leftbutton setTitle:@"番禺区" forState:UIControlStateNormal];
 
    UIBarButtonItem *leftitem=[[UIBarButtonItem alloc]initWithCustomView:_leftbutton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width=-10;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftitem];

}
//导航栏右边按钮
-(void)initRightNavigationItem{
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(recevieMessageAction)];
    rightButton1.image=[UIImage imageNamed:@"message"];
    
    UIBarButtonItem * rightButton2= [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(callMobilephoneAction)];
    rightButton2.image=[UIImage imageNamed:@"phone"];
    
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
   negativeSpacer.width=-10;
//    UIBarButtonItem *negativeSpacer2 = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:  UIBarButtonSystemItemFlexibleSpace
//   target:nil action:nil];
//    negativeSpacer2.width=20;

     self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightButton2, rightButton1];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLeftNavigationItem];
    [self initRightNavigationItem];
    // Do any additional setup after loading the view.
}
//点击信息按钮事件
-(void)recevieMessageAction{
    
}
//点击电话按钮事件
-(void)callMobilephoneAction{
    
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
