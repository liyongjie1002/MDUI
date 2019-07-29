//
//  MDToast.m
//  MDUI_Example
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToast.h"

@implementation MDToast

+ (void)setPatternDefaultStyle {
    [self setPattern:MDToastPatternDay];
}
+ (void)setPattern:(MDToastPattern)sharedPatter {
    [MDToastManager setSharedPattern:sharedPatter];
}


// customToast
+ (void)showToast:(NSString *)toastMessage
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:[MDToastManager sharedStyle] position:MDToastPositionBottom pattern:MDToastPatternDay];
}

// customToast
+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:[MDToastManager sharedStyle] position:position pattern:MDToastPatternDay];
    
}

// customToast
+ (void)showToast:(NSString *)toastMessage
         pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil style:[MDToastManager sharedStyle] position:position pattern:pattern];
}


+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         duration:(NSTimeInterval)duration
         position:(MDToastPosition)position
            style:(MDToastStyle *)style {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image style:style position:position pattern:pattern];
    
}









+ (void)dismissToast
{
    [MDToastManager dismiss];
}



@end
