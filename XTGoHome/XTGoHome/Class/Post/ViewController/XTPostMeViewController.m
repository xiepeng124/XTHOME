//
//  XTPostMeViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/7.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTPostMeViewController.h"
#import "XTPostMoodView.h"
#import "ACMediaFrame.h"
#import "XTBaseNavViewController.h"
@interface XTPostMeViewController ()
@property (nonatomic,strong)UITableView *moodTableView;
@property (nonatomic,strong)XTPostMoodView *moodView;
@property (strong,nonatomic) ACSelectMediaView *mediaView;
@end

@implementation XTPostMeViewController
-(void)initbackView{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64) ];
    backView.backgroundColor = [XTColor colorWithHexString:WHITE_COLOR];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor purpleColor];
    button.frame = CGRectMake(10, 20, 64, 44);
    [button setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    //图片水平靠左
    button.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self action:@selector(dismissControllerAction) forControlEvents:UIControlEventTouchUpInside];
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.textColor = [XTColor colorWithHexString:DARK_TWO_COLOR];
    titleLabel.text = @"发布新心情";
    titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    titleLabel.textAlignment =NSTextAlignmentCenter;
    [backView addSubview:titleLabel];
    [backView addSubview:button];
    [self.view addSubview:backView];
   [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(backView);
       make.top.mas_equalTo(20);
       make.size.mas_equalTo(CGSizeMake(100, 44));
   }];
}
-(void)initTableView{
    _moodTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _moodTableView.backgroundColor =[XTColor colorWithHexString:LIGHT_COLOR];
    _moodView = [[XTPostMoodView alloc]initWithFrame:self.moodTableView.frame];
    _moodView.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
      _mediaView = [[ACSelectMediaView alloc]initWithFrame:CGRectMake(0, 160, SCREEN_WIDTH, 90)];
    _mediaView.viewController = self;
  _mediaView.type = ACMediaTypeAll;
    _mediaView.allowMultipleSelection = NO;
    [_moodView addSubview:_mediaView];
    self.moodTableView.tableHeaderView =_moodView;
    [self.view addSubview:_moodTableView];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [XTColor colorWithHexString:PINK_COLOR];
    [self initbackView];
    [self initTableView];
     // [self.view addSubview:navi.navigationBar];

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
