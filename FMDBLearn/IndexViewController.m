//
//  IndexViewController.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/5.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "IndexViewController.h"
#import "ReactiveCocoa.h"

@interface IndexViewController ()
@property (weak, nonatomic) IBOutlet UIButton *teacherButton;
@property (weak, nonatomic) IBOutlet UIButton *studentButton;
@property (weak, nonatomic) IBOutlet UIButton *classButton;


@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[_teacherButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self performSegueWithIdentifier:@"gotoStudentListVC" sender:nil];
    }];
    
    [[_studentButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self performSegueWithIdentifier:@"gotoStudentListVC" sender:nil];
    }];
    
    [[_classButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self performSegueWithIdentifier:@"gotoStudentListVC" sender:nil];
    }];
    
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
