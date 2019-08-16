//
//  MDTabFiveViewController.m
//  MDUI_Example
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabFiveViewController.h"
#import "MDTabOneViewController.h"
#import "MDTabTwoViewController.h"
#import "MDTabThreeViewController.h"
#import "MDTabFourViewController.h"
#import "MDTabBarController.h"

@interface MDTabFiveViewController ()<MDTabBarControllerDelegate>

@end

@implementation MDTabFiveViewController
- (instancetype)init {
    self = [super init];
    if (self) {
//        self.title = @"天马";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViewControllers];

}

- (void)setupViewControllers {
    
    MDTabOneViewController *firstViewController = [[MDTabOneViewController alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:firstViewController];
    
    MDTabTwoViewController *secondViewController = [[MDTabTwoViewController alloc] init];
    UINavigationController *secondNavigationController = [[UINavigationController alloc]
                                                          initWithRootViewController:secondViewController];
    
    MDTabThreeViewController *thirdViewController = [[MDTabThreeViewController alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc]
                                                         initWithRootViewController:thirdViewController];
    
    MDTabFourViewController *fourViewController = [[MDTabFourViewController alloc] init];
    UINavigationController *fourNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:fourViewController];
    
    MDTabFourViewController *fiveViewController = [[MDTabFourViewController alloc] init];
    UINavigationController *fiveNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:fiveViewController];
    
    
    MDTabBarController *tabBarController = [[MDTabBarController alloc] init];
    tabBarController.delegate = self;
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController,
                                           thirdNavigationController, fourNavigationController, fiveNavigationController]];
    
    [self mainWindow].rootViewController = tabBarController;
    [self customizeTabBarForController:tabBarController];
}

//获取当前window
- (UIWindow *)mainWindow {
    
    UIApplication *app = [UIApplication sharedApplication];
    if ([app.delegate respondsToSelector:@selector(window)])
    {
        return [app.delegate window];
    }
    else
    {
        return [app keyWindow];
    }
}

- (void)customizeTabBarForController:(MDTabBarController *)tabBarController {
    
    NSArray *tabBarItemImages = @[@"first", @"post", @"second", @"second", @"first"];
    NSInteger index = 0;
    for (MDTabBarItem *item in tabBarController.tabBar.items) {
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        index++;
    }
}



@end
