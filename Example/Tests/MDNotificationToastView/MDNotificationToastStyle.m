//
//  MDNotificationToastStyle.m
//  MDUI_Example
//
//  Created by mac on 2019/7/30.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDNotificationToastStyle.h"

@implementation MDNotificationToastStyle


+(instancetype)defaultcCreateStyle {
    
    return [[MDNotificationToastStyle alloc]initWithDefaultStyle];
}


- (MDNotificationToastStyle* (^)(UIColor *color))setBackgroundColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (MDNotificationToastStyle* (^)(UIColor *color))setTitleColor {
    return ^(UIColor *color) {
        self.titleColor = color;
        return self;
    };
}
- (MDNotificationToastStyle* (^)(UIColor *color))setMessageColor {
    return ^(UIColor *color) {
        self.messageColor = color;
        return self;
    };
}

- (MDNotificationToastStyle* (^)(UIFont *font))setTitleFont {
    return ^(UIFont *font) {
        self.titleFont = font;
        return self;
    };
}

- (MDNotificationToastStyle* (^)(UIFont *font))setMessageFont {
    return ^(UIFont *font) {
        self.messageFont = font;
        return self;
    };
}


- (MDNotificationToastStyle* (^)(NSTextAlignment alignment))setTitleAlignment {
    return ^(NSTextAlignment alignment) {
        self.titleAlignment = alignment;
        return self;
    };
}
- (MDNotificationToastStyle* (^)(NSTextAlignment alignment))setMessageAlignment {
    return ^(NSTextAlignment alignment) {
        self.messageAlignment = alignment;
        return self;
    };
}

- (MDNotificationToastStyle* (^)(NSInteger lines))setTitleNumberOfLines {
    return ^(NSInteger lines) {
        self.titleNumberOfLines = lines;
        return self;
    };
}
- (MDNotificationToastStyle* (^)(NSInteger lines))setMessageNumberOfLines {
    return ^(NSInteger lines) {
        self.messageNumberOfLines = lines;
        return self;
    };
}

- (MDNotificationToastStyle* (^)(CGFloat width))setMaxWidthPercentage {
    return ^(CGFloat width) {
        self.maxWidthPercentage = width;
        return self;
    };
}
- (MDNotificationToastStyle* (^)(CGFloat height))setMaxHeightPercentage {
    return ^(CGFloat height) {
        self.maxHeightPercentage = height;
        return self;
    };
}

- (MDNotificationToastStyle* (^)(CGFloat padding))setHorizontalPadding {
    return ^(CGFloat padding) {
        self.horizontalPadding = padding;
        return self;
    };
}
- (MDNotificationToastStyle* (^)(CGFloat padding))setVerticalPadding {
    return ^(CGFloat padding) {
        self.verticalPadding = padding;
        return self;
    };
}

- (MDNotificationToastStyle* (^)(CGSize imageSize))setImageSize {
    return ^(CGSize imageSize) {
        self.imageSize = imageSize;
        return self;
    };
}


- (instancetype)initWithDefaultStyle {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.titleColor = [UIColor whiteColor];
        self.messageColor = [UIColor whiteColor];
        self.maxWidthPercentage = 0.7;
        self.maxHeightPercentage = 0.8;
        self.horizontalPadding = 14.0;
        self.verticalPadding = 14.0;
        self.titleFont = [UIFont boldSystemFontOfSize:15.0];
        self.messageFont = [UIFont systemFontOfSize:13.0];
        self.titleAlignment = NSTextAlignmentLeft;
        self.messageAlignment = NSTextAlignmentLeft;
        self.titleNumberOfLines = 0;
        self.messageNumberOfLines = 0;
        self.imageSize = CGSizeMake(30.0, 30.0);
    }
    return self;
}

- (void)setMaxWidthPercentage:(CGFloat)maxWidthPercentage {
    _maxWidthPercentage = MAX(MIN(maxWidthPercentage, 1.0), 0.0);
}

- (void)setMaxHeightPercentage:(CGFloat)maxHeightPercentage {
    _maxHeightPercentage = MAX(MIN(maxHeightPercentage, 1.0), 0.0);
}

- (instancetype)init NS_UNAVAILABLE {
    return nil;
}

@end
