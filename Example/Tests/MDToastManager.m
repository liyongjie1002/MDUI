//
//  MDToastManager.m
//  MDUI_Example
//
//  Created by mac on 2019/8/5.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToastManager.h"
#import "MDNotificationToastView.h"
#import "MDToastView.h"
#import "MDProgressToastView.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kToastDefaultAnimationDuration        (0.2f)
#define kToastDefaultDuringTime               (2.0f)

@interface MDToastManager ()

@property (nonatomic, strong) UIWindow                          *backgroundWindow;
@property (assign, nonatomic) MDToastPattern                    sharedPattern;
@property (assign, nonatomic) MDToastPosition                   sharedPosition;
@property (strong, nonatomic) MDToastStyle                      *sharedStyle;
@property (strong, nonatomic) MDNotificationToastStyle          *sharedNotiStyle;

@property (nonatomic, strong) MDToastView                       *toastView;
@property (nonatomic, strong) MDNotificationToastView           *notificationToastView;
@property (nonatomic, strong) MDProgressToastView               *progressView;
@property (assign, nonatomic) MDToastType                       defaultType;
@property (assign, nonatomic) MDProgressToastType               defaultProgressType;

@property (assign, nonatomic) NSTimeInterval                    defaultDuration;

@property (nonatomic, strong) NSString                          *toastMessage;
@property (nonatomic, strong) NSString                          *toastTitle;
@property (nonatomic, strong) UIImage                           *toastImage;

//@property (nonatomic, strong) NSString                          *progressMessage;
//@property (nonatomic, strong) UIImage                           *customImage;
@property (nonatomic, strong) NSTimer                           *dismissTimer;
@property (nonatomic, strong)NSTimer *dismissNotiTimer;
@property (nonatomic, strong)NSTimer *dismissProgressTimer;

@property (nonatomic, assign) BOOL isDuringAnimation;
@property (nonatomic, assign) BOOL isCurrentlyOnScreen;
@property (nonatomic, assign) BOOL userInteractionEnable;
@property (nonatomic, assign) BOOL isDefaultStyle;
@property (nonatomic, assign) BOOL shouldAutoDismiss;



@property (nonatomic, copy, nullable) MDNotificationTapHandler tapHandler;
@property (nonatomic, copy, nullable) MDNotificationCompletion completion;
@end

@implementation MDToastManager

+ (instancetype)sharedManager {
    static MDToastManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.sharedStyle = [[MDToastStyle alloc] initWithDefaultStyle];
        self.sharedNotiStyle = [[MDNotificationToastStyle alloc] initWithDefaultStyle];
        self.sharedPattern = MDToastPatternDay;
        self.sharedPosition = MDToastPositionBottom;
        self.defaultDuration = kToastDefaultDuringTime;
        self.defaultType = MDToastTypeCustom;
        self.defaultProgressType = MDProgressToastTypeInfo;
    }
    return self;
}

#pragma mark - Singleton Methods
+ (void)setSharedStyle:(MDToastStyle *)sharedStyle {
    [[self sharedManager] setSharedStyle:sharedStyle];
}

+ (MDToastStyle *)sharedStyle {
    return [[self sharedManager] sharedStyle];
}
+ (void)setSharedNotiStyle:(MDNotificationToastStyle *)sharedNotiStyle {
    [[self sharedManager] setSharedNotiStyle:sharedNotiStyle];
}

+ (MDNotificationToastStyle *)sharedNotiStyle {
    return [[self sharedManager] sharedNotiStyle];
}

+ (void)setSharedPosition:(MDToastPosition)sharedPosition {
    [[self sharedManager] setSharedPosition:sharedPosition];
}

+ (MDToastPosition)sharedPosition {
    return [[self sharedManager] sharedPosition];
}

+ (void)setSharedPattern:(MDToastPattern)sharedPatter {
    [[self sharedManager] setSharedPattern:sharedPatter];
}

