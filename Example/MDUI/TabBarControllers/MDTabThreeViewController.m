//
//  MDTabThreeViewController.m
//  MDUI_Example
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabThreeViewController.h"
#import "MDTabBarController.h"

@interface MDTabThreeViewController ()

@end

@implementation MDTabThreeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"天马行空";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
