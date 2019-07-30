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

    UIImageView *ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aaaaa.jpg"]];
    ima.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:ima];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeSystem];
    but1.frame = CGRectMake(200, 20, 100, 30);
    but1.backgroundColor = [UIColor orangeColor];
    [but1 addTarget:self action:@selector(bbb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(200, 50, 100, 30);
    but.backgroundColor = [UIColor cyanColor];
    [but addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];

    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeSystem];
    but2.frame = CGRectMake(80, 20, 100, 30);
    but2.backgroundColor = [UIColor cyanColor];
    [but2 addTarget:self action:@selector(ccc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    

    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击了" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(80, 50, 100, 30)];
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
    
    [MDToast showToast:@"ofkdmllkvl崇山峻岭cbchjsjkxsklxks看撒接口可促进出崇山峻岭"];
//    [MDToast showToast:@"大家看崇山峻岭看撒接口可促进出口了" pattern:MDToastPatternDay position:MDToastPositionCenter];
    

//    [MDToast showToast:@"鹅鹅鹅" title:@"曲项向天歌" pattern:MDToastPatternDay position:MDToastPositionBottom];
}

- (void)bbb {
    
    [MDToast showLongToast:@"彻底死里哦才不是大街两侧的路上了领导力课程电视机厂上了快车道上了彻底离开三岔路口的课程开始了" pattern:MDToastPatternDay position:MDToastPositionCenter];
}

- (void)ccc {
    
    MDToastStyle *style = [[MDToastStyle alloc] initWithDefaultStyle];
    style.messageColor = [UIColor yellowColor];
    style.backgroundColor = [UIColor purpleColor];
    style.messageAlignment = NSTextAlignmentCenter;
    
    [MDToast makeToast:@"实你查查城市快速吃每街两侧开三岔路口的课程次老" title:@"会飞的房子" image:[UIImage imageNamed:@"ssss.png"] pattern:MDToastPatternNight position:MDToastPositionCenter style:style];
}
@end
