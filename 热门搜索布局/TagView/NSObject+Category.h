//
//  NSObject+Category.h
//  VarietyDelivery
//
//  Created by zsy on 2017/1/16.
//  Copyright © 2017年 zsy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)



/**
 字典转model

 @param dic <#dic description#>
 @return <#return value description#>
 */
+ (instancetype)objectWithDic:(NSDictionary *)dic;
/**
 交换方法

 @param originalSel 原方法
 @param newSel 新方法
 */
+ (void)vd_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;
- (void)vd_setAssociateValue:(id)value withKey:(void *)key;
- (id)vd_getAssociatedValueForKey:(void *)key;
- (void)vd_removeAssociateWithKey:(void *)key;

// 告诉 数组中都是什么类型的模型对象 需要对应的model去实现
- (NSString *)nameOfObjectClassInArray;
@end
