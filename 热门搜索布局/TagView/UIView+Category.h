//
//  UIView+Category.h
//  VarietyDelivery
//
//  Created by zsy on 2016/12/2.
//  Copyright © 2016年 zsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Category)

/**
 创建一个view

 @param color 背景色
 @return <#return value description#>
 */
+ (UIView *)viewWithBackgroundColor:(UIColor *)color;

/**
 绘制虚线框
 */
- (CAShapeLayer *)drawDashSquare;
/**
 不切圆角 只加边框border
 
 @param radius 圆角半径
 @param bordercolor 边框颜色
 @param borderwidth 边框宽
 */
- (void)cutCornerRadiusWithRadius:(CGFloat)radius bordercolor:(UIColor *)bordercolor borderwidth:(CGFloat)borderwidth;


/**
 设置一个四角圆角
 
 @param radius 圆角半径
 @param color  圆角背景色
 */
- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

/**
 设置一个普通圆角
 
 @param radius  圆角半径
 @param color   圆角背景色
 @param corners 圆角位置
 */
- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

/**
 设置一个带边框的圆角
 
 @param cornerRadii 圆角半径cornerRadii
 @param color       圆角背景色
 @param corners     圆角位置
 @param borderColor 边框颜色
 @param borderWidth 边框线宽
 */
- (void)vd_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


@end

