//
//  MDAppDelegate.m
//  MDUI
//
//  Created by iyongjie@yeah.net on 07/24/2019.
//  Copyright (c) 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDTabOneViewController.h"
#import "MDTabThreeViewController.h"
#import "MDTabFiveViewController.h"

@implementation MDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self setupViewControllers];
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    [self customizeInterface];
    
    
    return YES;
}

#pragma mark - Methods
- (void)setupViewControllers {
    MDTabOneViewController *firstViewController = [[MDTabOneViewController alloc] init];
    UINavigationController *firstNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    MDTabThreeViewController *thirdViewController = [[MDTabThreeViewController alloc] init];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    

    MDTabFiveViewController *fiveViewController = [[MDTabFiveViewController alloc] init];
    UINavigationController *fiveNavigationController = [[UINavigationController alloc]
                                                        initWithRootViewController:fiveViewController];
    
    MDTabBarController *tabBarController = [[MDTabBarController alloc] init];
    tabBarController.delegate = self;
    [tabBarController setViewControllers:@[firstNavigationController,
                                           thirdNavigationController, fiveNavigationController]];

    self.viewController = tabBarController;
    [self drawTabBarForController:tabBarController];
}

- (void)drawTabBarForController:(MDTabBarController *)tabBarController {

    NSArray *tabBarItemImages = @[@"first", @"second", @"first"];
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

- (void)tabBarControllerSelectedRiseButton {
    
    UIAlertView *aller = [[UIAlertView alloc]initWithTitle:@"aaa" message:@"vvv" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", nil];
    [aller show];
}

- (void)customizeInterface {
    
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
    textAttributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                       NSForegroundColorAttributeName: [UIColor blackColor],
                       };
    [navigationBarAppearance setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
