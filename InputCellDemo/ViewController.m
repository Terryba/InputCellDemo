//
//  ViewController.m
//  InputCellDemo
//
//  Created by li on 15/8/10.
//  Copyright (c) 2015年 医视时代. All rights reserved.
//

#import "ViewController.h"
#import "InputCell.h"
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *inputTableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSMutableDictionary *infoDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.inputTableView.delegate = self;
    self.inputTableView.dataSource = self;
    self.titleArray = @[@"用户名",@"密码",@"确认密码",@"电子邮箱"];
    self.infoDic = [NSMutableDictionary dictionary];
    self.inputTableView.tableFooterView = [self getRegisterBtn];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.inputTableView addGestureRecognizer:tap];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark - init views

- (UIView *)getRegisterBtn {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    UIButton *registBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registBtn.frame = CGRectMake(5, 20, view.frame.size.width - 10, 44);
    [registBtn setTitle:@"立即注册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
    registBtn.backgroundColor = [UIColor colorWithRed:66/255.f green:164/255.f blue:237/255.f alpha:1];
    [registBtn addTarget:self action:@selector(tapRegist:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:registBtn];
    return view;
}
#pragma mark - btn action

- (void)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (void)tapRegist:(UIButton *)sender {
    [self.view endEditing:YES];
    NSLog(@"点击注册");
}

#pragma mark - tableView delegate & datasource

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak ViewController *blockSelf = self;
    static NSString *cellID = @"InputCell";
    
    InputCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"InputCell" owner:self options:nil] lastObject];
    }
    [cell setTitle:self.titleArray[indexPath.row] placeholder:nil andInputInfo:self.infoDic[_titleArray[indexPath.row]]];
    if (indexPath.row == 1 || indexPath.row == 2) {
        cell.textField.secureTextEntry = YES;
        cell.textField.keyboardType = UIKeyboardTypeASCIICapable;
    }else{
        cell.textField.secureTextEntry = NO;
        cell.textField.keyboardType = UIKeyboardTypeDefault;
    }
    cell.indexPath = indexPath;
    cell.block = ^(NSString *str, NSIndexPath *idx){
        if (str) {
            [blockSelf.infoDic setObject:str forKey:blockSelf.titleArray[idx.row]];
        }
    };
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
