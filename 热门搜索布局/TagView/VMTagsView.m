//
//  VMTagsView.m
//  VarietyMarket
//
//  Created by zsy on 16/7/13.
//  Copyright © 2016年 dangdailife. All rights reserved.
//

#import "VMTagsView.h"
#import "Header.h"
#import "NSString+Category.h"
#import "NSObject+Category.h"
static void *const _VDTagsViewSetTitleArrayKey = "_VDTagsViewSetTitleArrayKey";
@interface VMTagsView()
/**
 *  存放创建的button 用于取下标或者找对应的button 也可以用tag
 */
@property (nonatomic, strong) NSMutableArray *buttonArr;

@property (nonatomic, strong) UIButton *tempButton;

@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) NSMutableArray *frameArr;
@end
@implementation VMTagsView
- (NSMutableArray *)buttonArr {
    if (!_buttonArr) {
        _buttonArr = [[NSMutableArray alloc] init];
    }
    return _buttonArr;
}
- (NSMutableArray *)frameArr {
    if (!_frameArr) {
        _frameArr = [NSMutableArray arrayWithCapacity:1];
    }
    return _frameArr;
}
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray {
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubviewsWithWidth:frame.size.width titleArray:titleArray];
    }
    return self;
}


+ (CGFloat)tagsViewHeightForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth{
    if (titleArray.count == 0) {
        return 0;
    }
    CGFloat nowWidth = 0;
    CGFloat nextWidth = 0;
    int num_per_line = 0;//每行btn的个数
    int num_of_line = 0;//行数
    for (int i = 0; i < titleArray.count; i ++) {
        NSString *title = titleArray[i];
        CGFloat titleWidth = [title widthForFontSize:kCommenFont];
        titleWidth += (kButtonTitleInset * 2);
        nextWidth = nextWidth + titleWidth + 10;
        if (nextWidth > allWidth) {
            nextWidth = 0;
            nextWidth = nextWidth + titleWidth;
            num_of_line ++;
            nowWidth = 0;
            nowWidth = nowWidth + titleWidth;
            num_per_line = 0;
        }else {
            nowWidth = nowWidth + titleWidth;
        }
        num_per_line ++;
    }
    CGFloat allheight = (kButtonHeight + 10) * (num_of_line + 1);
    return allheight;
}

