//
//  UIImage+Category.h
//  VarietyDelivery
//
//  Created by zsy on 2016/12/2.
//  Copyright © 2016年 zsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)vd_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock;

+ (UIImage *)vd_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
