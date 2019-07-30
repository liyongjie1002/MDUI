//
//  MDToastStyle.h
//  MDUI_Example
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MDToastStyle : NSObject

@property (strong, nonatomic) UIColor *backgroundColor;

@property (strong, nonatomic) UIColor *titleColor;

@property (strong, nonatomic) UIColor *messageColor;

@property (assign, nonatomic) CGFloat cornerRadius;

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

@property (assign, nonatomic) BOOL displayShadow;

@property (strong, nonatomic) UIColor *shadowColor;

@property (assign, nonatomic) CGFloat shadowOpacity;

@property (assign, nonatomic) CGFloat shadowRadius;

@property (assign, nonatomic) CGSize shadowOffset;

@property (assign, nonatomic) CGSize imageSize;

@property (assign, nonatomic) NSTimeInterval fadeDuration;

- (instancetype)initWithDefaultStyle NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;


@end