+ (MDToastPattern)sharedPattern {
    return [[self sharedManager] sharedPattern];
}

+ (void)setDefaultType:(MDToastType)type {
    [[self sharedManager] setDefaultType:type];
}

+ (MDToastType)defaultType {
    return [[self sharedManager] defaultType];
}

+ (void)setDefaultProgressType:(MDProgressToastType)type {
    [[self sharedManager] setDefaultProgressType:type];
}

+ (MDProgressToastType)defaultProgressType {
    return [[self sharedManager] defaultProgressType];
}
+ (void)setDefaultDuration:(NSTimeInterval)duration {
    [[self sharedManager] setDefaultDuration:duration];
}

+ (NSTimeInterval)defaultDuration {
    return [[self sharedManager] defaultDuration];
}

+ (void)dismiss
{
    [[self sharedManager] dismiss];
}
+ (void)dismissNoti
{
    [[self sharedManager] dismissNoti];
}

+ (void)dismissProgress {
    [[self sharedManager] dismissProgress];
}
#pragma mark - Properties
- (UIWindow *)backgroundWindow
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    if (window == nil && [delegate respondsToSelector:@selector(window)]){
        window = [delegate performSelector:@selector(window)];
    }
    return window;
}
- (MDToastView *)toastView
{
    if (!_toastView) {
        _toastView = [[MDToastView alloc] initWithFrame:CGRectZero];
    }
    return _toastView;
}

- (MDNotificationToastView *)notificationToastView
{
    if (!_notificationToastView) {
        _notificationToastView = [[MDNotificationToastView alloc] initWithFrame:CGRectZero];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGuestureRecognized:)];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGestureRecognized:)];
        [_notificationToastView addGestureRecognizer:pan];
        [_notificationToastView addGestureRecognizer:tap];
    }
    return _notificationToastView;
}
- (MDProgressToastView *)progressView
{
    if (!_progressView) {
        _progressView = [[MDProgressToastView alloc] initWithFrame:CGRectZero];
    }
    return _progressView;
}

- (void)setUserInteractionEnable:(BOOL)userInteractionEnable
{
    self.progressView.userInteractionEnable = userInteractionEnable;
    _userInteractionEnable = userInteractionEnable;
}

- (void)onPanGuestureRecognized:(UIPanGestureRecognizer *)sender
{
    if (self.isCurrentlyOnScreen) {
        CGPoint translation = [sender translationInView:[[UIApplication sharedApplication] keyWindow]];
        switch (sender.state) {
                case UIGestureRecognizerStateBegan: case UIGestureRecognizerStateChanged:
                if (translation.y < 0) {
                    [self.notificationToastView setFrame:CGRectMake(0,translation.y,kScreenWidth,self.notificationToastView.frame.size.height)];
                }
                break;
                case UIGestureRecognizerStateEnded:
                [self dismissNoti];
                break;
            default:
                break;
        }
    }
}

- (void)onTapGestureRecognized:(UITapGestureRecognizer*)sender{
    if(self.isCurrentlyOnScreen){
        switch (sender.state) {
                case UIGestureRecognizerStateEnded:
                [self dismissOnTapped:YES];
                if(self.tapHandler){
                    self.tapHandler();
                }
                break;
            default:
                break;
        }
    }
}

- (void)dismissOnTapped:(BOOL)tapped
{
    [self stopNotiDismissTimer];
    [self dismissingNotificationtViewByTap:tapped];
}

