//
//  XTMeViewController.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/10.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTMeViewController.h"
#import "XTMeTableViewCell.h"
@interface XTMeViewController ()<UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UILabel *mystatus;
@property (weak, nonatomic) IBOutlet UIButton *mySet;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *myMessage;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIButton *myOrder;
@property (weak, nonatomic) IBOutlet UILabel *orderLabel;
@property (weak, nonatomic) IBOutlet UIButton *myMood;
@property (weak, nonatomic) IBOutlet UILabel *moodLabel;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (strong,nonatomic) NSMutableArray *arrImage;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIView *oneLine;
@property (weak, nonatomic) IBOutlet UIView *twoLine;
@property (strong,nonatomic) NSMutableArray *arrList;
@end

@implementation XTMeViewController
#pragma mark - init
-(NSMutableArray*)arrImage{
    if (!_arrImage) {
        _arrImage = [NSMutableArray arrayWithObjects:@"my-address",@"change-password",@"service-introduction",@"About-Us", nil];
    }
    return _arrImage;
}
-(NSMutableArray*)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray arrayWithObjects:@"我的地址",@"修改密码",@"服务介绍",@"关于我们", nil];
    }
    return _arrList;
}
-(void)initUI{
    _headerImageView.layer.cornerRadius = 47;
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.borderWidth = 2;
    _headerImageView.layer.borderColor =[XTColor colorWithHexString:BACK_COLOR].CGColor;
    self.myView.alpha = 0.9;
    self.myView.layer.cornerRadius = 3;
    //self.myView.layer.masksToBounds = YES;
    self.myView.layer.shadowOpacity = 0.5;
    //        阴影的颜色
  _myView.layer.shadowColor = [XTColor colorWithHexString:PINK_COLOR].CGColor;
    //   阴影的位移
    _myView.layer.shadowOffset = CGSizeMake(0, 3);
    //       阴影的模糊程度
    self.myView.layer.shadowRadius = 4;
    _messageLabel.textColor = [XTColor colorWithHexString:@"303030"];
      _orderLabel.textColor = [XTColor colorWithHexString:@"303030"];
      _moodLabel.textColor = [XTColor colorWithHexString:@"303030"];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    _myTableView.layer.cornerRadius = 3;
    _myTableView.layer.masksToBounds = YES;
    //_myTableView.scrollEnabled = NO;
    [_myTableView registerNib:[UINib nibWithNibName:@"XTMeTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    _myTableView.separatorColor = [XTColor colorWithHexString:@"f1f0f0"];
    _myTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.oneLine.backgroundColor = [XTColor colorWithHexString:@"f5f5f5"];
     self.twoLine.backgroundColor = [XTColor colorWithHexString:@"f5f5f5"];
}
#pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [XTColor colorWithHexString:LIGHT_COLOR];
    self.navigationController.delegate =self;
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - uinavigation delegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    NSLog(@"2222");
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:NO];
}

#pragma mark - table view datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XTMeTableViewCell *cell = (XTMeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.menuTitle.text = self.arrList[indexPath.row];
    [cell.menuImageView setImage:[UIImage imageNamed:self.arrImage[indexPath.row]] forState:UIControlStateNormal];
         return cell;
}
#pragma mark - table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)myMenulistAction:(id)sender {
    NSLog(@"wwwww");
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
