//
//  MDProgressToastView.m
//  MDUI_Example
//
//  Created by mac on 2019/8/1.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDProgressToastView.h"
#define kMDProgressMaxWidth                         (240.f)
#define kMDProgressMargin_X                         (20.f)
#define kMDProgressMargin_Y                         (20.f)
#define kMDProgressImageSize                        (30.f)
#define kMDProgressImageToLabel                     (15.f)
#define kMDProgressCornerRadius                     (10.f)
#define kMDProgressDefaultFont                      [UIFont systemFontOfSize:15]
#define kMDProgressDefaultTextColor                 [UIColor blackColor]
#define kMDProgressDefaultTextColor_ForDarkStyle    [UIColor whiteColor]
#define kMDProgressDefaultBackgroundColor           [UIColor clearColor]

@interface MDProgressToastView ()

@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UIActivityIndicatorView *activatyView;
@property (strong, nonatomic) UILabel *messageLabel;
@property (strong, nonatomic) UIView *backgroundView;
@property (assign, nonatomic) CGFloat maxWidth;

@end

@implementation MDProgressToastView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        self.maxWidth = kMDProgressMaxWidth;
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    return self;
}

#pragma mark - getters

- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.image = [UIImage imageNamed:@"info"];
    }
    return _iconImageView;
}
- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.textColor = kMDProgressDefaultTextColor;
        _messageLabel.font = kMDProgressDefaultFont;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}
- (UIActivityIndicatorView *)activatyView
{
    if (!_activatyView) {
        _activatyView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activatyView.color = kMDProgressDefaultTextColor;
        _activatyView.contentMode = UIViewContentModeCenter;
        _activatyView.hidesWhenStopped = YES;
    }
    return _activatyView;
}
- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backgroundView.backgroundColor = kMDProgressDefaultBackgroundColor;
    }
    return _backgroundView;
}

- (void)setUserInteractionEnable:(BOOL)userInteractionEnable
{
    self.userInteractionEnabled = userInteractionEnable;
    self.backgroundView.frame = [UIScreen mainScreen].bounds;
    if (userInteractionEnable) {
        [self.backgroundView removeFromSuperview];
    }else{
        [[[UIApplication sharedApplication] keyWindow] addSubview:self.backgroundView];
    }
    self.backgroundView.hidden = userInteractionEnable;
}

// 根据pattern设置字颜色
- (UIColor *)getTextColorWithStyle:(MDToastPattern)pattern
{
    switch (pattern) {
            case MDToastPatternDay:
            return [UIColor blackColor];
            break;
        default:
            return [UIColor whiteColor];
            break;
    }
}
// 根据pattern设置背景blur样式
- (UIBlurEffectStyle)getBlur:(MDToastPattern)pattern
{
    switch (pattern) {
            case MDToastPatternDay:
            return UIBlurEffectStyleLight;
            break;
        default:
            return UIBlurEffectStyleDark;
            break;
    }
}
- (UIImage *)getImageWithPattern:(MDToastPattern)pattern messageType:(MDProgressToastType )type
{
    UIImage *image;
    switch (type) {
            case MDProgressToastTypeInfo:
            if (pattern == MDToastPatternNight) {
                image = [UIImage imageNamed:@"info"];
            }else{
                image = [UIImage imageNamed:@"info_dark"];
            }
            break;
            case MDProgressToastTypeSuccess:
            if (pattern == MDToastPatternNight) {
                image = [UIImage imageNamed:@"success"];
            }else{
                image = [UIImage imageNamed:@"success_dark"];
            }
            break;
            case MDProgressToastTypeError:
            if (pattern == MDToastPatternNight) {
                image = [UIImage imageNamed:@"failure"];
            }else{
                image = [UIImage imageNamed:@"failure_dark"];
            }
            break;
        default:
            break;
    }
    return image;
}

