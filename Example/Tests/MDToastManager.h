//
//  MDToastManager.h
//  MDUI_Example
//
//  Created by mac on 2019/8/5.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDToastStyle.h"
#import "MDNotificationToastStyle.h"

typedef void (^MDNotificationTapHandler)(void);
typedef void (^MDNotificationCompletion)(void);

/**
 * toast位置
 */
typedef NS_ENUM(NSInteger, MDToastPosition) {
    MDToastPositionTop,
    MDToastPositionNotificationTop,    //导航上部
    MDToastPositionNotificationTip,    //导航栏下边通知提醒位置
    MDToastPositionCenter,
    MDToastPositionBottom,
    MDToastPositionNotificationBottom  // 导航下部
};

/**
 * toast黑白模式
 */
typedef NS_ENUM(NSInteger, MDToastPattern) {
    MDToastPatternDay,
    MDToastPatternNight
};

/**
 * toast类型，样式不同，弹出动画不同
 */
typedef NS_ENUM(NSUInteger, MDToastType) {
    MDToastTypeCustom,              //普通toast样式
    MDToastTypeNotificationNavi,    //上下导航类型
    MDToastTypeNotificationTip,     //导航提醒类型
    MDToastTypeProgress,
};

/**
 * toastProgress类型，样式不同
 */
typedef NS_ENUM(NSUInteger, MDProgressToastType) {
    MDProgressToastTypeInfo,            //中间显示info
    MDProgressToastTypeSuccess,         //中间显示成功
    MDProgressToastTypeError,           //中间显示失败
    MDProgressToastTypeProgress         //loadingtoast
};

@interface MDToastManager : NSObject

+ (void)setSharedStyle:(MDToastStyle *)sharedStyle;

+ (MDToastStyle *)sharedStyle;

+ (void)setSharedNotiStyle:(MDNotificationToastStyle *)sharedNotiStyle;

+ (MDNotificationToastStyle *)sharedNotiStyle;

+ (void)setSharedPosition:(MDToastPosition)sharedPosition;

+ (MDToastPosition)sharedPosition;

+ (void)setSharedPattern:(MDToastPattern)sharedPattern;

+ (MDToastPattern)sharedPattern;

+ (void)setDefaultType:(MDToastType)type;

+ (MDToastType)defaultType;

+ (void)setDefaultDuration:(NSTimeInterval)duration;

+ (NSTimeInterval)defaultDuration;



/**
 showToastMessage
 @param toastMessage toastMessage
 */
+ (void)showToastMessage:(NSString *)toastMessage
                   title:(NSString *)title
                   image:(UIImage *)image
                duration:(NSTimeInterval)duration
                    type:(MDToastType)type
                   style:(MDToastStyle *)style
                position:(MDToastPosition)position
                 pattern:(MDToastPattern)pattern
             autoDismiss:(BOOL)autoDismiss
              tapHandler:(MDNotificationTapHandler)tapHandler
              completion:(MDNotificationCompletion)completion
                  inView:(UIView *)parentView
   userInteractionEnable:(BOOL)userInteractionEnable
            progressType:(MDProgressToastType)progressType;


/**
 dismiss
 */
+ (void)dismiss;

+ (void)dismissNoti;

+ (void)dismissProgress;

@end

