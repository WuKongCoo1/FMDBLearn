//
//  StudentDetailViewController.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/5.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "StudentDetailViewController.h"
#import "DataBaseManager.h"

@interface StudentDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@end

@implementation StudentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block NSDictionary *dic;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        dic = [[DataBaseManager sharedInstance] searchStudentWithID:self.studentID];
        self.nameLabel.text = dic[@"name"];
        self.idLabel.text = [dic[@"primaryKey"] stringValue];
    });
    
    
    
    
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
