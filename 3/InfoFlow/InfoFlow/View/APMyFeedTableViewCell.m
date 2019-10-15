//
//  APMyFeedTableViewCell.m
//  InfoFlow
//
//  Created by mac on 2018/9/6.
//  Copyright © 2018年 alan. All rights reserved.
//

#import "APMyFeedTableViewCell.h"
#import "UIButton+webCache.h"
#import "APMyFeedLayout.h"
#import "ATLabel.h"
#import "UIView+Extension.h"
#import "APMyFeedContentImage.h"
#define MAS_SHORTHAND_GLOBALS //使用全局宏定义(需要放在.pch文件中)，可以使equalTo- 等效于mas_equalTo
#define MAS_SHORTHAND //使用全局宏定义(需要放在.pch文件中), 可以在调用masonry方法的时候不使用mas_前缀
#import "Masonry.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define CONTENT_BTN_TAG_CONST 10000

@interface APMyFeedTableViewCell()
@property (nonatomic, weak) UIButton *headIconBtn;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UIImageView *sexIconView;
@property (nonatomic, weak) ATLabel *contentLabel;
@property (nonatomic, strong) NSMutableArray *contentImageBtns;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UIButton *delBtn;
@property (nonatomic, weak) UILabel *zanLabel;
@property (nonatomic, weak) UILabel *commentLabel;
@property (nonatomic, weak) UIButton *zanBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIView *seperatorView;

@property (nonatomic, weak) UIButton *expandBtn;
@end

@implementation APMyFeedTableViewCell

