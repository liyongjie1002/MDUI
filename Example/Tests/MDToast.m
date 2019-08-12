//
//  MDToast.m
//  MDUI_Example
//
//  Created by mac on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToast.h"
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kToastDefaultDuringTime               (2.0)
#define kToastCornerRadius                    (8.f)
#define kMDDefaultAnimationDuration           (0.2f)

@implementation MDToast

#pragma mark - MDToast

// customToast
+ (void)showToast:(NSString *)toastMessage {
    
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:MDToastPositionBottom pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showToast:(NSString *)toastMessage
           inView:(UIView *)parentView {
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:MDToastPositionBottom pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:parentView userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showToast:(NSString *)toastMessage
         duration:(NSTimeInterval)duration {
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:duration type:MDToastTypeCustom style:nil position:MDToastPositionBottom pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:position pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}


+ (void)showToast:(NSString *)toastMessage
         position:(MDToastPosition)position
           inView:(UIView *)parentView {
    
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:position pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:parentView userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:position pattern:pattern autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showToast:(NSString *)toastMessage
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
         duration:(NSTimeInterval)duration {
    
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:duration type:MDToastTypeCustom style:nil position:position pattern:pattern autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}


+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:nil duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:position pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];

}
+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:position pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:nil duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:position pattern:pattern autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeCustom style:nil position:position pattern:pattern autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
            style:(MDToastStyle *)style {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeCustom style:style position:position pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)makeToast:(NSString *)toastMessage
            title:(NSString *)title
            image:(UIImage *)image
         duration:(NSTimeInterval)duration
          pattern:(MDToastPattern)pattern
         position:(MDToastPosition)position
            style:(MDToastStyle *)style
           inView:(UIView *)parentView
{
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeCustom style:style position:position pattern:pattern autoDismiss:YES tapHandler:nil completion:nil inView:parentView userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)dismissToast
{
    [MDToastManager dismiss];
}



#pragma mark - MDNotificationToast

+ (void)showNotiToast:(NSString *)toastMessage
{
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeNotificationNavi style:nil position:MDToastPositionNotificationTop pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
{
    [MDToastManager showToastMessage:toastMessage title:title image:nil duration:kToastDefaultDuringTime type:MDToastTypeNotificationNavi style:nil position:MDToastPositionNotificationTop pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}


+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
             position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:nil duration:kToastDefaultDuringTime type:MDToastTypeNotificationNavi style:nil position:position pattern:MDToastPatternDay autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];

}
+ (void)showNotificationTipToast:(NSString *)toastMessage
                      tapHandler:(MDNotificationTapHandler)tapHandler
                          inView:(UIView *)parentView
{
    
    [MDToastManager showToastMessage:toastMessage title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeNotificationTip style:nil position:MDToastPositionNotificationTip pattern:MDToastPatternDay autoDismiss:NO tapHandler:tapHandler completion:nil inView:parentView userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showNotificationTipToast:(NSString *)toastMessage
                           image:(UIImage *)image
                      tapHandler:(MDNotificationTapHandler)tapHandler
                          inView:(UIView *)parentView
{
    
    [MDToastManager showToastMessage:toastMessage title:nil image:image duration:kToastDefaultDuringTime type:MDToastTypeNotificationTip style:nil position:MDToastPositionNotificationTip pattern:MDToastPatternNight autoDismiss:NO tapHandler:tapHandler completion:nil inView:parentView userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showNotificationTipToast:(NSString *)toastMessage
                           image:(UIImage *)image
                           style:(MDToastStyle *)style
                      tapHandler:(MDNotificationTapHandler)tapHandler
                          inView:(UIView *)parentView

{
    
    [MDToastManager showToastMessage:toastMessage title:nil image:image duration:kToastDefaultDuringTime type:MDToastTypeNotificationTip style:style position:MDToastPositionNotificationTip pattern:MDToastPatternNight autoDismiss:NO tapHandler:tapHandler completion:nil inView:parentView userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeNotificationNavi style:nil position:position pattern:MDToastPatternNight autoDismiss:YES tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position
           tapHandler:(MDNotificationTapHandler)tapHandler {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeNotificationNavi style:nil position:position pattern:MDToastPatternNight autoDismiss:YES tapHandler:tapHandler completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position
           tapHandler:(MDNotificationTapHandler)tapHandler
           completion:(MDNotificationCompletion)completion {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeNotificationNavi style:nil position:MDToastPositionNotificationTop pattern:MDToastPatternNight autoDismiss:YES tapHandler:tapHandler completion:completion inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)showNotiToast:(NSString *)toastMessage
                title:(NSString *)title
                image:(UIImage *)image
             position:(MDToastPosition)position
          autoDismiss:(BOOL)autoDismiss
           tapHandler:(MDNotificationTapHandler)tapHandler
           completion:(MDNotificationCompletion)completion {
    
    [MDToastManager showToastMessage:toastMessage title:title image:image duration:kToastDefaultDuringTime type:MDToastTypeNotificationNavi style:nil position:position pattern:MDToastPatternNight autoDismiss:autoDismiss tapHandler:tapHandler completion:completion inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeInfo];
}

+ (void)dismissNotiToast {
    [MDToastManager dismissNoti];
}



+ (void)showProgressToast
{
    [MDToastManager showToastMessage:nil title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeProgress style:nil position:MDToastPositionCenter pattern:MDToastPatternNight autoDismiss:nil tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:MDProgressToastTypeProgress];
}

+ (void)showProgressToastWithView:(UIView *)parentView
{
    [MDToastManager showToastMessage:nil title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeProgress style:nil position:MDToastPositionCenter pattern:MDToastPatternNight autoDismiss:nil tapHandler:nil completion:nil inView:parentView userInteractionEnable:YES progressType:MDProgressToastTypeProgress];
}

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type;
{
    [MDToastManager showToastMessage:message title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeProgress style:nil position:MDToastPositionCenter pattern:MDToastPatternNight autoDismiss:nil tapHandler:nil completion:nil inView:nil userInteractionEnable:YES progressType:type];
}

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type
          userInteractionEnable:(BOOL)userInteractionEnable;
{
    [MDToastManager showToastMessage:message title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeProgress style:nil position:MDToastPositionCenter pattern:MDToastPatternNight autoDismiss:nil tapHandler:nil completion:nil inView:nil userInteractionEnable:userInteractionEnable progressType:type];
}

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type
                         inView:(UIView *)parentView {
    
        [MDToastManager showToastMessage:message title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeProgress style:nil position:MDToastPositionCenter pattern:MDToastPatternNight autoDismiss:nil tapHandler:nil completion:nil inView:parentView userInteractionEnable:YES progressType:type];
}

+ (void)showProgressWithMessage:(NSString *)message
                           type:(MDProgressToastType)type
                         inView:(UIView *)parentView
          userInteractionEnable:(BOOL)userInteractionEnable
{
    [MDToastManager showToastMessage:message title:nil image:nil duration:kToastDefaultDuringTime type:MDToastTypeProgress style:nil position:MDToastPositionCenter pattern:MDToastPatternNight autoDismiss:nil tapHandler:nil completion:nil inView:parentView userInteractionEnable:userInteractionEnable progressType:type];
}

+ (void)showProgressWithMessage:(NSString *)message
                          image:(UIImage *)image
          userInteractionEnable:(BOOL)userInteractionEnable
                         inView:(UIView *)parentView;
{
    
    [MDToastManager showToastMessage:message title:nil image:image duration:kToastDefaultDuringTime type:MDToastTypeProgress style:nil position:MDToastPositionCenter pattern:MDToastPatternNight autoDismiss:nil tapHandler:nil completion:nil inView:parentView userInteractionEnable:userInteractionEnable progressType:MDProgressToastTypeInfo];
}

+ (void)dismissProgressToast {
    [MDToastManager dismissProgress];
}

@end
