//
//  UIView+WKJBadge.m
//  WKJBadge
//
//  Created by wx on 16/2/17.
//  Copyright © 2016年 KuaiGou. All rights reserved.
//

#import "UIView+WKJBadge.h"
#import <objc/runtime.h>

#define WKJBadge_Tag 1024

@implementation UIView (WKJBadge)

- (void)showDotBadge:(WKJBadgePosition)position
{
    [self showBadgeWithStyle:WKJBadgeStyleRedDot position:position number:0];
}

- (void)showBadgeWithStyle:(WKJBadgeStyle)style position:(WKJBadgePosition)position number:(NSInteger)number
{
    switch (style)
    {
        case WKJBadgeStyleRedDot:
            [self showRedDotBadge:position];
            break;
            
        case WKJBadgeStyleNumber:
            [self showNumberBadgeWithNumber:number position:position];
            break;
    }
}

- (void)showRedDotBadge:(WKJBadgePosition)position
{
    [self setupBadge:position];
    
    self.badge.bounds = CGRectMake(0, 0, WKJBadgeRedDotWidth, WKJBadgeRedDotWidth);
    self.badge.text = @"";
    
    self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame)/2;
    self.badge.layer.masksToBounds = YES;
    self.badge.hidden = NO;
}

- (void)showNumberBadgeWithNumber:(NSInteger)number position:(WKJBadgePosition)position
{
    if (number < 0) {
        number = 0;
    }
    
    [self setupBadge:position];
    
    self.badge.hidden = (number == 0);
        
    self.badge.text = (number > WKJBadgeMaximumBadgeNumber) ? [NSString stringWithFormat:@"%d+",WKJBadgeMaximumBadgeNumber]:[NSString stringWithFormat:@"%ld",(long)number];
    
    [self adjustLabelSize:self.badge];
        
    if (CGRectGetWidth(self.badge.frame) < CGRectGetHeight(self.badge.frame))
    {
        self.badge.bounds = CGRectMake(0, 0, CGRectGetHeight(self.badge.frame), CGRectGetHeight(self.badge.frame));
    }
        
    self.badge.layer.cornerRadius = CGRectGetHeight(self.badge.frame)/2;
    self.badge.layer.masksToBounds = YES;
}

- (void)showOnTabBarWithIndex:(NSInteger)index itemCount:(NSInteger)itemCount
{
    [self setupBadge:WKJBadgePositionTopRight];
    
    CGFloat percentX = (index + 0.6) / itemCount;
    CGFloat x = ceilf(percentX * self.frame.size.width);
    CGFloat y = ceilf(0.1 * self.frame.size.height);
    
    self.badge.frame = CGRectMake(x, y, WKJBadgeRedDotWidth, WKJBadgeRedDotWidth);
}

- (void)clearBadge
{
    if (self.badge) {
        self.badge.hidden = YES;
        [self.badge removeFromSuperview];
    }
}

- (void)setupBadge:(WKJBadgePosition)position
{
    // 初始化属性
    if (self.badgeBackGroundColor == nil)
    {
        self.badgeBackGroundColor = [UIColor redColor];
    }
    
    if (self.badgeFont == nil)
    {
        self.badgeFont = WKJBadgeDefaultFont;
    }
    
    if (self.badgeNumberColor == nil)
    {
        self.badgeNumberColor = [UIColor whiteColor];
    }
    
    self.badge = [self viewWithTag:WKJBadge_Tag];
    if (!self.badge) {
        CGFloat badgeCenterX = CGRectGetWidth(self.frame);
        
        self.badge = [[UILabel alloc] init];
        if (position == WKJBadgePositionTopLeft)
        {
            self.badge.center = CGPointMake(0, 0);
        }
        else
        {
            self.badge.center = CGPointMake(badgeCenterX, 0);
        }
        
        self.badge.bounds = CGRectMake(0, 0, WKJBadgeRedDotWidth, WKJBadgeRedDotWidth);
        
        self.badge.layer.cornerRadius = CGRectGetWidth(self.badge.frame)/2;
        self.badge.layer.masksToBounds = YES;
        
        self.badge.textAlignment = NSTextAlignmentCenter;
        self.badge.textColor = self.badgeNumberColor;
        self.badge.font = self.badgeFont;
        
        self.badge.backgroundColor = self.badgeBackGroundColor;
        self.badge.hidden = NO;
        self.badge.tag = WKJBadge_Tag;
        
        [self addSubview:self.badge];
    }
}

- (void)adjustLabelSize:(UILabel*)label
{
    UIFont *labelFont = label.font;
    NSString *labelText = label.text;
    
    CGSize labelSize = [labelText boundingRectWithSize:CGSizeMake(320, 480)
                                               options:NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:labelFont} context:nil].size;
    CGFloat width = ceilf(labelSize.width)+4;
    CGFloat height = ceilf(labelSize.height)+4;
    
    label.bounds = CGRectMake(0, 0, width, height);
}

#pragma mark property's Getter/Setter
/*
 * 由于category只能添加方法，如果添加属性则需要动态添加（runtime中objc_class结构体中属性是可以动态添加的），利用runtime的两个方法进行添加。
 */
- (UILabel*)badge
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBadge:(UILabel *)badge
{
    objc_setAssociatedObject(self, @selector(badge), badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont*)badgeFont
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBadgeFont:(UIFont *)badgeFont
{
    objc_setAssociatedObject(self, @selector(badgeFont), badgeFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badge.font = self.badgeFont;
}

- (UIColor*)badgeNumberColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBadgeNumberColor:(UIColor *)badgeNumberColor
{
    objc_setAssociatedObject(self, @selector(badgeNumberColor), badgeNumberColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badge.textColor = self.badgeNumberColor;
}

- (UIColor*)badgeBackGroundColor
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBadgeBackGroundColor:(UIColor *)badgeBackGroundColor
{
    objc_setAssociatedObject(self, @selector(badgeBackGroundColor), badgeBackGroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.badge.backgroundColor = self.badgeBackGroundColor;
}

@end
