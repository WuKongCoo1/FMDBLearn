//
//  DataBaseManager.m
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/4.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDataBase.h"
#import "FMDatabaseAdditions.h"


static DataBaseManager *manager = nil;
static FMDatabase *dataBase = nil;
@implementation DataBaseManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseManager alloc] init];
    });
    
    return manager;
}

- (BOOL)openDataBase
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataBase = [FMDatabase databaseWithPath:self.dataBasePath];
    });
    
    BOOL success = [dataBase open];
    
    NSLog(@"数据库连接 结果 ： %@", success ? @"success" : @"failure");
    
    NSLog(@"path :%@", self.dataBasePath);
    
    return success;
}

- (NSString *)dataBasePath
{
    if (_dataBasePath == nil) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _dataBasePath = [documentPath stringByAppendingPathComponent:@"dataBase/contact.db"];
    }

    if (![[NSFileManager defaultManager] fileExistsAtPath:[_dataBasePath stringByDeletingLastPathComponent] isDirectory:nil]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:[_dataBasePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    
    
    return _dataBasePath;
}

- (void)createTable
{
    if ([dataBase tableExists:@"t_student"]) {
//        [dataBase executeStatements:@"DROP TABLE IF EXISTS t_student;"
//         "CREATE TABLE t_student (name text, primaryKey integer NOT NULL PRIMARY KEY AUTOINCREMENT);" ];
    }else{
//        [dataBase executeStatements:@"CREATE TABLE t_student (name text, primaryKey integer NOT NULL PRIMARY KEY AUTOINCREMENT);" ];
    }
    
    
}

- (void)insertStudent
{
//    insert into t_Student (name) values ('aasdas')
    [dataBase executeUpdate:@"insert into t_student (name) values ('aasdas')"];
    [dataBase executeUpdate:@"insert into t_student (name) values (?)", @"哈哈哈"];
    
    
    
    if(![dataBase columnExists:@"age" inTableWithName:@"t_student"]){
        [dataBase beginTransaction];
        [dataBase executeStatements:@"ALTER table t_student add age text"];
        [dataBase commit];
    }
}

- (NSArray *)queryAllStudent
{
    FMResultSet *resultSet = [dataBase executeQuery:@"select * from t_student"];
    
    while ([resultSet next]) {
//        NSString *name = [resultSet stringForColumn:@"name"];
        
        NSLog(@"%@", [resultSet resultDictionary]);
    }
    
    return nil;
}

@end
