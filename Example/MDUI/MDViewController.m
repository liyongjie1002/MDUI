//
//  MDViewController.m
//  MDUI
//
//  Created by iyongjie@yeah.net on 07/24/2019.
//  Copyright (c) 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDViewController.h"
#import "MDSearchDemoViewController.h"

@interface MDViewController ()

@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击了" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(100, 100, 100, 30)];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)clickAction {
    MDSearchDemoViewController *vc = [[MDSearchDemoViewController alloc]init];

    [self.navigationController pushViewController:vc animated:YES];
}

@end
