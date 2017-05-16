//
//  NSString+Category.m
//  热门搜索布局
//
//  Created by zsy on 2017/5/16.
//  Copyright © 2017年 zhangshaoyun. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
- (CGFloat)widthForFontSize:(CGFloat)fontSize {
   
    NSDictionary *textDic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:textDic context:nil].size;
    return size.width + 2;
}
@end
