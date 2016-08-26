//
//  ViewController.m
//  block的使用以及实现原理
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
    
    //block的定义（NSString *类型是参数）
    //返回值类型和return返回的类型要严格匹配，否则编译直接报错
    //类似于这种“Incompatible block pointer types initializing 'float (^__strong)(float, float)' with an expression of type 'int (^)(float, float)'”
//    CGFloat (^myBlock)(NSString *) = ^(NSString *name) {
//        return 2.0;
//    };
//    
//    NSLog(@"%lf",myBlock(@"q"));
}


//int a = 5;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSUInteger a = 5;
//    void (^block)() = ^{
//        a = 6;
//    };
    
    
//    NSUInteger a = 5;
//    void (^block)() = ^{
//        NSLog(@"%ld",a);
//    };
//    a = 6;
//    block();
    
    
//    __block NSUInteger a = 5;
//    void (^block)() = ^{
//        NSLog(@"%ld",a);
//    };
//    a = 6;
//    block();
    
    
//    static int a = 10;
//    void (^block)() = ^{
//        NSLog(@"a is %d", a);
//    };
//
//    a = 20;
//    block(); // 20

    
//    __block Person *p = [[Person alloc] init]; // 1
//    p.age = 20;
//
//    void (^block)() = ^{
//        NSLog(@"------block------%d", p.age);
//    };
//    NSLog(@"%zd", [p retainCount]);
//    Block_copy(block); // 2
//    NSLog(@"%zd", [p retainCount]);
//
//    [p release]; // 1


    
//    int a = 5;
//    changeMyNo0(a);
//    NSLog(@"0:%d",a);
//    changeMyNo1(&a);
//    NSLog(@"1:%d",a);
}

void changeMyNo0(int a) {
    a = 6;
}
void changeMyNo1(int *a) {
    *a = 7;
}
@end
