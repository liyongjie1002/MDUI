//
//  MDTabOneViewController.m
//  MDUI_Example
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabOneViewController.h"
#import "MDTabBarController.h"
@interface MDTabOneViewController ()

@end

@implementation MDTabOneViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"星星";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"星星";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.md_tabBarItem setBadgeValue:@"999"];
}

@end