- (void)dismissingNotificationtViewByTap:(BOOL)tap
{
    if (self.defaultType == MDToastTypeNotificationNavi) {
        
        [self.notificationToastView.layer removeAllAnimations];
        [UIView animateWithDuration:kToastDefaultAnimationDuration
                              delay:0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             if (self.sharedPosition == MDToastPositionNotificationTop) {
                                 [self.notificationToastView setFrame:CGRectMake(0,- (self.notificationToastView.frame.size.height),kScreenWidth,(self.notificationToastView.frame.size.height))];
                             } else if (self.sharedPosition == MDToastPositionNotificationBottom) {
                                 [self.notificationToastView setFrame:CGRectMake(0,kScreenHeight,kScreenWidth,(self.notificationToastView.frame.size.height))];
                             }
                         } completion:^(BOOL finished) {
                             self.isCurrentlyOnScreen = NO;
                             [self.notificationToastView removeFromSuperview];
                             if(self.completion && !tap){
                                 self.completion();
                             }
                         }];
    } else if (self.defaultType == MDToastTypeNotificationTip) {
        
        [self.notificationToastView.layer removeAllAnimations];
        self.isCurrentlyOnScreen = NO;
        [self.notificationToastView removeFromSuperview];
        if(self.completion && !tap){
            self.completion();
        }
    }
}

#pragma mark - PrivateMethods
+ (void)showToastMessage:(NSString *)toastMessage title:(NSString *)title image:(UIImage *)image duration:(NSTimeInterval)duration type:(MDToastType)type style:(MDToastStyle *)style position:(MDToastPosition)position pattern:(MDToastPattern)pattern autoDismiss:(BOOL)autoDismiss tapHandler:(MDNotificationTapHandler)tapHandler completion:(MDNotificationCompletion)completion inView:(UIView *)parentView userInteractionEnable:(BOOL)userInteractionEnable progressType:(MDProgressToastType)progressType{
    
    [[self sharedManager] showToastMessage:toastMessage title:title image:image duration:duration type:type style:style position:position pattern:pattern autoDismiss:autoDismiss tapHandler:tapHandler completion:completion inView:parentView userInteractionEnable:userInteractionEnable progressType:progressType];
}

- (void)showToastMessage:(NSString *)toastMessage title:(NSString *)title image:(UIImage *)image duration:(NSTimeInterval)duration type:(MDToastType)type style:(MDToastStyle *)style position:(MDToastPosition)position pattern:(MDToastPattern)pattern autoDismiss:(BOOL)autoDismiss tapHandler:(MDNotificationTapHandler)tapHandler completion:(MDNotificationCompletion)completion inView:(UIView *)parentView userInteractionEnable:(BOOL)userInteractionEnable progressType:(MDProgressToastType)progressType{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        self.toastMessage = toastMessage;
        self.toastTitle = title;
        self.toastImage = image;
        if (style == nil) {
            self.sharedStyle = [[MDToastStyle alloc]initWithDefaultStyle];
            self.isDefaultStyle = YES;
        } else {
            self.sharedStyle = style;
            self.isDefaultStyle = NO;
        }
        
        self.sharedPosition = position;
        self.sharedPattern = pattern;
        self.defaultType = type;
        self.defaultProgressType = progressType;
        self.defaultDuration = duration;
        self.isCurrentlyOnScreen = NO;
        self.shouldAutoDismiss = autoDismiss;
        self.tapHandler = tapHandler;
        self.completion = completion;
        self.userInteractionEnable = userInteractionEnable;
        
        __block UIView *parent = [[UIView alloc]init];
        if (parentView == nil) {
            parent = self.backgroundWindow;
        } else  {
            parent = parentView;
        }
        
        switch (self.defaultType) {
                case MDToastTypeCustom: {
                    [self stopDismissTimer];
                    if (self.isDuringAnimation) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kToastDefaultAnimationDuration * 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self adjustIndicatorFrameInView:parent];
                        });
                    }else{
                        [self adjustIndicatorFrameInView:parent];
                    }
                }
                break;
                
                case MDToastTypeNotificationNavi:
                case MDToastTypeNotificationTip: {
                    [self adjustIndicatorFrameInView:parent];
                    
                }
                break;
                
                case MDToastTypeProgress: {
                    [self stopProgressDismissTimer];
                    if (self.isDuringAnimation) {
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kToastDefaultAnimationDuration * 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self adjustIndicatorFrameInView:parent];
                        });
                    }else{
                        [self adjustIndicatorFrameInView:parent];
                    }
                }
                break;
                
            default:
                break;
        }
    });
}

