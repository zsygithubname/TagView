//
//  ViewController.m
//  热门搜索布局
//
//  Created by zsy on 16/7/13.
//  Copyright © 2016年 zhangshaoyun. All rights reserved.
//

#import "ViewController.h"
#import "VMTagsView.h"
#import "TableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"跳转" style:UIBarButtonItemStyleDone target:self action:@selector(jumpTo:)];
    
    
    NSArray *titleArr = @[@"热门",@"新上榜",@"七日热门",@"三十日热门",@"有人说我懒",@"我懒得跟你们解释",@"日报",@"有奖活动",@"简书书",@"喜欢你",@"提笔写篇文章",@"凌晨",@"阳光明媚",@"笑脸璀璨",@"我赠你玫瑰",@"我手有余香",@"黄昏",@"枯藤老树",@"神色黯然",@"你还我玫瑰",@"我心有余伤"];
    
    NSDictionary *dic = [VMTagsView tagsViewForTitleArray:titleArr andWidth:[UIScreen mainScreen].bounds.size.width];
    VMTagsView *tagsview = dic[@"tagsview"];
    CGFloat height = [dic[@"height"] floatValue];
    //frame的宽要和上面传入的宽度保持一致
    tagsview.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, height);
    [self.view addSubview:tagsview];
    
    [tagsview setButtonClickedBlock:^(NSInteger index) {
       NSString *title = titleArr[index];
        NSLog(@"第%ld个按钮被点击========title:%@",index,title);
    }];
}
- (void)jumpTo:(UIBarButtonItem *)item {
    TableViewController *tVC = [[TableViewController alloc] init];
    [self.navigationController pushViewController:tVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
