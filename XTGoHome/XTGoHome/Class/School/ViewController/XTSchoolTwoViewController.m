//
//  XTSchoolTwoViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/10.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTSchoolTwoViewController.h"

@interface XTSchoolTwoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation XTSchoolTwoViewController

#pragma mark - init
- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self initTable];
}

- (void)initTable {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
    _tableView.showsVerticalScrollIndicator = NO;
   // [_tableView registerNib:[UINib nibWithNibName:@"XTSchoolTableViewCell" bundle:nil] forCellReuseIdentifier:@"oneCell"];
    [self.view addSubview:_tableView];
}

#pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _tableView.frame = self.view.bounds;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"\t第%zd行",indexPath.row];
    cell.detailTextLabel.text = @"点击跳转新界面";
    cell.detailTextLabel.textColor = self.navigationController.navigationBar.tintColor;
    return cell;

//    XTSchoolTableViewCell* cell = (XTSchoolTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
//    //        cell.textLabel.text = [NSString stringWithFormat:@"\t第%zd行",indexPath.row];
//    //    cell.detailTextLabel.text = @"点击跳转新界面";
//    //    cell.detailTextLabel.textColor = self.navigationController.navigationBar.tintColor;
//    return cell;
}
#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
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
