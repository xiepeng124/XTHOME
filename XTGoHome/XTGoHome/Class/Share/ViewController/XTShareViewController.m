//
//  XTShareViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTShareViewController.h"

@interface XTShareViewController ()

@end

@implementation XTShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor = [UIColor greenColor];
    UIView *vies = [[UIView alloc]initWithFrame:CGRectMake(10, 100, SCREEN_WIDTH, 20)];
    [self.view addSubview:vies];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//重写导航栏右边按钮
-(void)initRightNavigationItem{
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    rightButton1.image=[UIImage imageNamed:@"Release-the-mood"];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width=-5;

    self.navigationItem.rightBarButtonItems =@[negativeSpacer, rightButton1];
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
