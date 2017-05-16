//
//  CALayer+Category.m
//  VarietyDelivery
//
//  Created by zsy on 2017/2/24.
//  Copyright © 2017年 zsy. All rights reserved.
//

#import "CALayer+Category.h"

static void *const _VDMaskCornerRadiusLayerKey = "_VDMaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;
@implementation CALayer (Category)
+ (void)load{
    [CALayer vd_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_vd_layoutSublayers)];
}

- (UIImage *)contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage{
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self vd_roundedCornerWithRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)vd_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self vd_roundedCornerWithCornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)vd_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    if (!color) return;
    CALayer *cornerRadiusLayer = [self vd_getAssociatedValueForKey:_VDMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self vd_setAssociateValue:cornerRadiusLayer withKey:_VDMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer vd_setAssociateValue:color withKey:"_vd_cornerRadiusImageColor"];
    }else{
        [cornerRadiusLayer vd_removeAssociateWithKey:"_vd_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer vd_setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_vd_cornerRadiusImageRadius"];
    [cornerRadiusLayer vd_setAssociateValue:@(corners) withKey:"_vd_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer vd_setAssociateValue:borderColor withKey:"_vd_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer vd_removeAssociateWithKey:"_vd_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer vd_setAssociateValue:@(borderWidth) withKey:"_vd_cornerRadiusImageBorderWidth"];
    UIImage *image = [self _vd_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
    
}

- (UIImage *)_vd_getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self vd_getAssociatedValueForKey:_VDMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer vd_getAssociatedValueForKey:"_vd_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer vd_getAssociatedValueForKey:"_vd_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer vd_getAssociatedValueForKey:"_vd_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer vd_getAssociatedValueForKey:"_vd_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer vd_getAssociatedValueForKey:"_vd_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj vd_getAssociatedValueForKey:"_vd_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj vd_getAssociatedValueForKey:"_vd_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj vd_getAssociatedValueForKey:"_vd_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj vd_getAssociatedValueForKey:"_vd_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj vd_getAssociatedValueForKey:"_vd_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj vd_getAssociatedValueForKey:"_vd_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage vd_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image vd_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_vd_cornerRadiusImageSize"];
        [image vd_setAssociateValue:color withKey:"_vd_cornerRadiusImageColor"];
        [image vd_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_vd_cornerRadiusImageRadius"];
        [image vd_setAssociateValue:@(corners) withKey:"_vd_cornerRadiusImageCorners"];
        if (borderColor) {
            [image vd_setAssociateValue:color withKey:"_vd_cornerRadiusImageBorderColor"];
        }
        [image vd_setAssociateValue:@(borderWidth) withKey:"_vd_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)_vd_layoutSublayers{
    [self _vd_layoutSublayers];
    CALayer *cornerRadiusLayer = [self vd_getAssociatedValueForKey:_VDMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self _vd_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end
