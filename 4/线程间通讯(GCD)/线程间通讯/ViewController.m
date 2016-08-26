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
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // GCD
}

//GCD线程间通讯
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL *url = [NSURL URLWithString:@"http://www.bz55.com/uploads/allimg/151031/140-151031092433.jpg"];
    
//异步下载一张图片，回到主线程显示
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        UIImage *image = [UIImage imageWithData:data];
//        NSLog(@"%@",[NSThread currentThread]);
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = image;
//        });
//    });
    
    NSURL *url1 = [NSURL URLWithString:@"http://www.bz55.com/uploads/allimg/151031/140-151031092433.jpg"];
//异步下载两张图片，回到主线程显示
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        NSData *data1 = [NSData dataWithContentsOfURL:url1];
//        UIImage *image = [UIImage imageWithData:data];
//        UIImage *image1 = [UIImage imageWithData:data1];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.imageView.image = image;
//            self.imageView1.image = image1;
//        });
//        
//    });
    
    //Dispatch Group:可以用来阻塞一个线程, 直到group关联的所有的任务完成执行。有时候你必须等待任务完成的结果,然后才能继续后面的处理。
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        __block UIImage *image = nil; //注意block给image赋值，必须加__block前缀
        __block UIImage *image1 = nil;
        //往组中添加任务
        dispatch_group_async(group, queue, ^{
            NSData *data = [NSData dataWithContentsOfURL:url];
            image = [UIImage imageWithData:data];
        });
        //往组中添加任务
        dispatch_group_async(group, queue, ^{
            NSData *data1 = [NSData dataWithContentsOfURL:url1];
            image1 = [UIImage imageWithData:data1];
        });
        // 等待组中的任务执行完毕,回到主线程执行block回调
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            self.imageView1.image = image1;
        });
    });
}
//GCD的一些其他介绍
- (IBAction)btnClick:(id)sender {
    // 调用前，查看下当前线程
    NSLog(@"当前调用线程：%@", [NSThread currentThread]);
    
    // 创建一个串行queue
//    dispatch_queue_t queue = dispatch_queue_create("cueue", NULL);
//    
//    dispatch_async(queue, ^{
//        NSLog(@"开启了一个异步任务，当前线程：%@", [NSThread currentThread]);
//    });
//    
//    dispatch_sync(queue, ^{
//        NSLog(@"开启了一个同步任务，当前线程：%@", [NSThread currentThread]);
//    });
}

@end
