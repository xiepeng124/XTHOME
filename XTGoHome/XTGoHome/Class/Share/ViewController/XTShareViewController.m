//
//  XTShareViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTShareViewController.h"
#import "XTShareOneViewController.h"
#import "XTShareTwoViewController.h"
#import "XTShareThreeViewController.h"
#import "XLSlideSwitch.h"
#import "CollectionViewController.h"
@interface XTShareViewController ()<XLSlideSwitchDelegate>
@property (strong,nonatomic) XLSlideSwitch *slideSwitch;
@end

@implementation XTShareViewController
#pragma mark - init UI
- (void)buildUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    //要显示的标题
    NSArray *titles = @[@"甜心心情",@"最新发布",@"最新回复"];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
    [self buildUI];
   
    // Do any additional setup after loading the view.
}
#pragma mark SlideSwitchDelegate

- (void)slideSwitchDidselectAtIndex:(NSInteger)index {
    NSLog(@"切换到了第 -- %zd -- 个视图",index);
}

#pragma mark 自定义方法
- (UIViewController *)viewControllerOfIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            vc = [[XTShareOneViewController alloc] init];
            break;
        case 1:
            vc = [[XTShareTwoViewController alloc] init];
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
//重写导航栏右边按钮
-(void)initRightNavigationItem{
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction)];
    rightButton1.image=[UIImage imageNamed:@"Release-the-mood"];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width=-10;

    self.navigationItem.rightBarButtonItems =@[negativeSpacer, rightButton1];
}
-(void)selectRightAction{
    
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
