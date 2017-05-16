//
//  VMTagsView.h
//  VarietyMarket
//
//  Created by zsy on 16/7/13.
//  Copyright © 2016年 dangdailife. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VMTagsView;
typedef void(^CreatTagsviewComplete)(VMTagsView *tagsView,CGFloat height);
@interface VMTagsView : UIView
/*
 *  根据传入的要布局的总宽度和标题数组返回总高度和封装好的view的字典 对应key为 height tagsview
 *
 *  @param titleArray 标题数组
 *  @param allWidth 需要布局的宽度
 *
 *  @return 
 */
+ (NSDictionary *)tagsViewForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth;


/**
 *  根据传入的布局的总宽度和标题数组返回总高度 和下面的init配合使用和上面效果一样
 *
 *  @param titleArray 标题数组
 *  @param allWidth   需要布局的宽度
 *
 *  @return 总高度
 */
+ (CGFloat)tagsViewHeightForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;
//==========================带图标的=============================================
/*
 *  带选中状态下图标的 和默认选中的
 *
 *  @param titleArray
 *  @param allWidth
 *  @param index      默认选中的
 *
 *  @return
 */
+ (NSDictionary *)tagsViewWithIconForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth defaultSelectedButton:(NSInteger)index;
//=============================================================================
/*
 *  改变背景色的
 *
 *  @param titleArray <#titleArray description#>
 *  @param allWidth   <#allWidth description#>
 *
 *  @return <#return value description#>
 */
+ (NSDictionary *)tagsViewWithChangeBGColorForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor;
/*
 *  view上button被点击的block回调 参数为被点击button的序号
 */
@property (nonatomic, copy) void (^buttonClickedBlock)(NSInteger);

/*******************************************************************************************/

/**
 用label创建  异步的 如果在tableviewcell上布局 推荐使用此方法  需要点击事件的可以把label换成button

 @param titleArray <#titleArray description#>
 @param titleColor <#titleColor description#>
 @param borderColor <#borderColor description#>
 @param superView <#superView description#>
 @param allWidth <#allWidth description#>
 @param complete <#complete description#>
 */
+ (void)tagsViewWithTitleArray:(NSArray *)titleArray titleColor:(UIColor *)titleColor borderColor:(UIColor *)borderColor superView:(UIView *)superView andWidth:(CGFloat)allWidth complete:(CreatTagsviewComplete)complete;
@end
