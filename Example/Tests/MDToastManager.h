//
//  MDToastManager.h
//  MDUI_Example
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDToastStyle.h"

/**
 * toast的基础样式
 */
typedef NS_ENUM(NSInteger, MDToastType){
    MDToastTypeCustom,              /*普通toast灰色背景只文字*/
    MDToastTypeFilter,              /*悬浮带图片的圆角滑出toast*/
    MDToastTypeLight                /*紧贴上下导航滑出的轻提示*/
};

/**
 * toast位置
 */
typedef NS_ENUM(NSInteger, MDToastPosition) {
    MDToastPositionTop,
    MDToastPositionCenter,
    MDToastPositionBottom
};

/**
 * toast黑白模式
 */
typedef NS_ENUM(NSInteger, MDToastPattern) {
    MDToastPatternDay,
    MDToastPatternNight
};

@interface MDToastManager : NSObject

+ (void)setSharedStyle:(MDToastStyle *)sharedStyle;

+ (MDToastStyle *)sharedStyle;

+ (void)setSharedPosition:(MDToastPosition)sharedPosition;

+ (MDToastPosition)sharedPosition;

+ (void)setSharedPattern:(MDToastPattern)sharedPattern;

+ (MDToastPattern)sharedPattern;


/**
 showToastMessage
 @param toastMessage toastMessage
 */
+ (void)showToastMessage:(NSString *)toastMessage
                   title:(NSString *)title
                   image:(UIImage *)image
                   style:(MDToastStyle *)style
                position:(MDToastPosition)position
                 pattern:(MDToastPattern)pattern;


/**
 dismiss
 */
+ (void)dismiss;

@end

