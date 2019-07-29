//
//  MDToastManager.m
//  MDUI_Example
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToastManager.h"
#import "MDToastStyle.h"
#import "MDToastView.h"

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kToastToBottom                        (20.f)
#define kToastCornerRadius                    (8.f)
#define kToastDefaultAnimationDuration        (0.2f)

@interface MDToastManager ()

@property (nonatomic, strong) UIWindow                          *backgroundWindow;
@property (assign, nonatomic) MDToastPattern                    pattern;
@property (assign, nonatomic) MDToastPosition                   position;
@property (strong, nonatomic) MDToastStyle                      *sharedStyle;
@property (nonatomic, strong) MDToastView                       *toastView;
@property (nonatomic, strong) NSString                          *toastMessage;
@property (nonatomic, strong) NSString                          *toastTitle;
@property (nonatomic, strong) UIImage                           *toastImage;

@property (nonatomic, strong)NSTimer *dismissTimer;
@property (nonatomic, assign)BOOL isDuringAnimation;
@property (nonatomic, assign)BOOL isCurrentlyOnScreen;


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
        self.pattern = MDToastPatternDay;
        self.position = MDToastPositionBottom;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onChangeStatusBarOrientationNotification:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKeyboardWillChangeFrame:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onKeyboardWillChangeFrame:)
                                                     name:UIKeyboardDidShowNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - Singleton Methods
+ (void)setSharedStyle:(MDToastStyle *)sharedStyle {
    [[MDToastManager sharedManager] setSharedStyle:sharedStyle];
}

+ (MDToastStyle *)sharedStyle {
    return [[MDToastManager sharedManager] sharedStyle];
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

+ (void)dismiss
{
    [[self sharedManager] dismiss];
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

#pragma mark - PrivateMethods
+ (void)showToastMessage:(NSString *)toastMessage title:(NSString *)title image:(UIImage *)image style:(MDToastStyle *)style position:(MDToastPosition)position pattern:(MDToastPattern)pattern
{
    [[self sharedManager] showToastMessage:toastMessage title:title image:image style:style position:position pattern:pattern];
}

- (void)showToastMessage:(NSString *)toastMessage title:(NSString *)title image:(UIImage *)image style:(MDToastStyle *)style position:(MDToastPosition)position pattern:(MDToastPattern)pattern
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.toastMessage = toastMessage;
        self.toastTitle = title;
        self.toastImage = image;
        self.sharedStyle = style;
        self.position = position;
        self.pattern = pattern;
        self.isCurrentlyOnScreen = NO;
        
        [self stopDismissTimer];
        if (self.isDuringAnimation) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kToastDefaultAnimationDuration * 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self adjustIndicatorFrame];
            });
        }else{
            [self adjustIndicatorFrame];
        }
    });
}

- (void)stopDismissTimer
{
    if (_dismissTimer) {
        [_dismissTimer invalidate];
        _dismissTimer = nil;
    }
}

- (void)adjustIndicatorFrame
{
    self.toastView.alpha = 1;
    self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);

    // 初始化控件
    CGSize toastSize = [self.toastView md_makeToastForMessage:self.toastMessage title:self.toastTitle image:self.toastImage style:self.sharedStyle pattern:self.pattern];
    self.toastView.frame = CGRectMake(0, 0, toastSize.width, toastSize.height);
    // 设置控件position
    CGPoint center = [self.toastView md_getToastCenterPointPosition:self.position];
    CGFloat moveHeight = [self keyboardHeight] - (kScreenHeight- center.y - toastSize.height/2) > 0 ? [self keyboardHeight] : 0;
    self.toastView.center = CGPointMake(center.x, center.y - moveHeight);
    // 添加控件
    [self.backgroundWindow addSubview:self.toastView];
        
    self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    [self startShowingToastView];
}

- (void)startShowingToastView
{
    self.isDuringAnimation = YES;
    self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
    [UIView animateWithDuration:[[MDToastManager sharedStyle] fadeDuration]
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

- (void)dismissingToastView
{
    [self.toastView.layer removeAllAnimations];
    self.isDuringAnimation = YES;
    [UIView animateWithDuration:[[MDToastManager sharedStyle] fadeDuration]
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

- (void)startDismissTimer
{
    [self stopDismissTimer];
    
    CGFloat timeInterval = MAX(self.toastMessage.length * 0.04 + 0.5, 2.0);
    _dismissTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                     target:self
                                                   selector:@selector(dismissingToastView)
                                                   userInfo:nil
                                                    repeats:NO];
}
- (void)dismiss
{
    [self stopDismissTimer];
    [self dismissingToastView];
}

#pragma mark - PrivateMethod

- (void)onChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    if (self.isCurrentlyOnScreen) {
        [self adjustIndicatorFrame];
    }
}

- (void)onKeyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    CGRect keyboardRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration;
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    CGRect originRect = self.toastView.frame;
    CGFloat y = MIN(kScreenHeight, keyboardRect.origin.y) - kToastToBottom - originRect.size.height;
    [UIView animateWithDuration:animationDuration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.toastView setFrame:CGRectMake(originRect.origin.x, y, originRect.size.width, originRect.size.height)];
                     }completion:^(BOOL finished) {
                         
                     }];
}

- (CGFloat)keyboardHeight
{
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows]){
        if ([[testWindow class] isEqual:[UIWindow class]] == NO){
            for (UIView *possibleKeyboard in [testWindow subviews]){
                if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"]){
                    return possibleKeyboard.bounds.size.height;
                }else if ([[possibleKeyboard description] hasPrefix:@"<UIInputSetContainerView"]){
                    for (UIView *hostKeyboard in [possibleKeyboard subviews]){
                        if ([[hostKeyboard description] hasPrefix:@"<UIInputSetHost"]){
                            return hostKeyboard.frame.size.height;
                        }
                    }
                }
            }
        }
    }
    return 0;
}


@end
