//
//  MDNotificationToastView.h
//  MDUI_Example
//
//  Created by mac on 2019/7/30.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDNotificationToastStyle.h"
#import "MDToastManager.h"
@interface MDNotificationToastView : UIVisualEffectView

// 创建控件
- (CGSize )md_makeToastForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image style:(MDNotificationToastStyle *)style Position:(MDToastPosition)position pattern:(MDToastPattern)pattern isDefaultStyle:(BOOL)isDefault type:(MDToastType)type;

@end

