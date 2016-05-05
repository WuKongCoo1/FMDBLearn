//
//  Student.h
//  FMDBLearn
//
//  Created by 吴珂 on 16/5/5.
//  Copyright © 2016年 吴珂. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, copy) NSString *name;
//@property (nonatomic, assign) NSInteger *age;
@property (nonatomic, strong) NSNumber *primaryKey;

@end
