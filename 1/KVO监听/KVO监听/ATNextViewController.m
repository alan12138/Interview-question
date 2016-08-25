//
//  ATNextViewController.m
//  KVO监听
//
//  Created by 谷士雄 on 16/8/24.
//  Copyright © 2016年 alan. All rights reserved.
//

#define ATColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]

#import "ATNextViewController.h"
#import "ATModel.h"

@interface ATNextViewController ()
@property (nonatomic, strong) ATModel *model;
@end

@implementation ATNextViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 100)];
    [btn setTitle:@"pop" forState:UIControlStateNormal];
    [btn setTitleColor:ATColor(arc4random_uniform(255.0), arc4random_uniform(255.0), arc4random_uniform(255.0)) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popClick:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:btn];
    
    ATModel *model = [[ATModel alloc] init];
    self.model = model;
    //为model对象的name属性添加self监听
    //keyPath就是要观察的属性值，options给你观察键值变化的选择，而context方便传输你需要的数据（注意这是一个void型）
    [model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:@"123"];

}

- (void)popClick:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //每次页面即将出现的时候便用KVC修改key值
    [self.model setValue:[NSString stringWithFormat:@"%d",arc4random_uniform(100)] forKey:@"name"];
}

//监听key发生改变的时候触发的方法
//change里存储了一些变化的数据，比如变化前的数据，变化后的数据；如果注册时context不为空，这里context就能接收到。
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"next:%@  %@  %@",keyPath,change,context);
}

- (void)dealloc {
    //在控制器销毁的时候为self.model移除self监听
    [self.model removeObserver:self forKeyPath:@"name"];
}



@end
