//
//  MDToastView.h
//  MDUI_Example
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDToastStyle.h"
#import "MDToastManager.h"
@interface MDToastView : UIVisualEffectView

/**
 showToastMessage
 
 @param toastMessage toastMessage
 @param style style
 */


// 创建控件
- (CGSize )md_makeToastForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image style:(MDToastStyle *)style pattern:(MDToastPattern)pattern isDefaultStyle:(BOOL)isDefault;
// 设置位置
- (CGPoint)md_getToastCenterPointPosition:(MDToastPosition)position style:(MDToastStyle *)style;

@end

