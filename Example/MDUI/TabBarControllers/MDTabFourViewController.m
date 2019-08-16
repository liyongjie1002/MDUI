//
//  MDTabFourViewController.m
//  MDUI_Example
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabFourViewController.h"
#import "MDTabBarController.h"

@interface MDTabFourViewController ()

@end

@implementation MDTabFourViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"月亮";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.md_tabBarItem setDefaultBadge];
}


@end
