//
//  XTPostMeViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTPostMeViewController.h"

@interface XTPostMeViewController ()

@end

@implementation XTPostMeViewController
-(void)initbackView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, 64) ];
    backView.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor purpleColor];
    button.frame = CGRectMake(0, 0, 64, 64);
    [button addTarget:self action:@selector(dismissControllerAction) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:button];
    [self.view addSubview:backView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [XTColor colorWithHexString:PINK_COLOR];
    [self initbackView];
    // Do any additional setup after loading the view.
}
-(void)dismissControllerAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
