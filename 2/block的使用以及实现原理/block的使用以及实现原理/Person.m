//
//  Person.m
//  block的使用以及实现原理
//
//  Created by 谷士雄 on 16/8/25.
//  Copyright © 2016年 alan. All rights reserved.
//

#import "Person.h"

@implementation Person
- (id)init
{
    if (self = [super init]) {
        //        __block Dog * dog = self;
        __block typeof(self) dog = self;
        self.block = ^{
            //            [dog run];
            NSLog(@"%d", dog->_age);
        };
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"Dog --- dealloc");
    
//    Block_release(_block);
    
    [super dealloc];
}

- (void)run
{
    NSLog(@"run");
}

@end
