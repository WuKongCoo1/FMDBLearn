//
//  ViewController.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/4.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[DataBaseManager sharedInstance] openDataBase];
    
    [[DataBaseManager sharedInstance] createTable];
    
//    [[DataBaseManager sharedInstance] insertStudent];
    [[DataBaseManager sharedInstance] queryAllStudent];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
