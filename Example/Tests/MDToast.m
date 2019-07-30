//
//  MDToast.m
//  MDUI_Example
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToast.h"

@implementation MDToast

#pragma mark - message 为一行
// customToast
+ (void)showToast:(NSString *)toastMessage
{
    MDToastStyle *style = [[MDToastStyle alloc]initWithDefaultStyle];
    style.messageNumberOfLines = 1;
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:style position:MDToastPositionBottom pattern:MDToastPatternNight];
}

// customToast
+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position
{
    MDToastStyle *style = [[MDToastStyle alloc]initWithDefaultStyle];
    style.messageNumberOfLines = 1;
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:style position:position pattern:MDToastPatternNight];
    
}

// customToast
+ (void)showToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
{
    MDToastStyle *style = [[MDToastStyle alloc]initWithDefaultStyle];
    style.messageNumberOfLines = 1;
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:style position:position pattern:pattern];
}


#pragma mark - message 可自动换行
+ (void)showLongToast:(NSString *)toastMessage {
    
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:nil position:MDToastPositionBottom pattern:MDToastPatternNight];
}

+ (void)showLongToast:(NSString *)toastMessage
         position:(MDToastPosition)position
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:nil position:position pattern:MDToastPatternNight];
}

+ (void)showLongToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:nil position:position pattern:pattern];
}
+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:nil style:nil position:position pattern:MDToastPatternNight];
}

+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image style:nil position:position pattern:MDToastPatternNight];
}


+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:nil style:nil position:position pattern:pattern];
}


+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image style:nil position:position pattern:pattern];
}

+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
            style:(MDToastStyle *)style {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image style:style position:position pattern:pattern];
    
}









+ (void)dismissToast
{
    [MDToastManager dismiss];
}



@end