- (void)adjustIndicatorFrameInView:(UIView *)parentView
{
    
    switch (self.defaultType) {
            case MDToastTypeCustom: {
                
                self.toastView.alpha = 1;
                self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                // 初始化控件
                CGSize toastSize = [self.toastView md_makeToastForMessage:self.toastMessage title:self.toastTitle image:self.toastImage style:self.sharedStyle pattern:self.sharedPattern isDefaultStyle:self.isDefaultStyle inView:parentView ];
                self.toastView.frame = CGRectMake(0, 0, toastSize.width, toastSize.height);
                // 设置控件position
                CGPoint center = [self.toastView md_getToastCenterPointPosition:self.sharedPosition style:self.sharedStyle inView:parentView];
                self.toastView.center = center;
                
                // 添加控件
                [parentView addSubview:self.toastView];
                self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
                [self startShowingToastView];
            }
            break;
            case MDToastTypeNotificationNavi: {
                
                CGSize notificationSize = [self.notificationToastView md_makeToastForMessage:self.toastMessage title:self.toastTitle image:self.toastImage style:self.sharedNotiStyle Position:self.sharedPosition pattern:self.sharedPattern isDefaultStyle:self.isDefaultStyle type:self.defaultType];
                if (self.sharedPosition == MDToastPositionNotificationTop) {
                    [self.notificationToastView setFrame:CGRectMake(0,- (notificationSize.height),kScreenWidth,notificationSize.height)];
                } else if (self.sharedPosition == MDToastPositionNotificationBottom){
                    [self.notificationToastView setFrame:CGRectMake(0,kScreenHeight,kScreenWidth,notificationSize.height)];
                }
                // 添加控件
                [parentView addSubview:self.notificationToastView];
                [self startShowingNotificationView];
            }
            break;
            case MDToastTypeNotificationTip: {
                
                CGSize notificationSize = [self.notificationToastView md_makeToastForMessage:self.toastMessage title:self.toastTitle image:self.toastImage style:self.sharedNotiStyle Position:self.sharedPosition pattern:self.sharedPattern isDefaultStyle:self.isDefaultStyle type:self.defaultType];
                [self.notificationToastView setFrame:CGRectMake(0,0,kScreenWidth,notificationSize.height)];
                
                // 添加控件
                [parentView addSubview:self.notificationToastView];
                if (!self.isCurrentlyOnScreen) {
                    [self startDismissNotiTimer];
                }
                self.isCurrentlyOnScreen = YES;
                //                [self startShowingNotificationView];
            }
            break;
            
            case MDToastTypeProgress: {
                
                self.progressView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                
                CGSize progressSize = [self.progressView getFrameForProgressViewWithMessage:self.toastMessage inView:parentView];
                [self.progressView setFrame:CGRectMake((parentView.frame.size.width - progressSize.width)/2, (parentView.frame.size.height - progressSize.height)/2, progressSize.width, progressSize.height)];
                [self.progressView showProgressWithType:self.defaultProgressType message:self.toastMessage image:self.toastImage pattern:self.sharedPattern userInteractionEnable:self.userInteractionEnable inView:parentView];
                
                [parentView addSubview:self.progressView];
                [self startShowingProgressView];
            }
            break;
        default:
            break;
    }
}

- (void)startShowingToastView
{
    self.isDuringAnimation = YES;
    self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    [UIView animateWithDuration:kToastDefaultAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                     } completion:^(BOOL finished) {
                         self.isDuringAnimation = NO;
                         if (!self.isCurrentlyOnScreen) {
                             [self startDismissTimer];
                         }
                         self.isCurrentlyOnScreen = YES;
                     }];
}

