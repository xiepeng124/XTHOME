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
#import "XTMeViewController.h"
#import "XTButton.h"
@interface XTTabbrViewController ()<UITabBarControllerDelegate>
@property (strong ,nonatomic) XTButton *postButton;
@property (nonatomic,assign) NSInteger  indexFlag;
@end

@implementation XTTabbrViewController
//添加子控制器
-(void)initChlidController{
    [self setTabBarChildController:[[XTHomeViewController alloc]init] title:@"首页" image:@"home_off"selectImage:@"home_on"];
      [self setTabBarChildController:[[XTSchoolViewController alloc]init] title:@"学堂" image:@"class_off"selectImage:@"class_on"];
      [self setTabBarChildController:[[XTPostViewController alloc]init] title:@"" image:@""selectImage:@""];
      [self setTabBarChildController:[[XTShareViewController alloc]init] title:@"分享" image:@"share_off"selectImage:@"share_on"];
      [self setTabBarChildController:[[XTMeViewController alloc]init] title:@"我的" image:@"my_off"selectImage:@"my_on"];

    
}
//设置发帖按钮
-(void)initPostButton{
        CGFloat  width = SCREEN_WIDTH/5;
    _postButton = [[XTButton alloc]initWithFrame:CGRectMake(2*width, SCREEN_HEIGHT-63, width, 63) maxLeft:100 maxRight:100 maxHeight:300];
   // _postButton = [XTButton buttonWithType:UIButtonTypeCustom];
    _postButton.images = @[[UIImage imageNamed:@"heart"],[UIImage imageNamed:@"home_on"],[UIImage imageNamed:@"class_on"],[UIImage imageNamed:@"share_on"]];
    _postButton.duration = 6;
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(createAnimation:)];
    longGes.minimumPressDuration = 2;
    [_postButton addGestureRecognizer:longGes];
   // _postButton.backgroundColor = [UIColor purpleColor];
    [_postButton  setImage:[UIImage imageNamed:@"post_on"] forState:UIControlStateNormal];
    _postButton.adjustsImageWhenHighlighted = NO;
    // [_postButton  setImage:[UIImage imageNamed:@"my_on"] forState:UIControlStateSelected];
    _postButton.contentVerticalAlignment =  UIControlContentVerticalAlignmentTop;

    //_postButton.frame = CGRectMake(2*width, SCREEN_HEIGHT-63, width, 63);
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
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.3];     //结束伸缩倍数
    [[_postButton layer] addAnimation:animation forKey:nil];
    NSMutableArray *items = [NSMutableArray array];
    
    MenuItem *menuItem = [[MenuItem alloc] initWithTitle:@"发送心情" iconName:@"" glowColor:[XTColor colorWithHexString:PINK_COLOR]index:0];
    [items addObject:menuItem];
    
    menuItem = [[MenuItem alloc] initWithTitle:@"发送文章" iconName:@"" glowColor:[XTColor colorWithHexString:PINK_COLOR] index:1];
    [items addObject:menuItem];
    
    
    
    PopMenu *popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
    popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase; // kPopMenuAnimationTypeSina
    popMenu.perRowItemCount = 2; // or 2
   
    [popMenu showMenuAtView:self.view];
    popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        switch (selectedItem.index) {
            case 0:
            {
                XTPostMeViewController *post = [[XTPostMeViewController alloc]init];
                //post.modalPresentationStyle =UIModalPresentationPopover;
                [self presentViewController:post animated:YES completion:nil];
            }
                break;
            case 1:
            {
//                XTPostMeViewController *post = [[XTPostMeViewController alloc]init];
//                
//                [self presentViewController:post animated:YES completion:nil];
            }
                break;
   
            default:
                break;
        }
    };
  
}
//post按钮长按手势
-(void)createAnimation:(UILongPressGestureRecognizer*)gest{
    NSTimer *timer;

 
    if (gest.state == UIGestureRecognizerStateEnded) {
        NSLog(@"333");
        [_postButton.layer removeAllAnimations];
        [timer invalidate];
        timer = nil;
        
    }

    else if (gest.state == UIGestureRecognizerStateBegan) {
//        CABasicAnimation* rotationAnimation;
//        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
//        rotationAnimation.duration = 2;
//        rotationAnimation.cumulative = YES;
//        rotationAnimation.repeatCount = 10;
//        
//        [_postButton.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(updateTimer)
                                               userInfo:nil
                                                repeats:YES];

        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];


   
    }
    
}
-(void)updateTimer{
     [_postButton generateBubbleInRandom];
}

//tabbar delegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"@@");
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (index != self.indexFlag) {
        //执行动画
        NSMutableArray *arry = [NSMutableArray array];
        for (UIView *btn in self.tabBar.subviews) {
            if ([btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
                [arry addObject:btn];
            }
        }
        [self startanimation:arry withIndex:index];
        self.indexFlag = index;
    }
}
//
-(void)startanimation:(NSMutableArray*)arry withIndex:(NSInteger)index{
    //放大效果，并回到原位
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    //速度控制函数，控制动画运行的节奏
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.2;       //执行时间
    animation.repeatCount = 1;      //执行次数
    animation.autoreverses = YES;    //完成动画后会回到执行动画之前的状态
    animation.fromValue = [NSNumber numberWithFloat:0.7];   //初始伸缩倍数
    animation.toValue = [NSNumber numberWithFloat:1.2];     //结束伸缩倍数
    [[arry[index] layer] addAnimation:animation forKey:nil];
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
