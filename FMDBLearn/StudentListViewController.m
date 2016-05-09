//
//  StudentListViewController.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/4.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "StudentListViewController.h"
#import "DataBaseManager.h"
#import "StudentDetailViewController.h"

@interface StudentListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation StudentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataBaseManager sharedInstance] openDataBase];
    
    [[DataBaseManager sharedInstance] createTable];
    
    [[DataBaseManager sharedInstance] queryAllStudent];
    
    [self setupData];
    
    NSLog(@"%@", self.navigationController.interactivePopGestureRecognizer);
    
    [self setupUI];
    
}


- (void)setupData
{
    self.dataSource = [[[DataBaseManager sharedInstance] queryAllStudent] mutableCopy];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(studentDidChange) name:@"studentDidChange" object:nil];
}

- (void)setupUI
{
    self.navigationItem.title = @"学生列表";
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(gotoAddStudentVC) forControlEvents:UIControlEventTouchUpInside];
    
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
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString  stringWithFormat:@"姓名：%@", dic[@"name"]];
    cell.detailTextLabel.text = [NSString  stringWithFormat:@"id：%@", dic[@"primaryKey"]];;
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _dataSource[indexPath.row];
    [self performSegueWithIdentifier:@"gotoDetailVC" sender:dic[@"primaryKey"]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dic = self.dataSource[indexPath.row];
        
        [[DataBaseManager sharedInstance] deleteStudentWithID:dic[@"primaryKey"]];
    }
}

#pragma mark - action
- (void)gotoAddStudentVC
{
    [self performSegueWithIdentifier:@"gotoAddVC" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    id destVC = segue.destinationViewController;
    
    if ([destVC isKindOfClass:[StudentDetailViewController class]]) {
        
       [destVC setValue:sender forKey:@"studentID"];
        
    }else{
        
    }
}

- (void)studentDidChange
{
    self.dataSource = [[[DataBaseManager sharedInstance] queryAllStudent] mutableCopy];
    
    [self.tableView reloadData];
}
@end