- (void)startShowingNotificationView
{
    [UIView animateWithDuration:kToastDefaultAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         if (self.sharedPosition == MDToastPositionNotificationTop) {
                             [self.notificationToastView setFrame:CGRectMake(0,0,kScreenWidth,self.notificationToastView.frame.size.height)];
                         } else if (self.sharedPosition == MDToastPositionNotificationBottom){
                             [self.notificationToastView setFrame:CGRectMake(0,kScreenHeight -self.notificationToastView.frame.size.height,kScreenWidth,self.notificationToastView.frame.size.height)];
                         }
                     } completion:^(BOOL finished) {
                         if (!self.isCurrentlyOnScreen) {
                             [self startDismissNotiTimer];
                         }
                         self.isCurrentlyOnScreen = YES;
                     }];
}

- (void)startShowingProgressView
{
    self.progressView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    self.isDuringAnimation = YES;
    self.isCurrentlyOnScreen = YES;
    [self startDismissProgressTimer];
    [UIView animateWithDuration:kToastDefaultAnimationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.progressView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
                     } completion:^(BOOL finished) {
                         self.isDuringAnimation = NO;
                     }];
}

- (void)stopDismissTimer
{
    if (_dismissTimer) {
        [_dismissTimer invalidate];
        _dismissTimer = nil;
    }
}
- (void)stopNotiDismissTimer {
    if (_dismissNotiTimer) {
        [_dismissNotiTimer invalidate];
        _dismissNotiTimer = nil;
    }
}
- (void)stopProgressDismissTimer {
    if (_dismissProgressTimer) {
        [_dismissProgressTimer invalidate];
        _dismissProgressTimer = nil;
    }
}
- (void)startDismissTimer{
    
    [self stopDismissTimer];
    _dismissTimer = [NSTimer scheduledTimerWithTimeInterval:self.defaultDuration
                                                     target:self
                                                   selector:@selector(dismissingToastView)
                                                   userInfo:nil
                                                    repeats:NO];
}

- (void)startDismissNotiTimer
{
    [self stopNotiDismissTimer];
    if (!self.shouldAutoDismiss) {
        return;
    }
    _dismissNotiTimer = [NSTimer scheduledTimerWithTimeInterval:self.defaultDuration
                                                         target:self
                                                       selector:@selector(dismissingNotificationtView)
                                                       userInfo:nil
                                                        repeats:NO];
}

- (void)startDismissProgressTimer{
    
    [self stopProgressDismissTimer];
    if (self.defaultProgressType != MDProgressToastTypeProgress) {
        _dismissProgressTimer = [NSTimer scheduledTimerWithTimeInterval:self.defaultDuration
                                                                 target:self
                                                               selector:@selector(dismissingProgressView)
                                                               userInfo:nil
                                                                repeats:NO];
    }
}

- (void)dismissingToastView
{
    [self.toastView.layer removeAllAnimations];
    self.isDuringAnimation = YES;
    [UIView animateWithDuration:kToastDefaultAnimationDuration
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
                     } completion:^(BOOL finished) {
                         self.isDuringAnimation = NO;
                         self.isCurrentlyOnScreen = NO;
                         [self.toastView removeFromSuperview];
                     }];
}

- (void)dismissingNotificationtView{
    [self dismissingNotificationtViewByTap:NO];
}

- (void)dismissingProgressView
{
    [self.progressView.layer removeAllAnimations];
    self.isDuringAnimation = YES;
    [UIView animateWithDuration:kToastDefaultAnimationDuration
                          delay:0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         self.progressView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
                     } completion:^(BOOL finished) {
                         self.isDuringAnimation = NO;
                         self.isCurrentlyOnScreen = NO;
                         if (!self.userInteractionEnable) {
                             self.userInteractionEnable = YES;
                         }
                         [self.progressView removeFromSuperview];
                     }];
}

- (void)dismiss
{
    [self stopDismissTimer];
    [self dismissingToastView];
}
- (void)dismissNoti
{
    [self dismissOnTapped:NO];
}

- (void)dismissProgress
{
    [self stopProgressDismissTimer];
    [self dismissingProgressView];
}
@end
