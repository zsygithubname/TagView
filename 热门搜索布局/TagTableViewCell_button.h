//
//  TagTableViewCell_button.h
//  热门搜索布局
//
//  Created by zsy on 2017/5/16.
//  Copyright © 2017年 zhangshaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagTableViewCell_button : UITableViewCell
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, copy) void (^ButtonOncellClicked) (NSIndexPath *, NSInteger);
+ (TagTableViewCell_button *)tagCellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
@end