+ (APMyFeedTableViewCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"APMyFeedTableViewCell";
    APMyFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == NULL) {
        cell = [[APMyFeedTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
- (void)setLayout:(APMyFeedLayout *)layout {
    _layout = layout;
    
    [self.headIconBtn sd_setImageWithURL:[NSURL URLWithString:layout.feed.headIcon] forState:UIControlStateNormal];
    self.headIconBtn.frame = layout.iconRect;
    [self.headIconBtn addRadius:self.headIconBtn.bounds.size.width / 2 corners:UIRectCornerAllCorners bgColor:[UIColor whiteColor]];
    
    self.nameLabel.text = layout.feed.name;
    self.nameLabel.frame = layout.nameRect;
    
    [self.sexIconView setImage:[UIImage imageNamed:layout.feed.sex]];
    self.sexIconView.frame = layout.sexRect;
    
    self.contentLabel.text = layout.feed.content;
    self.contentLabel.frame = layout.contentRect;
    
    self.timeLabel.text = layout.feed.time;
    self.timeLabel.frame = layout.timeRect;
    
    self.locationLabel.text = layout.feed.location;
    self.locationLabel.frame = layout.locationRect;
    
    self.delBtn.frame = layout.delRect;
    
    self.zanLabel.text = layout.feed.zan;
    self.zanLabel.frame = layout.zanLabelRect;
    
    self.commentLabel.text = layout.feed.comment;
    self.commentLabel.frame = layout.commentLabelRect;
    
    self.zanBtn.frame = layout.zanBtnRect;
    self.commentBtn.frame = layout.commentBtnRect;
    
    self.expandBtn.frame = layout.expandRect;
    self.expandBtn.hidden = layout.expandHidden;
    if (layout.feed.isExpand) {
        [self.expandBtn setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        [self.expandBtn setTitle:@"全文" forState:UIControlStateNormal];
    }
    
    self.seperatorView.frame = layout.seperatorViewRect;
    
    for (UIButton *btn in self.contentImageBtns) {
        btn.frame = CGRectZero;
    }
    for (int i = 0; i < layout.imageRects.count; i++) {
        CGRect imageRect = [layout.imageRects[i] CGRectValue];
        UIButton *btn = self.contentImageBtns[i];
        btn.frame = imageRect;
        NSString *imageStr = [(APMyFeedContentImage *)(layout.feed.contentImages[i]) imageUrlStr];
        NSString *videoStr = [(APMyFeedContentImage *)(layout.feed.contentImages[i]) videoUrlStr];
        if (videoStr) {
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:imageStr] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"动态视频播放"] forState:UIControlStateNormal];
        } else {
            [btn sd_setImageWithURL:[NSURL URLWithString:imageStr] forState:UIControlStateNormal];
        }
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        self.contentImageBtns = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    UIButton *headIconBtn = [[UIButton alloc] init];
    [self.contentView addSubview:headIconBtn];
    self.headIconBtn = headIconBtn;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UIImageView *sexIconView = [[UIImageView alloc] init];
    [self.contentView addSubview:sexIconView];
    self.sexIconView = sexIconView;
    
    ATLabel *contentLabel = [[ATLabel alloc] init];
    contentLabel.numberOfLines = 0;
    contentLabel.font = [UIFont systemFontOfSize:14];
    contentLabel.textColor = [UIColor colorWithRed:26/255.0 green:26/255.0 blue:26/255.0 alpha:1];
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;

    for (int i = 0; i < 9; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = CONTENT_BTN_TAG_CONST + i;
        [btn addTarget:self action:@selector(contentImageClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
        [self.contentImageBtns addObject:btn];
    }
    
    UIButton *expandBtn = [[UIButton alloc] init];
    [expandBtn setTitle:@"全文" forState:UIControlStateNormal];
    expandBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [expandBtn setTitleColor:[UIColor colorWithRed:118/255.0 green:118/255.0 blue:253/255.0 alpha:1] forState:UIControlStateNormal];
    [expandBtn addTarget:self action:@selector(expandBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:expandBtn];
    self.expandBtn = expandBtn;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = [UIFont systemFontOfSize:12];
    timeLabel.textColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UILabel *locationLabel = [[UILabel alloc] init];
    locationLabel.font = [UIFont systemFontOfSize:12];
    locationLabel.textColor = [UIColor colorWithRed:118/255.0 green:118/255.0 blue:253/255.0 alpha:1];
    [self.contentView addSubview:locationLabel];
    self.locationLabel = locationLabel;
    
    UIButton *delBtn = [[UIButton alloc] init];
    [delBtn setImage:[UIImage imageNamed:@"删除动态"] forState:UIControlStateNormal];
    [self.contentView addSubview:delBtn];
    self.delBtn = delBtn;
    
    UILabel *zanLabel = [[UILabel alloc] init];
    zanLabel.font = [UIFont systemFontOfSize:12];
    zanLabel.textColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
    [self.contentView addSubview:zanLabel];
    self.zanLabel = zanLabel;
    
    UIButton *zanBtn = [[UIButton alloc] init];
    [zanBtn setImage:[UIImage imageNamed:@"我的动态点赞"] forState:UIControlStateNormal];
    [self.contentView addSubview:zanBtn];
    self.zanBtn = zanBtn;
    
    UILabel *commentLabel = [[UILabel alloc] init];
    commentLabel.font = [UIFont systemFontOfSize:12];
    commentLabel.textColor = [UIColor colorWithRed:176/255.0 green:176/255.0 blue:176/255.0 alpha:1];
    [self.contentView addSubview:commentLabel];
    self.commentLabel = commentLabel;

    UIButton *commentBtn = [[UIButton alloc] init];
    [commentBtn setImage:[UIImage imageNamed:@"我的动态评论"] forState:UIControlStateNormal];
    [self.contentView addSubview:commentBtn];
    self.commentBtn = commentBtn;
    
    UIView *seperatorView = [[UIView alloc] init];
    seperatorView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.contentView addSubview:seperatorView];
    self.seperatorView = seperatorView;
}

- (void)expandBtnClick:(UIButton *)btn {
    if (self.expandBlock) {
        self.expandBlock(self.layout.feed.expand);
    }
}

- (void)contentImageClick:(UIButton *)btn {
    if (self.previewPhotosBlock) {
        self.previewPhotosBlock(self.layout.feed.contentImages,(int)(btn.tag - CONTENT_BTN_TAG_CONST));
    }
    
}
@end
