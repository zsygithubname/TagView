//
//  UIView+Category.m
//  VarietyDelivery
//
//  Created by zsy on 2016/12/2.
//  Copyright © 2016年 zsy. All rights reserved.
//

#import "UIView+Category.h"
#import "CALayer+Category.h"
@implementation UIView (Category)
+ (UIView *)viewWithBackgroundColor:(UIColor *)color {
    UIView *view = [UIView new];
    view.backgroundColor = color;
    return view;
}

- (CAShapeLayer *)drawDashSquare {
    CAShapeLayer *border = [CAShapeLayer layer];
    
    border.strokeColor = kMainColor.CGColor;
    
    border.fillColor = nil;
    CGRect rect = CGRectMake(-3, -3, self.bounds.size.width + 10, self.bounds.size.height + 10);
    border.path = [UIBezierPath bezierPathWithRect:rect].CGPath;
    
    border.frame = rect;
    
    border.lineWidth = 1.f;
    
    border.lineCap = @"square";
    
    border.lineDashPattern = @[@4, @2];
    [self.layer addSublayer:border];
    return border;
}

- (void)cutCornerRadiusWithRadius:(CGFloat)radius bordercolor:(UIColor *)bordercolor borderwidth:(CGFloat)borderwidth {
    if(borderwidth > 0) {
        CAShapeLayer *borderLayer = [CAShapeLayer layer];
        // 用贝赛尔曲线画线，path 其实是在线的中间，这样会被 layer.mask（遮罩层)遮住一半，故在 halfWidth 处新建 path，刚好产生一个内描边
        CGFloat halfWidth = borderwidth /2.0f;
        CGRect layerFrame = CGRectMake(halfWidth, halfWidth,CGRectGetWidth(self.bounds) - borderwidth,CGRectGetHeight(self.bounds) - borderwidth);
        borderLayer.path = [UIBezierPath bezierPathWithRoundedRect:layerFrame byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)].CGPath;
        borderLayer.fillColor = [UIColor clearColor].CGColor;
        borderLayer.strokeColor = bordercolor.CGColor;
        borderLayer.lineWidth = borderwidth;
        borderLayer.frame = CGRectMake(0,0,CGRectGetWidth(layerFrame),CGRectGetHeight(layerFrame));
        [self.layer addSublayer:borderLayer];
    }
}


- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self.layer vd_roundedCornerWithRadius:radius cornerColor:color];
}

- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self.layer vd_roundedCornerWithRadius:radius cornerColor:color corners:corners];
}

- (void)vd_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self.layer vd_roundedCornerWithCornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}
@end
