//
//  DataBaseManager.h
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/4.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject

@property (nonatomic, copy) NSString *dataBasePath;

+ (instancetype)sharedInstance;

- (BOOL)openDataBase;

- (void)createTable;

- (void)insertStudent;

- (NSArray *)queryAllStudent;
@end

