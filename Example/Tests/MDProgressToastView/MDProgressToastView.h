//
//  MDProgressToastView.h
//  MDUI_Example
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDToastManager.h"
@interface MDProgressToastView : UIVisualEffectView

/**
 userInteractionEnable, if allows user touches at view
 */
@property (assign, nonatomic) BOOL userInteractionEnable;

/**
 showProgressWithType
 
 @param type type
 @param message message
 @param image custom image
 @param style style
 @param userInteractionEnable userInteractionEnable
 */
- (void)showProgressWithType:(MDProgressToastType )type message:(NSString *)message image:(UIImage *)image pattern:(MDToastPattern)pattern userInteractionEnable:(BOOL)userInteractionEnable inView:(UIView *)parentView;

/**
 getFrameForProgressViewWithMessage
 
 @param progressMessage progressMessage
 @return CGSize
 */
- (CGSize )getFrameForProgressViewWithMessage:(NSString *)progressMessage inView:(UIView *)parentView;

@end
