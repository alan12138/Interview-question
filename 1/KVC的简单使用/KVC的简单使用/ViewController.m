//
//  ViewController.m
//  KVC的简单使用
//
//  Created by 谷士雄 on 16/8/25.
//  Copyright © 2016年 alan. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Person *p = [[Person alloc] init];
    [p setValue:@"畅敏" forKey:@"name"];
    NSLog(@"%@",[p valueForKey:@"name"]);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Dog *d = [[Dog alloc] init];
    Person *p = [[Person alloc] init];
    p.dog = d;
    [p.dog setValue:@"旺财" forKeyPath:@"dogName"];
    NSLog(@"%@",[p.dog valueForKeyPath:@"dogName"]);
    //两种方式
    [p setValue:@"旺财" forKeyPath:@"dog.dogName"];
    NSLog(@"%@",[p valueForKeyPath:@"dog.dogName"]);
}

- (IBAction)btnClick:(id)sender {
    NSDictionary *dict = @{
                           @"name" : @"fangfang",
                           @"gender" : @"girl",
                           @"age" : @18,
                           @"hobby" : @"fangfang"
                           };
    Person *p = [[Person alloc] init];
    
    // 同时给多个属性赋值
    [p setValuesForKeysWithDictionary:dict];
    
    NSLog(@"name = %@, gender = %@, age = %@, hobby = %@", [p valueForKey:@"name"], [p valueForKey:@"gender"], [p valueForKey:@"age"],[p valueForKey:@"hobby"]);
    
}


@end