- (CGFloat)creatSubviewsWithWidth:(CGFloat)allWidth titleArray:(NSArray *)titleArray{
    CGFloat x = 0;
    CGFloat nowWidth = 0;
    CGFloat nextWidth = 0;
    int num_per_line = 0;//每行btn的个数
    int num_of_line = 0;//行数
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //添加到数组内
        [self.buttonArr addObject:button];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:kMainTextGrayColor forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.titleLabel.font = Font(kCommenFont);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [self addSubview:button];
        
        NSString *title = titleArray[i];
        CGFloat titleWidth = [title widthForFontSize:kCommenFont];
        titleWidth += (kButtonTitleInset * 2);//给按钮标题距离左右边框留点间距
        nextWidth = nextWidth + titleWidth + 10;//将要布局下一个按钮的宽度
        if (nextWidth > allWidth) {
            //如果大于限定的宽度 置0 另起一行
            nextWidth = 0;
            nextWidth = nextWidth + titleWidth;
            num_of_line ++;
            nowWidth = 0;
            nowWidth = nowWidth + titleWidth;
            num_per_line = 0;
            button.frame = CGRectMake(x, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
        }else {
            button.frame = CGRectMake(x + nowWidth + num_per_line * 10, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
            nowWidth = nowWidth + titleWidth;
        }
        [button cutCornerRadiusWithRadius:kButtonHeight / 2 bordercolor:KColorFromRGB(0xE1E1E1) borderwidth:1];
        num_per_line ++;
    }
    
    return (kButtonHeight + 10) * (num_of_line + 1);
}
+ (NSDictionary *)tagsViewForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth {
    VMTagsView *tagsview = [[self alloc] init];
    CGFloat height = [tagsview creatSubviewsWithWidth:allWidth titleArray:titleArray];
    return @{@"height":@(height),@"tagsview":tagsview};
}
//==========================================================================
+ (NSDictionary *)tagsViewWithIconForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth defaultSelectedButton:(NSInteger)index {
    VMTagsView *tagsview = [[self alloc] init];
    CGFloat height = [tagsview creatSubviewsWithWidth:allWidth titleArray:titleArray defaultSelectedButton:index];
    return @{@"height":@(height),@"tagsview":tagsview};
}
- (CGFloat)creatSubviewsWithWidth:(CGFloat)allWidth titleArray:(NSArray *)titleArray defaultSelectedButton:(NSInteger)index {
    CGFloat x = 0;
    CGFloat nowWidth = 0;
    CGFloat nextWidth = 0;
    int num_per_line = 0;//每行btn的个数
    int num_of_line = 0;//行数
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //添加到数组内
        [self.buttonArr addObject:button];
        
        [button addTarget:self action:@selector(iconButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:kMainTextGrayColor forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        button.layer.borderColor = KColorFromRGB(0xE1E1E1).CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = Font(kCommenFont);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [self addSubview:button];
        
        
        NSString *title = titleArray[i];
        CGFloat titleWidth = [title widthForFontSize:kCommenFont];
        titleWidth += (kButtonTitleInset * 2);//给按钮标题距离左右边框留点间距
        nextWidth = nextWidth + titleWidth + 10;//将要布局下一个按钮的宽度
        if (nextWidth > allWidth) {
            //如果大于限定的宽度 置0 另起一行
            nextWidth = 0;
            nextWidth = nextWidth + titleWidth;
            num_of_line ++;
            nowWidth = 0;
            nowWidth = nowWidth + titleWidth;
            num_per_line = 0;
            button.frame = CGRectMake(x, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
        }else {
            button.frame = CGRectMake(x + nowWidth + num_per_line * 10, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
            nowWidth = nowWidth + titleWidth;
        }
        num_per_line ++;
        
        CGFloat iconX = button.bounds.size.width - 15;
        UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, kButtonHeight - 15, 15, 15)];
        icon.image = [UIImage imageNamed:@"productdetail_checked"];
        icon.hidden = YES;
        icon.tag = 300 + i;
        [button addSubview:icon];
        
        if (i == index) {
            self.tempButton = button;
            [button setTitleColor:kMainColor forState:UIControlStateNormal];
            button.layer.borderColor = kMainColor.CGColor;
            icon.hidden = NO;
        }
    }
    return (kButtonHeight + 10) * (num_of_line + 1);
}
//============================================================================
+ (NSDictionary *)tagsViewWithChangeBGColorForTitleArray:(NSArray *)titleArray andWidth:(CGFloat)allWidth normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor {
    
    VMTagsView *tagsview = [[self alloc] init];
    tagsview.normalColor = normalColor;
    tagsview.selectedColor = selectedColor;
    CGFloat height = [tagsview creatSubviewsWithWidth:allWidth titleArray:titleArray normalColor:normalColor];
    return @{@"height":@(height),@"tagsview":tagsview};
}
- (CGFloat)creatSubviewsWithWidth:(CGFloat)allWidth titleArray:(NSArray *)titleArray normalColor:(UIColor *)normalColor{
    CGFloat x = 0;
    CGFloat nowWidth = 0;
    CGFloat nextWidth = 0;
    int num_per_line = 0;//每行btn的个数
    int num_of_line = 0;//行数
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //添加到数组内
        [self.buttonArr addObject:button];
        
        [button addTarget:self action:@selector(bgColorButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:kMainTextGrayColor forState:UIControlStateNormal];
        [button setBackgroundColor:normalColor];
        button.layer.borderColor = KColorFromRGB(0xE1E1E1).CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = kButtonHeight / 2;
        button.layer.masksToBounds = YES;
        button.titleLabel.font = Font(kCommenFont);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [self addSubview:button];
        
        NSString *title = titleArray[i];
        CGFloat titleWidth = [title widthForFontSize:kCommenFont];
        titleWidth += (kButtonTitleInset * 2);//给按钮标题距离左右边框留点间距
        nextWidth = nextWidth + titleWidth + 10;//将要布局下一个按钮的宽度
        if (nextWidth > allWidth) {
            //如果大于限定的宽度 置0 另起一行
            nextWidth = 0;
            nextWidth = nextWidth + titleWidth;
            num_of_line ++;
            nowWidth = 0;
            nowWidth = nowWidth + titleWidth;
            num_per_line = 0;
            button.frame = CGRectMake(x, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
        }else {
            button.frame = CGRectMake(x + nowWidth + num_per_line * 10, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
            nowWidth = nowWidth + titleWidth;
        }
        num_per_line ++;
    }
    return (kButtonHeight + 10) * (num_of_line + 1);
}
#pragma mark - action
/**
 *  点击事件
 *
 *  @param button
 */
- (void)buttonAction:(UIButton *)button {
    NSInteger index = [self.buttonArr indexOfObject:button];
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(index);
    }
}
- (void)iconButtonAction:(UIButton *)button {
    if (button == self.tempButton) {
        return;
    }
    NSInteger lastIndex = [self.buttonArr indexOfObject:self.tempButton];
    
    UIImageView *lastIcon = [self.tempButton viewWithTag:300 + lastIndex];
    lastIcon.hidden = YES;
    
    NSInteger index = [self.buttonArr indexOfObject:button];
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(index);
    }

    UIImageView *icon = [button viewWithTag:300 + index];
    icon.hidden = NO;
    
    [self.tempButton setTitleColor:kMainTextGrayColor forState:UIControlStateNormal];
    self.tempButton.layer.borderColor = KColorFromRGB(0xE1E1E1).CGColor;
    
    self.tempButton = button;
    [button setTitleColor:kMainColor forState:UIControlStateNormal];
    button.layer.borderColor = kMainColor.CGColor;
}
- (void)bgColorButtonAction:(UIButton *)button {
    [self.tempButton setTitleColor:kMainTextGrayColor forState:UIControlStateNormal];
    self.tempButton.layer.borderColor = KColorFromRGB(0xE1E1E1).CGColor;
    [self.tempButton setBackgroundColor:self.normalColor];
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:self.selectedColor];
    button.layer.borderColor = self.selectedColor.CGColor;
    
    NSInteger index = [self.buttonArr indexOfObject:button];
    if (self.buttonClickedBlock) {
        self.buttonClickedBlock(index);
    }
    self.tempButton = button;
}
/**************************************/
+ (void)tagsViewWithTitleArray:(NSArray *)titleArray titleColor:(UIColor *)titleColor borderColor:(UIColor *)borderColor superView:(UIView *)superView andWidth:(CGFloat)allWidth complete:(CreatTagsviewComplete)complete {
    VMTagsView *tagsView = [[self alloc] init];
    [superView vd_setAssociateValue:titleArray withKey:_VDTagsViewSetTitleArrayKey];
    [tagsView vd_setAssociateValue:titleArray withKey:_VDTagsViewSetTitleArrayKey];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        CGFloat height = [tagsView async_creatSubviewsWithWidth:allWidth titleArray:titleArray titleColor:titleColor borderColor:borderColor];
        id value1 = [superView vd_getAssociatedValueForKey:_VDTagsViewSetTitleArrayKey];
        id value2 = [tagsView vd_getAssociatedValueForKey:_VDTagsViewSetTitleArrayKey];
        if (value1 == value2) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (int i = 0; i < titleArray.count; i++) {
                    NSValue *value = tagsView.frameArr[i];
                    CGRect frame = value.CGRectValue;
                    UILabel *label = tagsView.buttonArr[i];
                    label.frame = frame;
                    [label cutCornerRadiusWithRadius:kButtonHeight / 2  bordercolor:borderColor borderwidth:1];
                    [tagsView addSubview:label];
                }
                if (complete) {
                    complete(tagsView,height);
                }
            });
        }
    });
}
- (CGFloat)async_creatSubviewsWithWidth:(CGFloat)allWidth titleArray:(NSArray *)titleArray titleColor:(UIColor *)titleColor borderColor:(UIColor *)borderColor {
    CGFloat x = 0;
    CGFloat nowWidth = 0;
    CGFloat nextWidth = 0;
    int num_per_line = 0;//每行btn的个数
    int num_of_line = 0;//行数
    for (int i = 0; i < titleArray.count; i ++) {
        
        NSString *title = titleArray[i];
        UILabel *label = [UILabel new];
        label.textColor = titleColor;
        label.font = [UIFont systemFontOfSize:kCommenFont];
        label.text = title;
        label.textAlignment = NSTextAlignmentCenter;
        [self.buttonArr addObject:label];
        
        CGFloat titleWidth = [title widthForFontSize:kCommenFont];
        titleWidth += (kButtonTitleInset * 2);//给按钮标题距离左右边框留点间距
        nextWidth = nextWidth + titleWidth + 10;//将要布局下一个按钮的宽度
        if (nextWidth > allWidth) {
            //如果大于限定的宽度 置0 另起一行
            nextWidth = 0;
            nextWidth = nextWidth + titleWidth;
            num_of_line ++;
            nowWidth = 0;
            nowWidth = nowWidth + titleWidth;
            num_per_line = 0;
            CGRect frame = CGRectMake(x, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
            [self.frameArr addObject:[NSValue valueWithCGRect:frame]];
        }else {
            CGRect frame = CGRectMake(x + nowWidth + num_per_line * 10, 5 + (kButtonHeight + 10) * num_of_line, titleWidth, kButtonHeight);
            [self.frameArr addObject:[NSValue valueWithCGRect:frame]];
            nowWidth = nowWidth + titleWidth;
        }
        num_per_line ++;
    }
    
    return (kButtonHeight + 10) * (num_of_line + 1);
}
@end
