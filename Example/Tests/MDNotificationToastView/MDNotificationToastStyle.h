//
//  MDNotificationToastStyle.h
//  MDUI_Example
//
//  Created by mac on 2019/7/30.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDNotificationToastStyle : NSObject

@property (strong, nonatomic) UIColor *backgroundColor;

@property (strong, nonatomic) UIColor *titleColor;

@property (strong, nonatomic) UIColor *messageColor;

@property (strong, nonatomic) UIFont *titleFont;

@property (strong, nonatomic) UIFont *messageFont;

@property (assign, nonatomic) NSTextAlignment titleAlignment;

@property (assign, nonatomic) NSTextAlignment messageAlignment;

@property (assign, nonatomic) NSInteger titleNumberOfLines;

@property (assign, nonatomic) NSInteger messageNumberOfLines;

@property (assign, nonatomic) CGFloat maxWidthPercentage;

@property (assign, nonatomic) CGFloat maxHeightPercentage;

@property (assign, nonatomic) CGFloat horizontalPadding;

@property (assign, nonatomic) CGFloat verticalPadding;

@property (assign, nonatomic) CGSize imageSize;

- (instancetype)initWithDefaultStyle NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;

+(instancetype)defaultcCreateStyle;

- (MDNotificationToastStyle* (^)(UIColor *color))setBackgroundColor ;
- (MDNotificationToastStyle* (^)(UIColor *color))setTitleColor ;
- (MDNotificationToastStyle* (^)(UIColor *color))setMessageColor ;
- (MDNotificationToastStyle* (^)(UIFont *font))setTitleFont ;
- (MDNotificationToastStyle* (^)(UIFont *font))setMessageFont ;
- (MDNotificationToastStyle* (^)(NSTextAlignment alignment))setTitleAlignment ;
- (MDNotificationToastStyle* (^)(NSTextAlignment alignment))setMessageAlignment ;
- (MDNotificationToastStyle* (^)(NSInteger lines))setTitleNumberOfLines;
- (MDNotificationToastStyle* (^)(NSInteger lines))setMessageNumberOfLines;
- (MDNotificationToastStyle* (^)(CGFloat width))setMaxWidthPercentage ;
- (MDNotificationToastStyle* (^)(CGFloat height))setMaxHeightPercentage ;
- (MDNotificationToastStyle* (^)(CGFloat padding))setHorizontalPadding;
- (MDNotificationToastStyle* (^)(CGFloat padding))setVerticalPadding;
- (MDNotificationToastStyle* (^)(CGSize imageSize))setImageSize ;

@end

