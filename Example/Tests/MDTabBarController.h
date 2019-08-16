//
//  MDTabBarController.h
//  MDUI_Example
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDTabBar.h"
@class MDTabBarController;

@protocol MDTabBarControllerDelegate <NSObject>

@optional

- (BOOL)tabBarController:(MDTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

- (void)tabBarController:(MDTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;

- (void)tabBarController:(MDTabBarController *)tabBarController didSelectItemAtIndex:(NSInteger)index;

- (void)tabBarControllerSelectedRiseButton;

@end

@interface MDTabBarController : UIViewController <MDTabBarDelegate>

@property (nonatomic, weak) id<MDTabBarControllerDelegate>              delegate;
@property (nonatomic, copy) NSArray                                     *viewControllers;
@property (nonatomic, strong) MDTabBar                                  *tabBar;
@property (nonatomic, strong) UIViewController                          *selectedViewController;
@property (nonatomic, assign) NSUInteger                                selectedIndex;
@property (nonatomic, getter = isTabBarHidden) BOOL                     tabBarHidden;
@property (nonatomic, strong) UIView                                    *contentView;

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end


@interface UIViewController (MDTabBarControllerItem)

@property(nonatomic, setter = md_setTabBarItem:) MDTabBarItem           *md_tabBarItem;
@property(nonatomic, readonly) MDTabBarController                       *md_tabBarController;

@end
