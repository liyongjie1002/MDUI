//
//  mdTabBarController.m
//  MDUI_Example
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabBarController.h"
#import <objc/runtime.h>
#import "MDTabBarItem.h"

@interface UIViewController (MDTabBarControllerItemInternal)

- (void)md_setTabBarController:(MDTabBarController *)tabBarController;

@end

@implementation MDTabBarController

#pragma mark - LifeCircle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.tabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setSelectedIndex:self.selectedIndex];
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    CGSize viewSize = self.view.bounds.size;
    CGFloat tabBarStartingY = viewSize.height;
    CGFloat contentViewHeight = viewSize.height;
    CGFloat tabBarHeight = CGRectGetHeight(self.tabBar.frame);
    
    if (!tabBarHeight) {
        if (@available(iOS 11.0, *)) {
            CGFloat safeAreaBottom = UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
            tabBarHeight = 58.f + safeAreaBottom / 1.5f;
        } else {
            tabBarHeight = 58.f;
        }
    } else if (@available(iOS 11.0, *)) {
        CGFloat safeAreaBottom = UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
        tabBarHeight = 58.f + safeAreaBottom / 1.5f;
    }
    
    if (!self.tabBarHidden) {
        tabBarStartingY = viewSize.height - tabBarHeight;
        contentViewHeight -= ([self.tabBar mininumContentHeight] ?: tabBarHeight);
    }
    
    [self.tabBar setFrame:CGRectMake(0, tabBarStartingY, viewSize.width, tabBarHeight)];
    [self.contentView setFrame:CGRectMake(0, 0, viewSize.width, contentViewHeight)];
    [self.selectedViewController.view setFrame:self.contentView.bounds];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return self.selectedViewController.preferredStatusBarStyle;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return self.selectedViewController.preferredStatusBarUpdateAnimation;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    UIInterfaceOrientationMask orientationMask = UIInterfaceOrientationMaskAll;
    for (UIViewController *viewController in [self viewControllers]) {
        
        if (![viewController respondsToSelector:@selector(supportedInterfaceOrientations)]) {
            return UIInterfaceOrientationMaskPortrait;
        }
        UIInterfaceOrientationMask supportedOrientations = [viewController supportedInterfaceOrientations];
        if (orientationMask > supportedOrientations) {
            orientationMask = supportedOrientations;
        }
    }
    return orientationMask;
}

#pragma mark - PrivateMethods
- (UIViewController *)selectedViewController {
    
    return [self.viewControllers objectAtIndex:self.selectedIndex];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    if (selectedIndex >= self.viewControllers.count) {
        return;
    }
    if (self.selectedViewController) {
        [self.selectedViewController willMoveToParentViewController:nil];
        [self.selectedViewController.view removeFromSuperview];
        [self.selectedViewController removeFromParentViewController];
    }
    
    _selectedIndex = selectedIndex;
    [self.tabBar setSelectedItem:self.tabBar.items[selectedIndex]];
    [self setSelectedViewController:[self.viewControllers objectAtIndex:selectedIndex]];
    [self addChildViewController:self.selectedViewController];
    [self.selectedViewController.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.contentView addSubview:self.selectedViewController.view];
    [self.selectedViewController didMoveToParentViewController:self];
    
    [self.view setNeedsLayout];
    [self setNeedsStatusBarAppearanceUpdate];
}

- (void)setViewControllers:(NSArray *)viewControllers {
    
    if (_viewControllers && _viewControllers.count) {
        for (UIViewController *viewController in self.viewControllers) {
            
            [viewController willMoveToParentViewController:nil];
            [viewController.view removeFromSuperview];
            [viewController removeFromParentViewController];
        }
    }
    
    if (viewControllers && [viewControllers isKindOfClass:[NSArray class]]) {
        
        _viewControllers = [viewControllers copy];
        NSMutableArray *tabBarItems = [[NSMutableArray alloc] init];
        
        for (UIViewController *viewController in viewControllers) {
            MDTabBarItem *tabBarItem = [[MDTabBarItem alloc] init];
            [tabBarItem setTitle:viewController.title];
            [tabBarItems addObject:tabBarItem];
            [viewController md_setTabBarController:self];
        }
        [self.tabBar setItems:tabBarItems];
        
    } else {
        
        for (UIViewController *viewController in _viewControllers) {
            [viewController md_setTabBarController:nil];
        }
        _viewControllers = nil;
    }
}

