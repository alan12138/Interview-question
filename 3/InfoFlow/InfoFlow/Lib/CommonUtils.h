//
//  CommonUtils.h
//  InfoFlow
//
//  Created by mac on 2018/9/12.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonUtils : NSObject
+ (BOOL)iPhoneX;
+ (CGFloat)calcLabelHeight:(NSString *)str fontSize:(CGFloat)fontSize width:(CGFloat)width;
+ (CGFloat)calcWidthWithTitle:(NSString *)title font:(CGFloat)font;
+ (int)getATLabelHeightWithString:(NSAttributedString *)string  width:(int)width;
@end
