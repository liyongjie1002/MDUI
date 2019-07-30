//
//  MDViewController.m
//  MDUI
//
//  Created by iyongjie@yeah.net on 07/24/2019.
//  Copyright (c) 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDViewController.h"

#import "MDToast.h"

#import "MDSearchDemoViewController.h"


@interface MDViewController ()

@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

//    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(200, 20, 100, 100);
    but.backgroundColor = [UIColor cyanColor];
    [but addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UITextField *aa = [[UITextField alloc]initWithFrame:CGRectMake(200, 200, 100, 100)];
    [self.view addSubview:aa];
    

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
- (void)aaa {
    
//    [MDToast showToast:@"实你查查城市快速吃每次老开车的老成都零零落落施啊啊啊"];
//    [MDToast showToast:@"ssssssss" position:MDToastPositionBottom];
//    [MDToast showToast:@"大家看崇山峻岭看撒接口可促进出口了" pattern:MDToastPatternNight position:MDToastPositionCenter];
    
    MDToastStyle *style = [[MDToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont fontWithName:@"Zapfino" size:8.0];
    style.messageColor = [UIColor redColor];
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [UIColor yellowColor];
    [MDToast makeToast:@"实你查查城市快速吃每次老" title:@"会飞的房子" image:[UIImage imageNamed:@"ssss.png"] pattern:MDToastPatternNight duration:3 position:MDToastPositionCenter style:nil];

}


@end
