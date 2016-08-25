//
//  Person.h
//  block的使用以及实现原理
//
//  Created by 谷士雄 on 16/8/25.
//  Copyright © 2016年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, assign) int age;

@property (nonatomic, copy) void (^block)();

- (void)run;

@end
