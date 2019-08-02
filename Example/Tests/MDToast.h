//
//  MDToast.h
//  MDUI_Example
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDToastStyle.h"
#import "MDToastManager.h"

@interface MDToast : NSObject

@property (assign, nonatomic) MDToastType       type;
@property (assign, nonatomic) MDToastPosition   position;
@property (assign, nonatomic) MDToastPattern    pattern;
@property (strong, nonatomic) MDToastStyle      *style;


/**
 * 默认customToast 位置为bottom, message为一行
 */
+ (void)showToast:(NSString *)toastMessage;

// 不自动换行
+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position;

// 不自动换行
+ (void)showToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position;



/**
 * 默认customToast 位置为bottom,
 * 【以下方法均可自动换行】
 */
+ (void)showLongToast:(NSString *)toastMessage;


// 自动换行Long
+ (void)showLongToast:(NSString *)toastMessage
         position:(MDToastPosition)position;

// 自动换行
+ (void)showLongToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position;
/**
 * 默认customToast 可选择位置
 */

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
/**
 * 私有最全设置
 */
+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
            style:(MDToastStyle *)style ;


+ (void)dismissToast;

@end

