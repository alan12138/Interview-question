//
//  UIView+Extension.m
//  AsyncImage
//
//  Created by 张伟 on 2019/10/12.
//  Copyright © 2019 张伟. All rights reserved.
//

#import "UIView+Extension.h"

static const int tagConst = 12345678;

@implementation UIView (Extension)

#pragma mark - public method
- (void)addRadius:(CGFloat)radius
             corners:(UIRectCorner)corners
             bgColor:(UIColor *)bgColor{
    UIImageView *imgView = [self addCornerImageView];
    CGRect bounds = self.bounds;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self addCornerRadius:radius corners:corners imageView:imgView bounds:bounds bgColor:bgColor];
    });
}
#pragma mark - private method
- (UIImageView *)addCornerImageView{
    UIImageView *imageView = (UIImageView *)[self viewWithTag:tagConst];
    if (!imageView) {
        imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        imageView.userInteractionEnabled = NO;
        imageView.opaque = YES;
        imageView.tag = tagConst;//防重复添加
        [self addSubview:imageView];
        [self bringSubviewToFront:imageView];
    }
    
    return imageView;
}
- (void)addCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners imageView:(UIImageView *)imageView bounds:(CGRect)bounds bgColor:(UIColor *)bgColor{
    
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:bounds];
    UIBezierPath *cornerPath = [[UIBezierPath bezierPathWithRoundedRect:bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)] bezierPathByReversingPath];
    
    [path appendPath:cornerPath];
    //裁剪出圆角路径
    CGContextAddPath(context, path.CGPath);
    //用背景色填充路径
    [bgColor set];
    CGContextFillPath(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    dispatch_async(dispatch_get_main_queue(), ^{
        imageView.image = image;
    });
}

@end
