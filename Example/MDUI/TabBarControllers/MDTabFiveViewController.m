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

#import "MDViewController.h"

@interface MDTabFiveViewController ()<MDTabBarControllerDelegate>

@end

@implementation MDTabFiveViewController
- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"天马";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor purpleColor];
    [self.md_tabBarItem setBadgeValue:@"171"];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击了" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 100, 30)];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)clickAction {
    MDViewController *mdVC = [MDViewController new];
    [self.navigationController pushViewController:mdVC animated:YES];
}


@end
