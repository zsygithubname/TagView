//
//  TagTableViewCell.h
//  热门搜索布局
//
//  Created by zsy on 2017/5/16.
//  Copyright © 2017年 zhangshaoyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *titles;
+ (TagTableViewCell *)tagCellForTableView:(UITableView *)tableView;
@end
