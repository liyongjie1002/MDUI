//
//  MDToastView.m
//  MDUI_Example
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToastView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height
//#define kToastMaxWidth                        (kScreenWidth*0.7)
#define kToastMaxHeight                       (100.f)
#define kToastMargin_X                        (20.f)
#define kToastMargin_Y                        (10.f)
#define kToastToBottom                        (20.f)
#define kToastCornerRadius                    (8.f)
#define kToastDefaultAnimationDuration        (0.2f)
#define kToastDefaultFont                     [UIFont systemFontOfSize:15]
#define kToastDefaultTextColor                [UIColor blackColor]
static const NSString * MDToastQueueKey             = @"MDToastQueueKey";
static const NSString * MDToastCompletionKey        = @"MDToastCompletionKey";

@interface MDToastView()

@property (strong, nonatomic) NSString          *message;
@property (strong, nonatomic) UILabel           *messageLabel;
@property (strong, nonatomic) UILabel           *titleLabel;
@property (strong, nonatomic) UIImageView       *imageView;

@property (nonatomic, strong) NSTimer                           *dismissTimer;
@property (nonatomic, assign) BOOL                              isDuringAnimation;
@property (nonatomic, assign) BOOL                              isCurrentlyOnScreen;
@end


@implementation MDToastView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
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
            return [UIColor whiteColor];
            break;
        default:
            return [UIColor blackColor];
            break;
    }
}
// 根据pattern设置背景blur样式
- (UIBlurEffectStyle)getBlur:(MDToastPattern)pattern
{
    switch (pattern) {
        case MDToastPatternDay:
            return UIBlurEffectStyleDark;
            break;
        default:
            return UIBlurEffectStyleLight;
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
- (CGSize )md_makeToastForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image style:(MDToastStyle *)style pattern:(MDToastPattern)pattern {
    
    if (message == nil && title == nil && image == nil) {
        return CGSizeZero;
    }
    if (style == nil) {
        style = [MDToastManager sharedStyle];
    }
    
    self.effect = [UIBlurEffect effectWithStyle:[self getBlur:pattern]];
    self.layer.cornerRadius = style.cornerRadius;
    self.backgroundColor = style.backgroundColor;
    if (style.displayShadow) {
        self.layer.shadowColor = style.shadowColor.CGColor;
        self.layer.shadowOpacity = style.shadowOpacity;
        self.layer.shadowRadius = style.shadowRadius;
        self.layer.shadowOffset = style.shadowOffset;
    }
    CGRect imageRect = CGRectZero;
    if (image != nil) {
        self.imageView.image = image;
        _imageView.frame = CGRectMake(style.horizontalPadding, style.verticalPadding, style.imageSize.width, style.imageSize.height);
        
        imageRect.origin.x = style.horizontalPadding;
        imageRect.origin.y = style.verticalPadding;
        imageRect.size.width = _imageView.bounds.size.width;
        imageRect.size.height = _imageView.bounds.size.height;
    }
    if (title != nil) {
        self.titleLabel.text = title;
        _titleLabel.numberOfLines = style.titleNumberOfLines;
        _titleLabel.font = style.titleFont;
        _titleLabel.textAlignment = style.titleAlignment;
        _titleLabel.textColor = style.titleColor;
        
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((kScreenWidth * style.maxWidthPercentage) - imageRect.size.width, kScreenHeight * style.maxHeightPercentage);
        CGSize expectedSizeTitle = [_titleLabel sizeThatFits:maxSizeTitle];
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeTitle = CGSizeMake(MIN(maxSizeTitle.width, expectedSizeTitle.width), MIN(maxSizeTitle.height, expectedSizeTitle.height));
        _titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    if (message != nil) {
        self.messageLabel.text = message;
        _messageLabel.numberOfLines = style.messageNumberOfLines;
        _messageLabel.font = style.messageFont;
        _messageLabel.textAlignment = style.messageAlignment;
        _messageLabel.textColor = style.messageColor;
        
        CGSize maxSizeMessage = CGSizeMake((kScreenWidth * style.maxWidthPercentage) - imageRect.size.width, kScreenHeight * style.maxHeightPercentage);
        CGSize expectedSizeMessage = [_messageLabel sizeThatFits:maxSizeMessage];
        // UILabel can return a size larger than the max size when the number of lines is 1
        expectedSizeMessage = CGSizeMake(MIN(maxSizeMessage.width, expectedSizeMessage.width), MIN(maxSizeMessage.height, expectedSizeMessage.height));
        _messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    
    CGRect titleRect = CGRectZero;
    if(_titleLabel != nil) {
        titleRect.origin.x = imageRect.origin.x + imageRect.size.width + style.horizontalPadding;
        titleRect.origin.y = style.verticalPadding;
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
    
    CGFloat longerWidth = MAX(titleRect.size.width, messageRect.size.width);
    CGFloat longerX = MAX(titleRect.origin.x, messageRect.origin.x);
    CGFloat contentViewWidth = MAX((imageRect.size.width + (style.horizontalPadding * 2.0)), (longerX + longerWidth + style.horizontalPadding));
    CGFloat contentViewHeight = MAX((messageRect.origin.y + messageRect.size.height + style.verticalPadding), (imageRect.size.height + (style.verticalPadding * 2.0)));
    
    self.contentView.frame = CGRectMake(0.0, 0.0, contentViewWidth, contentViewHeight);
    
    if(_titleLabel != nil) {
        _titleLabel.frame = titleRect;
        [self.contentView addSubview:self.titleLabel];
    }
    if(_messageLabel != nil) {
        _messageLabel.frame = messageRect;
        [self.contentView addSubview:self.messageLabel];
    }
    if(_imageView != nil) {
        [self.contentView addSubview:self.imageView];
    }
    
    return self.contentView.frame.size;
}

/**
 * toastView
 * duration
 * position
 * pattern
 * completionBlock
 */
//- (void)md_showToastView:(UIView *)toastView duration:(NSTimeInterval)duration position:(MDToastPosition)position pattern:(MDToastPattern)pattern completion:(void(^)(BOOL didTap))completion {
//
//    if (toastView == nil) {
//        return;
//    }
//    toastView.center = [self md_getToastCenterPointPosition:position withToast:toastView];
//    [self startShowingToastView];
//}

//- (void)startShowingToastView {
//
//    self.isDuringAnimation = YES;
//    self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.2, 0.2);
//
//    [UIView animateWithDuration:[MDToastManager sharedStyle]
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         self.toastView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
//                     } completion:^(BOOL finished) {
//                         self.isDuringAnimation = NO;
//                         if (!self.isCurrentlyOnScreen) {
//                             [self startDismissTimer];
//                         }
//                         self.isCurrentlyOnScreen = YES;
//                     }];
//}


/*
- (void)showToastMessage:(NSString *)toastMessage style:(MDToastStyle *)style position:(MDToastPosition)position pattern:(MDToastPattern)pattern {
    
    if (style == nil) {
        style = [MDToastManager sharedStyle];
    }
    self.effect = [UIBlurEffect effectWithStyle:[self getBlur:pattern]];
    
    self.message = toastMessage;
    self.messageLabel.textColor = [self getTextColorWithStyle:pattern];
    self.messageLabel.text = toastMessage;
    self.messageLabel.font = style.messageFont;
    
    CGSize labelSize = [self getFrameForToastLabelWithMessage:toastMessage];
    CGSize viewSize = [self getFrameForToastViewWithMessage:toastMessage];
    CGRect rect = CGRectMake((viewSize.width - labelSize.width)/2, (viewSize.height - labelSize.height)/2, labelSize.width, labelSize.height);
    self.messageLabel.frame = rect;

    CGPoint centerPoint = [self md_getToastCenterPointPosition:position style:style viewHeight:viewSize.height];
    self.center = centerPoint;
}

#pragma mark - getFrameForToastLabelWithMessage
- (CGSize )getFrameForToastLabelWithMessage:(NSString *)toastMessage
{
    CGRect textSize = [toastMessage boundingRectWithSize:CGSizeMake(kToastMaxWidth - kToastMargin_X*2, MAXFLOAT)
                                                 options:(NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin)
                                              attributes:@{NSFontAttributeName : kToastDefaultFont}
                                                 context:nil];
    CGSize size = CGSizeMake(MAX(textSize.size.width, kToastMargin_Y*2), MIN(textSize.size.height ,kToastMaxHeight - kToastMargin_Y*2));
    return size;
}

#pragma mark - getFrameForToastViewWithMessage
- (CGSize )getFrameForToastViewWithMessage:(NSString *)toastMessage
{
    CGSize textSize = [self getFrameForToastLabelWithMessage:toastMessage];
    CGSize size = CGSizeMake(MIN(textSize.width + kToastMargin_X*2 , kToastMaxWidth), MIN(textSize.height + kToastMargin_Y*2 ,kToastMaxHeight));
    return size;
}

#pragma mark - getCenterPointForToastView
- (CGPoint)md_getToastCenterPointPosition:(MDToastPosition)position style:(MDToastStyle *)style viewHeight:(CGFloat)height{
    
    UIEdgeInsets safeInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeInsets = self.safeAreaInsets;
    }
    CGFloat topPadding = style.verticalPadding + safeInsets.top;
    CGFloat bottomPadding = style.verticalPadding + safeInsets.bottom;

    switch (position) {
        case MDToastPositionTop:
            return CGPointMake(kScreenWidth / 2.0, (height / 2.0) + topPadding);
            break;
        case MDToastPositionCenter:
            return CGPointMake(kScreenWidth / 2.0, kScreenHeight / 2.0);
            break;
        case MDToastPositionBottom:
            return CGPointMake(kScreenWidth / 2.0, (kScreenHeight - (kScreenHeight / 2.0)) - bottomPadding);
            break;
        default:
            break;
    }
}
*/

- (CGPoint)md_getToastCenterPointPosition:(MDToastPosition)position{
    
    MDToastStyle *style = [MDToastManager sharedStyle];
    UIEdgeInsets safeInsets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        safeInsets = self.safeAreaInsets;
    }
    CGFloat topPadding = style.verticalPadding + safeInsets.top;
    CGFloat bottomPadding = style.verticalPadding + safeInsets.bottom;
    
    switch (position) {
        case MDToastPositionTop:
            return CGPointMake(kScreenWidth / 2.0, (self.contentView.frame.size.height / 2.0) + topPadding);
            break;
        case MDToastPositionCenter:
            return CGPointMake(kScreenWidth / 2.0, kScreenHeight / 2.0);
            break;
        case MDToastPositionBottom:
            return CGPointMake(kScreenWidth / 2.0, (kScreenHeight - (self.contentView.frame.size.height / 2.0)) - bottomPadding);
            break;
        default:
            break;
    }
}


@end
