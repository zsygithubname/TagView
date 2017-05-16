//
//  CALayer+Category.h
//  VarietyDelivery
//
//  Created by zsy on 2017/2/24.
//  Copyright © 2017年 zsy. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Header.h"
@interface CALayer (Category)
@property (nonatomic, strong) UIImage *contentImage;//contents的便捷设置

/**如下分别对应UIView的相应API*/

- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color;

- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners;

- (void)vd_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
