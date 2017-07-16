//
//  XTShareOneViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/15.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTShareOneViewController.h"
#import "XTShareMoodTableViewCell.h"
@interface XTShareOneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation XTShareOneViewController
#pragma mark - init
- (void)initUI {
    self.view.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
    [self initTable];
}

- (void)initTable {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-20, SCREEN_HEIGHT-158) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"XTShareMoodTableViewCell" bundle:nil] forCellReuseIdentifier:@"oneCell"];
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view.
}
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTShareMoodTableViewCell* cell = (XTShareMoodTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
    //        cell.textLabel.text = [NSString stringWithFormat:@"\t第%zd行",indexPath.row];
    //    cell.detailTextLabel.text = @"点击跳转新界面";
    //    cell.detailTextLabel.textColor = self.navigationController.navigationBar.tintColor;
    cell.layer.cornerRadius = 3;
    cell.layer.masksToBounds = YES;
    return cell;
}
#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 400;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
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
