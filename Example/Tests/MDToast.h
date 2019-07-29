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
 * 默认customToast 位置为bottom
 */
+ (void)showToast:(NSString *)toastMessage;

/**
 * 默认customToast 可选择位置
 */
+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position;


+ (void)showToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position;


/**
 * 私有最全设置
 */
+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         duration:(NSTimeInterval)duration
         position:(MDToastPosition)position
            style:(MDToastStyle *)style ;


+ (void)dismissToast;

@end

