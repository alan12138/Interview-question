//
//  ViewController.m
//  代理
//
//  Created by 谷士雄 on 16/8/24.
//  Copyright © 2016年 alan. All rights reserved.
//

#import "ViewController.h"
#import "ATNextViewController.h"

@interface ViewController ()<ATNextViewControllerDelegate>
@property (nonatomic, weak) UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"代理";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushClick:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:btn];
    self.btn = btn;
    
    
}

- (void)pushClick:(UIButton *)btn {
    ATNextViewController *nextVc = [[ATNextViewController alloc] init];
    nextVc.delegate = self;
    [self.navigationController pushViewController:nextVc animated:YES];

}

#pragma mark - ATNextViewControllerDelegate
- (void)myBtnColor:(UIColor *)color {
    [self.btn setTitleColor:color forState:UIControlStateNormal];
}

@end
