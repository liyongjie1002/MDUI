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
    
   
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(200, 350, 100, 30);
    but.backgroundColor = [UIColor cyanColor];
    [but addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];


    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击了" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(80, 350, 100, 30)];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)clickAction {

    [MDToast dismissProgressToast];

}
- (void)aaa {
    
    [MDToast showNotiToast:@"我叫安琪拉他叫沙琪玛" title:@"学习"];
//    [MDToast showToast:@"ofkdmllkvl崇山峻岭cbchjsjkxsklxks看撒接口可促进出崇山峻岭"];
//    [MDToast showToast:@"大家看崇山峻岭看撒接口可促进出口了" pattern:MDToastPatternDay position:MDToastPositionCenter];
    

//    [MDToast showToast:@"鹅鹅鹅" title:@"曲项向天歌" pattern:MDToastPatternDay position:MDToastPositionBottom];
}


@end


/**
 
 1  适配样式问题 （不同风格） 事件  下载   自定义的
 
 2  扩展性。（只需按照不同风格封装）  不做要求  （view）
 
 3   不做面向对象的操作  
 
 
 
 1.设置添加的底部视图
 
 2.添加下载进度条
 
 3.manager样式整合
 
 4.build设计模式
 
 **/
