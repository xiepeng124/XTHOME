//
//  XTBaseNavViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTBaseNavViewController.h"

@interface XTBaseNavViewController ()

@end

@implementation XTBaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:17],
    NSForegroundColorAttributeName:[XTColor colorWithHexString:DARK_TWO_COLOR]}];
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
