//
//  TableViewController.m
//  热门搜索布局
//
//  Created by zsy on 2017/5/16.
//  Copyright © 2017年 zhangshaoyun. All rights reserved.
//

#import "TableViewController.h"
#import "TagTableViewCell.h"
#import "VMTagsView.h"
#import "Header.h"
#import "TagTableViewCell_button.h"
@interface TableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, assign) CGFloat height;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _titles = @[@"热门",@"新上榜",@"七日热门",@"三十日热门",@"有人说我懒",@"我懒得跟你们解释",@"日报",@"有奖活动",@"简书书",@"喜欢你",@"提笔写篇文章",@"凌晨",@"阳光明媚",@"笑脸璀璨",@"我赠你玫瑰",@"我手有余香",@"黄昏",@"枯藤老树",@"神色黯然",@"你还我玫瑰",@"我心有余伤"];
    _height = [VMTagsView tagsViewHeightForTitleArray:_titles andWidth:KScreenWidth - 15];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    int remainder = indexPath.row % 2;
    if (remainder == 0) {
        TagTableViewCell *cell1 = [TagTableViewCell tagCellForTableView:tableView];
        cell1.titles = self.titles;
        return cell1;
    }else {
        TagTableViewCell_button *cell2 = [TagTableViewCell_button tagCellForTableView:tableView indexPath:indexPath];
        [cell2 setButtonOncellClicked:^(NSIndexPath *indexP, NSInteger index){
            NSLog(@"第%ld行 第%ld个按钮被点击!!!!!!!!!",indexP.row,index);
        }];
        cell2.titles = self.titles;
        return cell2;
    }
    return nil;
}
@end
