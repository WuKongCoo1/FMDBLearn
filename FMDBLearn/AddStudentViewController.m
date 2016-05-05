//
//  AddStudentViewController.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/5.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "AddStudentViewController.h"
#import "DataBaseManager.h"

@interface AddStudentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
- (IBAction)addStudent:(id)sender;

@end

@implementation AddStudentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)addStudent:(id)sender {
    if (_nameTextField.text.length == 0) {
       UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入学生名称" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        return;
    }
    
    if ([[DataBaseManager sharedInstance] insertStudentWithStudentName:_nameTextField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加成功" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"添加失败" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alert animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        
    }
}
@end
