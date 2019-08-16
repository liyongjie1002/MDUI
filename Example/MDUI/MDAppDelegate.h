//
//  MDAppDelegate.h
//  MDUI
//
//  Created by iyongjie@yeah.net on 07/24/2019.
//  Copyright (c) 2019 iyongjie@yeah.net. All rights reserved.
//

@import UIKit;
#import "MDTabBarController.h"

@interface MDAppDelegate : UIResponder <UIApplicationDelegate, MDTabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@end
