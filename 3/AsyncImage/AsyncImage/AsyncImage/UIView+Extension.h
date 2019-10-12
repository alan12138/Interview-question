//
//  UIView+Extension.h
//  AsyncImage
//
//  Created by 张伟 on 2019/10/12.
//  Copyright © 2019 张伟. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Extension)
- (void)addRadius:(CGFloat)radius
             corners:(UIRectCorner)corners
             bgColor:(UIColor *)bgColor;
@end

NS_ASSUME_NONNULL_END
