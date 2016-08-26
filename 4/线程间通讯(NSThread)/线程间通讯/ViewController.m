//
//  ViewController.m
//  线程间通讯
//
//  Created by 谷士雄 on 16/8/26.
//  Copyright © 2016年 alan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // NSThread
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL *url = [NSURL URLWithString:@"http://imgs.aijiaijia.com/mobile/product/2016-08-25/pro_b3d703.jpg"];
    //去子线程执行耗时任务
//    [self performSelectorInBackground:@selector(downloadSomething:) withObject:url];
    
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(downloadSomething:) object:url];
//    // 设置线程的优先级(0.0 - 1.0，1.0最高级)
//    //thread.threadPriority = 1.0;
//    [thread start];
    
    [NSThread detachNewThreadSelector:@selector(downloadSomething:) toTarget:self withObject:url];
    
}

- (void)downloadSomething:(NSURL *)url {
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"%@",[NSThread currentThread]);
    
    //线程睡眠
//    [NSThread sleepForTimeInterval:5.0];
    
//    NSDate *date = [NSDate dateWithTimeInterval:2.0 sinceDate:[NSDate date]];
//    [NSThread sleepUntilDate:date];
    
    //回到主线程刷新界面
    //    [self performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
    //    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:NO];
    
    [self.imageView performSelector:@selector(setImage:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
    
}

//- (void)setImage:(UIImage *)image {
//    self.imageView.image = image;
//}

@end
