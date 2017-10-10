//
//  UIView+WKJBadge.h
//  WKJBadge
//
//  Created by wx on 16/2/17.
//  Copyright © 2016年 KuaiGou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define WKJBadgeMaximumBadgeNumber    99
#define WKJBadgeRedDotWidth           10
#define WKJBadgeDefaultFont		      [UIFont boldSystemFontOfSize:11]

typedef NS_ENUM(NSUInteger, WKJBadgeStyle)
{
    WKJBadgeStyleRedDot = 0,      // 单个红点
    WKJBadgeStyleNumber           // 带数字标识
};

typedef NS_ENUM(NSUInteger, WKJBadgePosition)
{
    WKJBadgePositionTopLeft = 0,
    WKJBadgePositionTopRight
};

@interface UIView (WKJBadge)

//  标识实体
@property (strong, nonatomic) UILabel *badge;

//  标识内部数字字体 默认是 [UIFont boldSystemFontOfSize:9]
@property (strong, nonatomic) UIFont *badgeFont;

//  标识内部数字颜色 默认是白色
@property (strong, nonatomic) UIColor *badgeNumberColor;

//  标识背景色 默认红色
@property (strong, nonatomic) UIColor *badgeBackGroundColor;



/*
 *   直接显示默认badge，单个红点类型
 */
- (void)showDotBadge:(WKJBadgePosition)position;

/*
 *   自选类型badge
 *   如果选择WKJBadgeStyleRedDot类型，则忽略number的值
 *   如果number的值为0，则自动隐藏badge
 */
- (void)showBadgeWithStyle:(WKJBadgeStyle)style position:(WKJBadgePosition)position number:(NSInteger)number;


/**
 显示在tabbar上

 @param index 第几个item
 @param itemCount 一共多少个item
 */
- (void)showOnTabBarWithIndex:(NSInteger)index itemCount:(NSInteger)itemCount;

/*
 *   清除badge
 */
- (void)clearBadge;

@end
