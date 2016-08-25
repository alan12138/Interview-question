//
//  ViewController.m
//  KVO监听
//
//  Created by 谷士雄 on 16/8/24.
//  Copyright © 2016年 alan. All rights reserved.
//

#import "ViewController.h"
#import "ATNextViewController.h"
#import "ATModel.h"

@interface ViewController ()
@property (nonatomic, weak)UIButton *btn;
@property (nonatomic, strong) ATModel *model;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushClick:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:btn];
    self.btn = btn;
    
    ATModel *model = [[ATModel alloc] init];
    self.model = model;
    //为model对象的name属性添加self监听
    [model addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil];
   

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //每次页面即将出现的时候便用KVC修改key值
    [self.model setValue:[NSString stringWithFormat:@"%d",arc4random_uniform(100)] forKey:@"name"];
}
- (void)pushClick:(UIButton *)btn {
    ATNextViewController *nextVc = [[ATNextViewController alloc] init];
    [self.navigationController pushViewController:nextVc animated:YES];
    
}
//监听key发生改变的时候触发的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    NSLog(@"%@  %@",keyPath,change);
}

- (void)dealloc {
    //在控制器销毁的时候为self.model移除self监听
    [self.model removeObserver:self forKeyPath:@"name"];
}

@end
