//
//  ViewController.m
//  AsyncLabel
//
//  Created by 张伟 on 2019/10/9.
//  Copyright © 2019 张伟. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Extension.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setImage:[UIImage imageNamed:@"临时"] forState:UIControlStateNormal];
    [btn addRadius:btn.bounds.size.width / 2 corners:UIRectCornerAllCorners bgColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    NSLog(@"=====");
}
@end
