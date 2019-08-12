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

@property (nonatomic, strong) UIView *bottomView;
@end

@implementation MDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImageView *ima = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"aaaaa.jpg"]];
    ima.frame = CGRectMake(0, 300, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:ima];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeSystem];
    but1.frame = CGRectMake(200, 320, 100, 30);
    but1.backgroundColor = [UIColor orangeColor];
    [but1 addTarget:self action:@selector(bbb) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but1];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeSystem];
    but.frame = CGRectMake(200, 350, 100, 30);
    but.backgroundColor = [UIColor cyanColor];
    [but addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];

    UIButton *but2 = [UIButton buttonWithType:UIButtonTypeSystem];
    but2.frame = CGRectMake(80, 320, 100, 30);
    but2.backgroundColor = [UIColor cyanColor];
    [but2 addTarget:self action:@selector(ccc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    UIButton *but22 = [UIButton buttonWithType:UIButtonTypeSystem];
    but22.frame = CGRectMake(80, 380, 100, 30);
    but22.backgroundColor = [UIColor cyanColor];
    [but22 addTarget:self action:@selector(ddd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but22];
    
    UIButton *but222 = [UIButton buttonWithType:UIButtonTypeSystem];
    but222.frame = CGRectMake(80, 410, 100, 30);
    but222.backgroundColor = [UIColor redColor];
    [but222 addTarget:self action:@selector(fff) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but222];
    
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"点击了" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(80, 350, 100, 30)];
    [btn addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    self.bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, self.view.frame.size.width/5, self.view.frame.size.height/2)];
    self.bottomView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.bottomView];

}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

}
-(void)clickAction {
//    MDSearchDemoViewController *vc = [[MDSearchDemoViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    [MDToast dismissProgressToast];

}
- (void)aaa {
    
    [MDToast showNotiToast:@"我叫安琪拉他叫沙琪玛" title:@"学习"];
//    [MDToast showToast:@"ofkdmllkvl崇山峻岭cbchjsjkxsklxks看撒接口可促进出崇山峻岭"];
//    [MDToast showToast:@"大家看崇山峻岭看撒接口可促进出口了" pattern:MDToastPatternDay position:MDToastPositionCenter];
    

//    [MDToast showToast:@"鹅鹅鹅" title:@"曲项向天歌" pattern:MDToastPatternDay position:MDToastPositionBottom];
}

- (void)bbb {
    
//    [MDToast showLongToast:@"彻底死里哦才不是大街两侧的路上了领导力课程电视机厂上了快车道上了彻底离开三岔路口的课程开始了" pattern:MDToastPatternDay position:MDToastPositionCenter];
    
    [MDToast showNotiToast:@"s这世界好像都放慢" title:@"度日如年" image:[UIImage imageNamed:@"ssss.png"] position:MDToastPositionNotificationTop autoDismiss:NO tapHandler:^{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Tap Handling"
                                                            message:@"This happen when you tap notification"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    } completion:^{
        
        [MDToast showToast:@"Notification dismissed"];
    }];
//    [MDToast showNotiToast:@"dhbhucdhjckfsjil.lnj/1@" title:@"我是标题" position:MDNotificationPositionTop];
}

- (void)ccc {
    
//    [MDToast showNotiToast:nil title:@"你就开始村上春树乘客们快乐" position:MDNotificationPositionBottom];
//    [MDToast makeToast:nil title:nil image:[UIImage imageNamed:@"ssss.png"] pattern:MDToastPatternDay position:MDToastPositionCenter style:nil];
//    [[[MDToastStyle defaultcCreateStyle] setbackgroundColor] titleColor ]
    //[MDToastStyle defaultcCreateStyle].setTitleFont([UIFont systemFontOfSize:18.f]).setMessageColor([UIColor purpleColor])

       [MDToast makeToast:@"实你查查城市快速吃每街两侧开三岔路口的课程次老" title:@"会飞的房子" image:[UIImage imageNamed:@"ssss.png"] pattern:MDToastPatternNight position:MDToastPositionCenter style:[MDToastStyle defaultcCreateStyle].setTitleFont([UIFont systemFontOfSize:6.f]).setMessageColor([UIColor yellowColor]).setBackgroundColor([UIColor redColor]).setCornerRadius(2).setImageSize(CGSizeMake(100, 100))];
//
}
- (void)ddd {
    
    [MDToast showProgressToast];
    [MDToast showNotiToast:@"aaaaa" title:nil position:MDToastPositionNotificationBottom];
//    [MDToast showProgressToastWithView:self.bottomView];

}

- (void)fff {
    
//    [MDToast showProgressWithMessage:@"ahhhhhhhhhhha" image:[UIImage imageNamed:@"ssss.png"] userInteractionEnable:NO inView:self.bottomView];
    
//    [MDToast showProgressWithMessage:@"上课了吗你觉得像未成年失联客机的计算机吃的机车夹克开衫的进出口量上课了想睡觉呢" type:MDProgressToastTypeSuccess userInteractionEnable:YES inView:self.bottomView];

//    [MDToast showToast:@"神经内科小时开机开车时就开始考虑卢卡申科了科学技术了看见你吃大餐年开始" position:MDToastPositionCenter inView:self.bottomView];
//    [MDToast showToast:@"啊啊睡觉睡觉" pattern:MDToastPatternDay position:MDToastPositionCenter duration:8];
//    [MDToast showProgressWithMessage:nil type:MDToastTypeProgress userInteractionEnable:YES];
    
    [MDToast showNotificationTipToast:@"我也不知道" tapHandler:^{
        [MDToast dismissNotiToast];
    } inView:self.bottomView];
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
