//
//  TagTableViewCell_button.m
//  热门搜索布局
//
//  Created by zsy on 2017/5/16.
//  Copyright © 2017年 zhangshaoyun. All rights reserved.
//

#import "TagTableViewCell_button.h"
#import "VMTagsView.h"
#import "Header.h"
@interface TagTableViewCell_button ()
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) VMTagsView *tagView;
@end
@implementation TagTableViewCell_button

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)prepareForReuse {
    [super prepareForReuse];
    [self.tagView removeFromSuperview];
}

+ (TagTableViewCell_button *)tagCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    TagTableViewCell_button *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (!cell) {
        cell = [[TagTableViewCell_button alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    return cell;
}
- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    NSDictionary *dic = [VMTagsView tagsViewWithChangeBGColorForTitleArray:titles andWidth:KScreenWidth - 30 normalColor:[UIColor whiteColor] selectedColor:kMainColor];
    _tagView = dic[@"tagsview"];
    [self.contentView addSubview:_tagView];
    @weakify(self);
    [_tagView setButtonClickedBlock:^(NSInteger index){
        @strongify(self);
        if (self.ButtonOncellClicked) {
            self.ButtonOncellClicked(self.indexPath, index);
        }
    }];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 15, 0, 15));
    }];
}
@end
