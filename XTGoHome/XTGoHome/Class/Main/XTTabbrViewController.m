//
//  XTTabbrViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTTabbrViewController.h"
#import "XTHomeViewController.h"
#import "XTSchoolViewController.h"
#import "XTPostViewController.h"
#import "XTShareViewController.h"
#import "XTMineViewController.h"
#import "XTBaseNavViewController.h"
#import "XTPostMeViewController.h"
@interface XTTabbrViewController ()<UITabBarControllerDelegate>
@property (strong ,nonatomic) UIButton *postButton;
@end

@implementation XTTabbrViewController
//添加子控制器
-(void)initChlidController{
    [self setTabBarChildController:[[XTHomeViewController alloc]init] title:@"首页" image:@"home_off"selectImage:@"home_on"];
      [self setTabBarChildController:[[XTSchoolViewController alloc]init] title:@"学堂" image:@"class_off"selectImage:@"class_on"];
      [self setTabBarChildController:[[XTPostViewController alloc]init] title:@"" image:@""selectImage:@""];
      [self setTabBarChildController:[[XTShareViewController alloc]init] title:@"分享" image:@"share_off"selectImage:@"share_on"];
      [self setTabBarChildController:[[XTMineViewController alloc]init] title:@"我的" image:@"my_off"selectImage:@"my_on"];

    
}
//设置发帖按钮
-(void)initPostButton{
    _postButton = [UIButton buttonWithType:UIButtonTypeCustom];
   // _postButton.backgroundColor = [UIColor purpleColor];
    [_postButton  setImage:[UIImage imageNamed:@"baseboard"] forState:UIControlStateNormal];
    CGFloat  width = SCREEN_WIDTH/5;
    _postButton.frame = CGRectMake(2*width, SCREEN_HEIGHT-63, width, 63);
    [_postButton addTarget:self action:@selector(goPostViewControAction) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:_postButton];
   // [_postButton bringSubviewToFront:_postButton];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initChlidController];
    self.tabBar.tintColor=[ XTColor colorWithHexString:PINK_COLOR];
  
    //tabbar不透明
    self.tabBar.translucent = NO;
    [self initPostButton];
    // Do any additional setup after loading the view.
}
//设置子控制器
- (void)setTabBarChildController:(UIViewController*)controller title:(NSString*)title image:(NSString*)imageStr selectImage:(NSString*)selectImageStr{
    
    XTBaseNavViewController* nav = [[XTBaseNavViewController alloc] initWithRootViewController:controller];
    nav.tabBarItem.title = title;
    nav.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:imageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageStr]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGBA(74, 74, 74, 1.0)} forState:UIControlStateNormal];
//    [nav.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:RGBA(255, 200, 0, 1.0)} forState:UIControlStateSelected];
    
    [self addChildViewController:nav];
}
-(void)goPostViewControAction{
    NSLog(@"1111");
    XTPostMeViewController *post = [[XTPostMeViewController alloc]init];
    
    [self presentViewController:post animated:YES completion:nil];
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
