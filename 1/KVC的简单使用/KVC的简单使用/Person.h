//
//  Person.h
//  KVC的简单使用
//
//  Created by 谷士雄 on 16/8/25.
//  Copyright © 2016年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject
@property (nonatomic, strong) Dog *dog;
@end
