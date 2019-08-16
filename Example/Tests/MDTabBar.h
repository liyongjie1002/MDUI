//
//  MDTabBar.h
//  MDUI_Example
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDTabBarItem.h"
@class MDTabBar;

@protocol MDTabBarDelegate <NSObject>

// 不规则tab点击事件
- (void)tabBarDidSelectedRiseButton;

- (BOOL)tabBar:(MDTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index;

- (void)tabBar:(MDTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index;

@end

@interface MDTabBar : UIView

@property (nonatomic, weak) id <MDTabBarDelegate>           delegate;
@property (nonatomic, copy) NSArray                         *items;
@property (nonatomic, strong) MDTabBarItem                  *selectedItem;
@property UIEdgeInsets                                      contentEdgeInsets;

/**
 * tabBar高度
 */
- (void)setHeight:(CGFloat)height;

/**
 * tabbar最小高度
 */
- (CGFloat)mininumContentHeight;

@end

