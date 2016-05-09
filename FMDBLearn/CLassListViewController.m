//
//  CLassListViewController.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/5.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "CLassListViewController.h"
#import "DataBaseManager.h"
#import "ReactiveCocoa.h"

@interface CLassListViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CLassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupData];
    
    [self setupUI];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"classDidChange" object:nil] subscribeNext:^(id x) {
        [self setupData];
    }];;
}


- (void)setupData
{
    self.dataSource = [[[DataBaseManager sharedInstance] queryClasses] mutableCopy];
    
    [self.tableView reloadData];
}

- (void)setupUI
{
    self.navigationItem.title = @"班级列表";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self performSegueWithIdentifier:@"gotoAddClassVC" sender:nil];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItem = item;
    
    //    [self.tableView setEditing:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    NSDictionary *dic = self.dataSource[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"班级名：%@", dic[@"name"]];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}





@end