- (NSInteger)indexForViewController:(UIViewController *)viewController {
    
    UIViewController *searchedController = viewController;
    if (searchedController.parentViewController != nil && searchedController.parentViewController != self) {
        searchedController = searchedController.parentViewController;
    }
    return [self.viewControllers indexOfObject:searchedController];
}

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {

    [self.view layoutIfNeeded];
    _tabBarHidden = hidden;
    [self.view setNeedsLayout];
    
    if (!_tabBarHidden) {
        [self.tabBar setHidden:NO];
    }
    [UIView animateWithDuration:(animated ? 0.24 : 0) animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished){
        if (self.tabBarHidden) {
            [self.tabBar setHidden:YES];
        }
    }];
}

- (void)setTabBarHidden:(BOOL)hidden {
    
    [self setTabBarHidden:hidden animated:NO];
}

#pragma mark - MDTabBarDelegate
- (BOOL)tabBar:(MDTabBar *)tabBar shouldSelectItemAtIndex:(NSInteger)index {
    
    if ([self.delegate respondsToSelector:@selector(tabBarController:shouldSelectViewController:)]) {
        if (![self.delegate tabBarController:self shouldSelectViewController:self.viewControllers[index]]) {
            return NO;
        }
    }
    
    if (self.selectedViewController == self.viewControllers[index]) {
        if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectItemAtIndex:)]) {
            [self.delegate tabBarController:self didSelectItemAtIndex:index];
        }
        
        if ([self.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *selectedController = (UINavigationController *)self.selectedViewController;
            if (selectedController.topViewController != selectedController.viewControllers[0]) {
                [selectedController popToRootViewControllerAnimated:YES];
            }
        }
        return NO;
    }
    return YES;
}

- (void)tabBar:(MDTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    
    if (index < 0 || index >= self.viewControllers.count) {
        return;
    }
    [self setSelectedIndex:index];
    if ([self.delegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [self.delegate tabBarController:self didSelectViewController:self.viewControllers[index]];
    }
}

// 凸起按钮点击事件
- (void)tabBarDidSelectedRiseButton {
    
    if ([self.delegate respondsToSelector:@selector(tabBarControllerSelectedRiseButton)]) {
        [self.delegate tabBarControllerSelectedRiseButton];
    }
}

#pragma mark - Properties
- (MDTabBar *)tabBar {
    
    if (!_tabBar) {
        _tabBar = [[MDTabBar alloc] init];
        _tabBar.backgroundColor = [UIColor clearColor];
        [_tabBar setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                      UIViewAutoresizingFlexibleTopMargin|
                                      UIViewAutoresizingFlexibleLeftMargin|
                                      UIViewAutoresizingFlexibleRightMargin|
                                      UIViewAutoresizingFlexibleBottomMargin)];
        _tabBar.delegate = self;
    }
    return _tabBar;
}

- (UIView *)contentView {
    
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView setAutoresizingMask:(UIViewAutoresizingFlexibleWidth|
                                           UIViewAutoresizingFlexibleHeight)];
    }
    return _contentView;
}

@end

#pragma mark - UIViewController+MDTabBarControllerItem
@implementation UIViewController (MDTabBarControllerItemInternal)

- (void)md_setTabBarController:(MDTabBarController *)tabBarController {
    
    objc_setAssociatedObject(self, @selector(md_tabBarController), tabBarController, OBJC_ASSOCIATION_ASSIGN);
}

@end


@implementation UIViewController (MDTabBarControllerItem)

- (MDTabBarController *)md_tabBarController {
    
    MDTabBarController *tabBarController = objc_getAssociatedObject(self, @selector(md_tabBarController));
    if (!tabBarController && self.parentViewController) {
        tabBarController = [self.parentViewController md_tabBarController];
    }
    return tabBarController;
}

- (MDTabBarItem *)md_tabBarItem {
    
    NSInteger index = [self.md_tabBarController indexForViewController:self];
    return [self.md_tabBarController.tabBar.items objectAtIndex:index];
}

- (void)md_setTabBarItem:(MDTabBarItem *)tabBarItem {
    
    if (!self.md_tabBarController) {
        return;
    }
    NSInteger index = [self.md_tabBarController indexForViewController:self];
    NSMutableArray *tabBarItems = [[NSMutableArray alloc] initWithArray:self.md_tabBarController.tabBar.items];
    [tabBarItems replaceObjectAtIndex:index withObject:tabBarItem];
    [self.md_tabBarController.tabBar setItems:tabBarItems];
}

@end
