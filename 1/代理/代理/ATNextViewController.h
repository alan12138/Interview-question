//
//  ATNextViewController.h
//  代理
//
//  Created by 谷士雄 on 16/8/24.
//  Copyright © 2016年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ATNextViewControllerDelegate <NSObject>

@optional
- (void)myBtnColor:(UIColor *)color;

//@required

@end

@interface ATNextViewController : UIViewController
@property (nonatomic, weak) id<ATNextViewControllerDelegate> delegate;
@end
