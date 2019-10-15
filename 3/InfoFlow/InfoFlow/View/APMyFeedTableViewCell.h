//
//  APMyFeedTableViewCell.h
//  InfoFlow
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ATExpandBlock)(BOOL isExpand);
typedef void(^PreviewPhotosBlock)(NSMutableArray *icons,int i);

@class APMyFeedLayout;
@interface APMyFeedTableViewCell : UITableViewCell
+ (APMyFeedTableViewCell *)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) APMyFeedLayout *layout;
@property (nonatomic, copy) ATExpandBlock expandBlock;
@property (nonatomic, copy) PreviewPhotosBlock previewPhotosBlock;
@end
