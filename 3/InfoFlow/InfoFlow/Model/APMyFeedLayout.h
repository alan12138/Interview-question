//
//  APMyFeedLayout.h
//  InfoFlow
//
//  Created by 张伟 on 2019/10/14.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APMyFeed.h"

NS_ASSUME_NONNULL_BEGIN

@interface APMyFeedLayout : NSObject
@property (nonatomic, strong) APMyFeed *feed;
@property (nonatomic, assign) CGRect iconRect;
@property (nonatomic, assign) CGRect nameRect;
@property (nonatomic, assign) CGRect sexRect;
@property (nonatomic, assign) CGRect contentRect;
@property (nonatomic, assign) CGRect expandRect;
@property (nonatomic, assign) BOOL expandHidden;
@property (nonatomic, assign) CGRect timeRect;
@property (nonatomic, strong) NSMutableArray *imageRects;

@property (nonatomic, assign) CGRect locationRect;
@property (nonatomic, assign) CGRect delRect;
@property (nonatomic, assign) CGRect zanLabelRect;
@property (nonatomic, assign) CGRect zanBtnRect;

@property (nonatomic, assign) CGRect commentLabelRect;
@property (nonatomic, assign) CGRect commentBtnRect;
@property (nonatomic, assign) CGRect seperatorViewRect;

@property (nonatomic, assign) CGFloat height;
@end

NS_ASSUME_NONNULL_END