#pragma mark - main methods
- (void)showProgressWithType:(MDProgressToastType )type message:(NSString *)message image:(UIImage *)image pattern:(MDToastPattern)pattern userInteractionEnable:(BOOL)userInteractionEnable inView:(UIView *)parentView
{
    self.effect = [UIBlurEffect effectWithStyle:[self getBlur:pattern]];
    [self.contentView addSubview:self.activatyView];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.messageLabel];
    if (type == MDProgressToastTypeProgress) {
        self.iconImageView.hidden = YES;
        [self.activatyView startAnimating];
    }else{
        self.iconImageView.hidden = NO;
        [self.activatyView stopAnimating];
    }
    

    self.userInteractionEnable = userInteractionEnable;
    self.messageLabel.text = message;
    self.messageLabel.hidden = !message.length;
    self.messageLabel.textColor = [self getTextColorWithStyle:pattern];
    self.activatyView.color = [self getTextColorWithStyle:pattern];
    if (image) {
        self.iconImageView.image = image;
    }else{
        self.iconImageView.image = [self getImageWithPattern:pattern messageType:type];
    }
    
    CGSize messageSize = [self getFrameForProgressMessageLabelWithMessage:message inView:parentView];
    CGSize viewSize = [self getFrameForProgressViewWithMessage:message inView:parentView];
    
    CGRect rect = CGRectMake((viewSize.width - messageSize.width)/2, kMDProgressMargin_Y + kMDProgressImageSize + kMDProgressImageToLabel, messageSize.width, messageSize.height);
    
    self.iconImageView.frame = CGRectMake((viewSize.width - kMDProgressImageSize)/2, kMDProgressMargin_Y, kMDProgressImageSize,  kMDProgressImageSize);
    self.activatyView.center = CGPointMake(viewSize.width/2, self.messageLabel.text == nil ? viewSize.height/2 : kMDProgressMargin_Y + self.activatyView.frame.size.height/2);
    
    self.messageLabel.frame = rect;
}

#pragma mark - getFrameForProgressMessageLabelWithMessage

- (CGSize )getFrameForProgressMessageLabelWithMessage:(NSString *)progressMessage inView:(UIView *)parentView
{
    CGSize size = CGSizeZero;
    self.maxWidth = parentView.frame.size.width-60 < kMDProgressMaxWidth ? parentView.frame.size.width-60 : kMDProgressMaxWidth;

    if (progressMessage.length) {
        CGRect textSize = [progressMessage boundingRectWithSize:CGSizeMake(self.maxWidth - kMDProgressMargin_X*2, MAXFLOAT)
                                                        options:(NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin)
                                                     attributes:@{NSFontAttributeName : kMDProgressDefaultFont}
                                                        context:nil];
        size = CGSizeMake(MAX(textSize.size.width, kMDProgressImageSize), MIN(textSize.size.height ,self.maxWidth - kMDProgressMargin_Y*2 - kMDProgressImageToLabel - kMDProgressImageSize));
    }else{
        size = CGSizeMake(kMDProgressImageSize, 0);
    }
    return size;
}

#pragma mark - getFrameForProgressViewWithMessage
- (CGSize )getFrameForProgressViewWithMessage:(NSString *)progressMessage inView:(UIView *)parentView
{
    CGSize textSize = [self getFrameForProgressMessageLabelWithMessage:progressMessage inView:parentView];
    CGSize size = CGSizeZero;
    if (progressMessage.length) {
        size = CGSizeMake(MIN(textSize.width + kMDProgressMargin_X*2 , self.maxWidth), MIN(textSize.height + kMDProgressMargin_Y*2 + kMDProgressImageSize + kMDProgressImageToLabel,self.maxWidth));
    }else{
        size = CGSizeMake(MIN(kMDProgressImageSize + kMDProgressMargin_X*2 , self.maxWidth), kMDProgressMargin_Y*2 + kMDProgressImageSize);
    }
    return size;
}
@end
