//
//  ViewController.m
//  通知
//
//  Created by 谷士雄 on 16/8/24.
//  Copyright © 2016年 alan. All rights reserved.
//

#import "ViewController.h"
#import "ATNextViewController.h"
#import "ATNoti.h"

@interface ViewController ()
@property (nonatomic, weak) UIButton *btn;
@property (nonatomic, strong) ATNoti *noti;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通知";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushClick:) forControlEvents:UIControlEventTouchDragInside];
    [self.view addSubview:btn];
    self.btn = btn;
    
    

}


- (void)pushClick:(UIButton *)btn {
    ATNextViewController *nextVc = [[ATNextViewController alloc] init];
    
    if ([self respondsToSelector:@selector(changeMyColor:)]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMyColor:) name:@"changeMyColor" object:nextVc];
    }
    
    ATNoti *noti = [[ATNoti alloc] init];
//    noti.nextVc = nextVc;
    self.noti = noti;

    [self.navigationController pushViewController:nextVc animated:YES];
    
}

- (void)changeMyColor:(NSNotification *)noti {
    [self.btn setTitleColor:(noti.userInfo)[@"btnColor"] forState:UIControlStateNormal];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
