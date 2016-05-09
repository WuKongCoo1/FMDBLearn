//
//  AddClassViewController.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/6.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "AddClassViewController.h"
#import "ReactiveCocoa.h"
#import "DataBaseManager.h"

@interface AddClassViewController ()
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UITextField *classNameTextField;

@end

@implementation AddClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[_addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (_classNameTextField.text.length != 0) {
            if ([[DataBaseManager sharedInstance] insertClassWithClassName:_classNameTextField.text]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:alert animated:YES completion:^{
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [alert dismissViewControllerAnimated:YES completion:nil];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }];
            }
        }
       
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
