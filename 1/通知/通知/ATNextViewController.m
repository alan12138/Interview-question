//
//  ATNextViewController.m
//  通知
//
//  Created by 谷士雄 on 16/8/24.
//  Copyright © 2016年 alan. All rights reserved.
//

#define ATColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]

#import "ATNextViewController.h"

@implementation ATNextViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"pop" forState:UIControlStateNormal];
    [btn setTitleColor:ATColor(arc4random_uniform(255.0), arc4random_uniform(255.0), arc4random_uniform(255.0)) forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popClick:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:btn];

    
}

- (void)popClick:(UIButton *)btn {
    NSDictionary *dict = @{@"btnColor" : btn.titleLabel.textColor};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeMyColor" object:self userInfo:dict];
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
