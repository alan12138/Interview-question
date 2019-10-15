//
//  APMyFeedLayout.m
//  InfoFlow
//
//  Created by 张伟 on 2019/10/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import "APMyFeedLayout.h"
#import "CommonUtils.h"

static const CGFloat nameFont = 14;
static const CGFloat contentFont = 14;
static const CGFloat timeFont = 12;
static const CGFloat locationFont = 12;
static const CGFloat zanFont = 12;
static const CGFloat commentFont = 12;

@implementation APMyFeedLayout

- (void)setFeed:(APMyFeed *)feed {
    _feed = feed;
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    self.iconRect = CGRectMake(10, 10, 45, 45);
    CGFloat nameW = [CommonUtils calcWidthWithTitle:feed.name font:nameFont];
    CGFloat nameH = [CommonUtils calcLabelHeight:feed.name fontSize:nameFont width:nameW];
    self.nameRect = CGRectMake(CGRectGetMaxX(self.iconRect) + 11, 17, nameW, nameH);
    self.sexRect = CGRectMake(CGRectGetMaxX(self.iconRect) + 9, CGRectGetMaxY(self.nameRect) + 6, 12, 12);
    
    CGFloat contentW = screenW - 10 - 16;
    CGFloat contentH = 0;

    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    // 绘制的内容属性字符串
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:contentFont],
                                 NSForegroundColorAttributeName: [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1]
                                 ,NSParagraphStyleAttributeName: paragraphStyle
                                 ,NSKernAttributeName:@0
                                 };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:feed.content attributes:attributes];
    contentH = [CommonUtils getATLabelHeightWithString:attrStr width:contentW];
    
    if (attrStr.length > 140) {
        if (feed.isExpand) {
            self.contentRect = CGRectMake(10, CGRectGetMaxY(self.iconRect) + 10, contentW, contentH);
        } else {
            attrStr = [[NSMutableAttributedString alloc] initWithString:[feed.content substringToIndex:140] attributes:attributes];
            contentH = [CommonUtils getATLabelHeightWithString:attrStr width:contentW];
            self.contentRect = CGRectMake(10, CGRectGetMaxY(self.iconRect) + 10, contentW, contentH);
        }
    } else {
        self.contentRect = CGRectMake(10, CGRectGetMaxY(self.iconRect) + 10, contentW, contentH);
    }
    
    if (attrStr.length < 140) {
        self.expandHidden = YES;
        self.expandRect = CGRectMake(10, CGRectGetMaxY(self.contentRect) - 20, 30, 20);
    } else {
        self.expandHidden = NO;
        self.expandRect = CGRectMake(10, CGRectGetMaxY(self.contentRect) + 10, 30, 20);
    }
    
    CGFloat timeW = [CommonUtils calcWidthWithTitle:feed.time font:timeFont];
    CGFloat timeH = [CommonUtils calcLabelHeight:feed.time fontSize:timeFont width:timeW];
    self.imageRects = [NSMutableArray array];
    if (feed.contentImages.count == 0) {
        self.timeRect = CGRectMake(10, CGRectGetMaxY(self.expandRect) + 10, timeW, timeH);
    } else {
        if (feed.contentImages.count == 1) {
            CGRect imageRect = CGRectMake(11, CGRectGetMaxY(self.expandRect) + 10, 250, 150);
            [self.imageRects addObject:@(imageRect)];
        } else if (feed.contentImages.count == 2 || feed.contentImages.count == 3) {
            for (int i = 0; i < feed.contentImages.count; i++) {
                CGRect imageRect = CGRectMake(11 + i * (10 + 90), CGRectGetMaxY(self.expandRect) + 10, 90, 90);
                [self.imageRects addObject:@(imageRect)];
            }
        } else if (feed.contentImages.count == 4) {
            for (int i = 0; i < 2; i++) {
                for (int j = 0; j < 2; j++) {
                    CGRect imageRect = CGRectMake(11 + j * (10 + 90), CGRectGetMaxY(self.expandRect) + 10 + i * (10 + 90), 90, 90);
                    [self.imageRects addObject:@(imageRect)];
                }
            }
        } else if (feed.contentImages.count == 5 || feed.contentImages.count == 6 || feed.contentImages.count == 7 || feed.contentImages.count == 8 || feed.contentImages.count == 9) {
            for (int i = 0; i < feed.contentImages.count; i++) {
                CGRect imageRect = CGRectMake(11 + (i % 3) * (10 + 90), CGRectGetMaxY(self.expandRect) + 10 + (i / 3) * (10 + 90), 90, 90);
                [self.imageRects addObject:@(imageRect)];
            }
        }
    }
    
    if (self.imageRects.count > 0) {
            CGRect lastRect = [self.imageRects[self.imageRects.count - 1] CGRectValue];
            self.timeRect = CGRectMake(10, CGRectGetMaxY(lastRect) + 10, timeW, timeH);
    }
    
    CGFloat locationW = [CommonUtils calcWidthWithTitle:feed.location font:locationFont];
    CGFloat locationH = [CommonUtils calcLabelHeight:feed.location fontSize:locationFont width:locationW];
    self.locationRect = CGRectMake(CGRectGetMaxX(self.timeRect) + 10, self.timeRect.origin.y, locationW, locationH);
    
    self.delRect = CGRectMake(10, CGRectGetMaxY(self.timeRect) + 15, 16, 18);
    
    CGFloat zanLabelW = [CommonUtils calcWidthWithTitle:feed.zan font:zanFont];
    CGFloat zanLabelH = [CommonUtils calcLabelHeight:feed.zan fontSize:zanFont width:zanLabelW];
    self.zanLabelRect = CGRectMake(screenW - 10 - zanLabelW, self.delRect.origin.y + (self.delRect.size.height - zanLabelH) * 0.5, zanLabelW, zanLabelH);
    
    CGFloat zanBtnW = 20;
    CGFloat zanBtnH = 18;
    self.zanBtnRect = CGRectMake(self.zanLabelRect.origin.x - 5 - zanBtnW, self.delRect.origin.y + (self.delRect.size.height - zanBtnH) * 0.5, zanBtnW, zanBtnH);
    
    CGFloat commentLabelW = [CommonUtils calcWidthWithTitle:feed.comment font:commentFont];
    CGFloat commentLabelH = [CommonUtils calcLabelHeight:feed.comment fontSize:commentFont width:commentLabelW];
    self.commentLabelRect = CGRectMake(self.zanBtnRect.origin.x - 15 - commentLabelW, self.delRect.origin.y + (self.delRect.size.height - commentLabelH) * 0.5, commentLabelW, commentLabelH);
    
    CGFloat commentBtnW = 20;
    CGFloat commentBtnH = 19;
    self.commentBtnRect = CGRectMake(self.commentLabelRect.origin.x - 5 - commentBtnW, self.delRect.origin.y + (self.delRect.size.height - commentBtnH) * 0.5, commentBtnW, commentBtnH);\
    
    self.seperatorViewRect = CGRectMake(0, CGRectGetMaxY(self.delRect) + 10, screenW, 15);
    
    self.height = CGRectGetMaxY(self.seperatorViewRect);
}

@end
