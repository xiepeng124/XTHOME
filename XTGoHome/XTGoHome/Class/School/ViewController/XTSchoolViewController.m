//
//  XTSchoolViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTSchoolViewController.h"
#import "XLSlideSwitch.h"
#import "XTOneViewController.h"
#import "XTSchoolTwoViewController.h"
#import "XTSchoolThreeViewController.h"
#import "CollectionViewController.h"
@interface XTSchoolViewController ()<XLSlideSwitchDelegate >
@property (strong,nonatomic) XLSlideSwitch *slideSwitch;
@end

@implementation XTSchoolViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildUI];
    self.navigationItem.title = @"小糖学堂";
}

- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //要显示的标题
    NSArray *titles = @[@"好孕指南",@"亲子学堂",@"全部视频"];
    //创建需要展示的ViewController
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (NSInteger i = 0 ; i<titles.count; i++) {
        UIViewController *vc = [self viewControllerOfIndex:i];
        [viewControllers addObject:vc];
    }
    //创建滚动视图
    _slideSwitch = [[XLSlideSwitch alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64) Titles:titles viewControllers:viewControllers];
    //设置代理
    _slideSwitch.delegate = self;
    //设置按钮选中和未选中状态的标题颜色
    _slideSwitch.itemSelectedColor = [XTColor colorWithHexString:PINK_COLOR];
    _slideSwitch.itemNormalColor = [XTColor colorWithHexString:DARK_GARY_COLOR];
    //显示方法
    [_slideSwitch showInViewController:self];
}

#pragma mark -
#pragma mark SlideSwitchDelegate

- (void)slideSwitchDidselectAtIndex:(NSInteger)index {
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}

#pragma mark -
#pragma mark 自定义方法
- (UIViewController *)viewControllerOfIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = [[XTOneViewController alloc] init];
            break;
        case 1:
            vc = [[XTSchoolTwoViewController alloc] init];
            break;

        case 2:
            vc = [[CollectionViewController alloc] init];
            break;
        default:
            break;
    }
    return vc;
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
