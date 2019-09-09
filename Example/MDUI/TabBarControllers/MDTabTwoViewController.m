//
//  MDTabTwoViewController.m
//  MDUI_Example
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabTwoViewController.h"
#import "MDTabBarController.h"
@interface MDTabTwoViewController ()

@end

@implementation MDTabTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"云朵";
    self.view.backgroundColor = [UIColor yellowColor];
    self.md_tabBarItem.badgeValue = @"1";
}

@end
