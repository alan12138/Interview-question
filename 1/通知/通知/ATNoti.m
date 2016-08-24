//
//  ATNoti.m
//  通知
//
//  Created by 谷士雄 on 16/8/24.
//  Copyright © 2016年 alan. All rights reserved.
//

#import "ATNoti.h"

@implementation ATNoti
- (instancetype)init {
    if (self = [super init]) {
    
        if ([self respondsToSelector:@selector(changeMyColor:)]) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeMyColor:) name:@"changeMyColor" object:nil]; //object也可以是self.nextVc,表明只接收self.nextVc对象的通知，那就需要把这个对象传进来
        }
    }
    return self;

}

- (void)changeMyColor:(NSNotification *)noti {
    NSLog(@"%@",noti.userInfo[@"btnColor"]);
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
