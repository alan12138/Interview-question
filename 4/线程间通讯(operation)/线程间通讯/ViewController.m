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
    // operation
}

//operration线程间通讯
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSURL *url0 = [NSURL URLWithString:@"http://www.xiaoseyu.com/uploads/allimg/120717/134250J43Y0-2D15.jpg"];
    NSURL *url1 = [NSURL URLWithString:@"http://www.bz55.com/uploads/allimg/151031/140-151031092433.jpg"];
    
//异步下载两张图片，回到主线程显示

    // 创建队列
//    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    
//    __block UIImage *image0 = nil;
//    __block UIImage *image1 = nil;
//    
//    // 创建3个操作
//    NSOperation *a = [NSBlockOperation blockOperationWithBlock:^{
//        NSData *data = [NSData dataWithContentsOfURL:url0];
//        image0 = [UIImage imageWithData:data];
//        NSLog(@"当前调用线程：%@", [NSThread currentThread]);
//    }];
//    NSOperation *b = [NSBlockOperation blockOperationWithBlock:^{
//        NSData *data = [NSData dataWithContentsOfURL:url1];
//        image1 = [UIImage imageWithData:data];
//        NSLog(@"当前调用线程：%@", [NSThread currentThread]);
//    }];
//    NSOperation *c = [NSBlockOperation blockOperationWithBlock:^{
//        [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image0 waitUntilDone:NO];
//        [self.imageView1 performSelectorOnMainThread:@selector(setImage:) withObject:image1 waitUntilDone:NO];
//    }];
//    
//    // 添加依赖
//    [b addDependency:a];
////    [c addDependency:a];
//    [c addDependency:b];
//    
//    // 执行操作
//    [queue addOperation:a];
//    [queue addOperation:b];
//    [queue addOperation:c];

    
    //其他用法
    
//    // 这个操作是：调用self的btnClick:方法
    NSInvocationOperation *operation0 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(btnClick:) object:nil];
    // 开始执行任务(同步执行)
//    [operation0 start];
   
    
    //并行执行多个block,线程自动分配
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^(){
        NSLog(@"执行第1次操作，线程：%@", [NSThread currentThread]);
    }];
    
    [operation1 addExecutionBlock:^() {
        NSLog(@"又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
    
    [operation1 addExecutionBlock:^() {
        NSLog(@"又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
    
    [operation1 addExecutionBlock:^() {
        NSLog(@"又执行了1个新的操作，线程：%@", [NSThread currentThread]);
    }];
    
    // 开始执行任务  
//    [operation1 start];
//
    //加入队列异步执行
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    //队列和operation的一些控制性操作
/*    // 每次只能执行一个操作
    queue.maxConcurrentOperationCount = 1;
    // 取消单个操作
    [operation1 cancel];
    
    // 取消queue中所有的操作
    [queue cancelAllOperations];
    // 会阻塞当前线程，等到某个operation执行完毕
    [operation1 waitUntilFinished];
    
    // 阻塞当前线程，等待queue的所有操作执行完毕
    [queue waitUntilAllOperationsAreFinished];
    // 暂停queue
    [queue setSuspended:YES];
    
    // 继续queue
    [queue setSuspended:NO];
 */
    
    [queue addOperation:operation0];
    [queue addOperation:operation1];
//    [queue addOperations:operations waitUntilFinished:NO];  
    
    [queue addOperationWithBlock:^() {
        NSLog(@"执行一个新的操作，线程：%@", [NSThread currentThread]);
    }];

}

- (IBAction)btnClick:(id)sender {
    NSLog(@"当前调用线程：%@", [NSThread currentThread]);
}

@end
