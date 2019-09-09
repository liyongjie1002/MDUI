//
//  MDNavigationController.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/9/9.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDNavigationController.h"

@implementation MDNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // Hijack the push method to disable the gesture
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (self.viewControllers.count > 0) {
        // 1.只有栈中有控制器的情况才需要隐藏工具条
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 第一次(根控制器)不需要隐藏工具条
    [super pushViewController:viewController animated:animated];
}
@end
