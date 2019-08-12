//
//  MDNotificationToastView.m
//  MDUI_Example
//
//  Created by mac on 2019/7/30.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDNotificationToastView.h"

#define kScreenWidth                    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                   [UIScreen mainScreen].bounds.size.height
#define kToastDefaultFont               [UIFont systemFontOfSize:15]
#define kToastDefaultTextColor          [UIColor blackColor]
#define kNotificationStatusBarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height)


@interface MDNotificationToastView()

@property (strong, nonatomic) NSString          *message;
@property (strong, nonatomic) UILabel           *messageLabel;
@property (strong, nonatomic) UILabel           *titleLabel;
@property (strong, nonatomic) UIImageView       *imageView;

@end

@implementation MDNotificationToastView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    }
    return self;
}

#pragma mark - getters
- (UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _messageLabel.numberOfLines = 0;
        _messageLabel.alpha = 1.0;
        _messageLabel.textColor = kToastDefaultTextColor;
        _messageLabel.font = kToastDefaultFont;
    }
    return _messageLabel;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.alpha = 1.0;
    }
    return _titleLabel;
}
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
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

#pragma mark - main methods
/** 创建基础控件及位置
 * message
 * title
 * image
 * style
 */
- (CGSize )md_makeToastForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image style:(MDNotificationToastStyle *)style Position:(MDToastPosition)position pattern:(MDToastPattern)pattern isDefaultStyle:(BOOL)isDefault type:(MDToastType)type{
    
    if (message == nil && title == nil && image == nil) {
        return CGSizeZero;
    }
    [self.imageView removeFromSuperview];
    self.imageView = nil;
    [self.messageLabel removeFromSuperview];
    self.messageLabel = nil;
    [self.titleLabel removeFromSuperview];
    self.titleLabel = nil;
    self.effect = [UIBlurEffect effectWithStyle:[self getBlur:pattern]];
    self.contentView.backgroundColor = style.backgroundColor;

    if (type == MDToastTypeNotificationNavi) {
       CGSize naviSize = [self make_naviToastWithMessage:message title:title image:image style:style Position:position pattern:pattern isDefaultStyle:style];
        return naviSize;
    } else if (type  == MDToastTypeNotificationTip) {
        
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.imageView];
        /* 如果是默认style，将显示pattern的默认样式 */
        if (image != nil) {
            self.imageView.image = image;
        } else {
            if (pattern == MDToastPatternNight) {
                self.imageView.image = [UIImage imageNamed:@"ft_failure"];
            } else {
                self.imageView.image = [UIImage imageNamed:@"ft_failure_dark"];
            }
        }
        
        _messageLabel.frame = CGRectMake(10, 0, kScreenWidth, 30);
        _messageLabel.font = style.messageFont;
        _messageLabel.textAlignment = style.messageAlignment;
        _messageLabel.textColor = style.messageColor;
        _messageLabel.text = message;
        
        if (isDefault) {
            self.effect = [UIBlurEffect effectWithStyle:[self getBlur:pattern]];
            self.messageLabel.textColor = [self getTextColorWithStyle:pattern];
        }
        self.imageView.frame = CGRectMake(kScreenWidth-30, 5, 20, 20);
        
        CGSize tipSize = CGSizeMake(kScreenWidth, 30);
        return tipSize;
    }
    return CGSizeZero;
}

// 上下导航通知
- (CGSize)make_naviToastWithMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image style:(MDNotificationToastStyle *)style Position:(MDToastPosition)position pattern:(MDToastPattern)pattern isDefaultStyle:(BOOL)isDefault {
    
    CGFloat headerHeight = (position == MDToastPositionNotificationTop) ? kNotificationStatusBarHeight : 0;
    CGRect imageRect = CGRectMake(0, headerHeight, 0, 0);
    if (image != nil) {
        self.imageView.frame = CGRectMake(style.horizontalPadding, style.verticalPadding + imageRect.origin.y, style.imageSize.width, style.imageSize.height);
        _imageView.image = image;
        
        imageRect.origin.x = style.horizontalPadding;
        imageRect.origin.y = style.verticalPadding + imageRect.origin.y;
        imageRect.size.width = _imageView.bounds.size.width;
        imageRect.size.height = _imageView.bounds.size.height;
    }
    if (title != nil) {
        self.titleLabel.numberOfLines = style.titleNumberOfLines;
        _titleLabel.font = style.titleFont;
        _titleLabel.textAlignment = style.titleAlignment;
        _titleLabel.textColor = style.titleColor;
        _titleLabel.text = title;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((kScreenWidth * style.maxWidthPercentage) - imageRect.size.width, kScreenHeight * style.maxHeightPercentage);
        CGSize expectedSizeTitle = [_titleLabel sizeThatFits:maxSizeTitle];
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeTitle = CGSizeMake(MIN(maxSizeTitle.width, expectedSizeTitle.width), MIN(maxSizeTitle.height, expectedSizeTitle.height));
        _titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    if (message != nil) {
        self.messageLabel.numberOfLines = style.messageNumberOfLines;
        _messageLabel.font = style.messageFont;
        _messageLabel.textAlignment = style.messageAlignment;
        _messageLabel.textColor = style.messageColor;
        _messageLabel.text = message;
        
        CGSize maxSizeMessage = CGSizeMake((kScreenWidth * style.maxWidthPercentage) - imageRect.size.width, kScreenHeight * style.maxHeightPercentage);
        CGSize expectedSizeMessage = [_messageLabel sizeThatFits:maxSizeMessage];
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeMessage = CGSizeMake(MIN(maxSizeMessage.width, expectedSizeMessage.width), MIN(maxSizeMessage.height, expectedSizeMessage.height));
        _messageLabel.frame = CGRectMake(0.0, _messageLabel.frame.origin.y, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    /* 如果是默认style，将显示pattern的默认样式 */
    if (isDefault) {
        self.effect = [UIBlurEffect effectWithStyle:[self getBlur:pattern]];
        _titleLabel.textColor = [self getTextColorWithStyle:pattern];
        _messageLabel.textColor = [self getTextColorWithStyle:pattern];
    }
    
    CGRect titleRect = CGRectMake(0, headerHeight, 0, 0);
    if(_titleLabel != nil) {
        titleRect.origin.x = imageRect.origin.x + imageRect.size.width + style.horizontalPadding;
        titleRect.origin.y = style.verticalPadding + headerHeight;
        titleRect.size.width = _titleLabel.bounds.size.width;
        titleRect.size.height = _titleLabel.bounds.size.height;
    }
    
    CGRect messageRect = CGRectZero;
    if(_messageLabel != nil) {
        messageRect.origin.x = imageRect.origin.x + imageRect.size.width + style.horizontalPadding;
        messageRect.origin.y = titleRect.origin.y + titleRect.size.height + style.verticalPadding;
        messageRect.size.width = _messageLabel.bounds.size.width;
        messageRect.size.height = _messageLabel.bounds.size.height;
    }
    
    CGFloat contentViewHeight = MAX((messageRect.origin.y + messageRect.size.height + style.verticalPadding), (imageRect.size.height + (style.verticalPadding * 2.0))) + headerHeight;
    
    self.frame = CGRectMake(0.0, 0.0, kScreenWidth, contentViewHeight);
    
    if(_titleLabel != nil) {
        _titleLabel.frame = titleRect;
        [self.contentView addSubview:_titleLabel];
    }
    if(_messageLabel != nil) {
        _messageLabel.frame = messageRect;
        [self.contentView addSubview:_messageLabel];
    }
    if(_imageView != nil) {
        [self.contentView addSubview:_imageView];
    }
    
    return self.frame.size;
}

@end
