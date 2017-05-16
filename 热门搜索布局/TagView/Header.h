//
//  Header.h
//  热门搜索布局
//
//  Created by zsy on 2017/5/16.
//  Copyright © 2017年 zhangshaoyun. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "NSObject+Category.h"
#import "UIImage+Category.h"
#import "UIView+Category.h"
#import "Masonry.h"
#ifndef Header_h
#define Header_h

#define kButtonHeight 28
#define kButtonTitleInset 14

#define KColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kMainTextGrayColor       KColorFromRGB(0x5d5d5d)
#define kMainColor KColorFromRGB(0xff6d00)
#define Font(FONT)  [UIFont systemFontOfSize:FONT]
#define kCommenFont 14
#define KScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define KScreenWidth ([UIScreen mainScreen].bounds.size.width)

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif
#endif /* Header_h */
