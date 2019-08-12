//
//  MDToast.h
//  MDUI_Example
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDToastManager.h"

// 除导航通知 均可选父试图
@interface MDToast : NSObject


#pragma mark - MDToast

/**
 * 默认customToast 位置为bottom
 */

+ (void)showToast:(NSString *)toastMessage;

+ (void)showToast:(NSString *)toastMessage
         duration:(NSTimeInterval)duration;

+ (void)showToast:(NSString *)toastMessage
           inView:(UIView *)parentView;

+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position;

+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position
           inView:(UIView *)parentView;

+ (void)showToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position;

+ (void)showToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
         duration:(NSTimeInterval)duration;

+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
         position:(MDToastPosition)position;

+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
         position:(MDToastPosition)position;

+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position;

+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position;

+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
            style:(MDToastStyle *)style ;

/**
 * 私有最全设置
 */
+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
         duration:(NSTimeInterval)duration
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
            style:(MDToastStyle *)style;

+ (void)dismissToast;



#pragma mark - MDNotificationToast
+ (void)showNotiToast:(NSString *)toastMessage;

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title;

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
             position:(MDToastPosition)position;

+ (void)showNotificationTipToast:(NSString *)toastMessage
                      tapHandler:(MDNotificationTapHandler)tapHandler
                          inView:(UIView *)parentView;

+ (void)showNotificationTipToast:(NSString *)toastMessage
                           image:(UIImage *)image
                      tapHandler:(MDNotificationTapHandler)tapHandler
                          inView:(UIView *)parentView;

+ (void)showNotificationTipToast:(NSString *)toastMessage
                           image:(UIImage *)image
                           style:(MDToastStyle *)style
                      tapHandler:(MDNotificationTapHandler)tapHandler
                          inView:(UIView *)parentView;

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position;

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position
           tapHandler:(MDNotificationTapHandler)tapHandler;

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position
           tapHandler:(MDNotificationTapHandler)tapHandler
           completion:(MDNotificationCompletion)completion;

/**
 * 私有最全设置
 */
+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position
          autoDismiss:(BOOL)autoDismiss
           tapHandler:(MDNotificationTapHandler)tapHandler
           completion:(MDNotificationCompletion)completion;

+ (void)dismissNotiToast;





#pragma mark - MDProgressToast
// 小菊花样式
+ (void)showProgressToast;

+ (void)showProgressToastWithView:(UIView *)parentView;

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type;

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type
          userInteractionEnable:(BOOL)userInteractionEnable;

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type
                         inView:(UIView *)parentView;

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type
                         inView:(UIView *)parentView
          userInteractionEnable:(BOOL)userInteractionEnable;

+ (void)showProgressWithMessage:(NSString *)message
                          image:(UIImage *)image
          userInteractionEnable:(BOOL)userInteractionEnable
                         inView:(UIView *)parentView;

+ (void)dismissProgressToast;

@end

