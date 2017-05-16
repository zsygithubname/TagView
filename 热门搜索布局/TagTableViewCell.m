//
//  TagTableViewCell.m
//  热门搜索布局
//
//  Created by zsy on 2017/5/16.
//  Copyright © 2017年 zhangshaoyun. All rights reserved.
//

#import "TagTableViewCell.h"
#import "VMTagsView.h"
#import "Header.h"
@interface TagTableViewCell ()
@property (nonatomic, strong) VMTagsView *tagView;
@end
@implementation TagTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)prepareForReuse {
    [super prepareForReuse];
    [self.tagView removeFromSuperview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (TagTableViewCell *)tagCellForTableView:(UITableView *)tableView {
    TagTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell = [[TagTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    @weakify(self);
    [VMTagsView tagsViewWithTitleArray:titles titleColor:kMainColor borderColor:kMainColor superView:self.contentView andWidth:KScreenWidth - 30 complete:^(VMTagsView *tagsView, CGFloat height) {
        @strongify(self);
        self.tagView = tagsView;
        [self.contentView addSubview:tagsView];
        [tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
        }];
    }];
}
@end
