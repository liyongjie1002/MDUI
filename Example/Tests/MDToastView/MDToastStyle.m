//
//  MDToastStyle.m
//  MDUI_Example
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToastStyle.h"

@implementation MDToastStyle

+(instancetype)defaultcCreateStyle {
    
    return [[MDToastStyle alloc]initWithDefaultStyle];
}


- (MDToastStyle* (^)(UIColor *color))setBackgroundColor {
    return ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
}
- (MDToastStyle* (^)(UIColor *color))setTitleColor {
    return ^(UIColor *color) {
        self.titleColor = color;
        return self;
    };
}
- (MDToastStyle* (^)(UIColor *color))setMessageColor {
    return ^(UIColor *color) {
        self.messageColor = color;
        return self;
    };
}
- (MDToastStyle* (^)(CGFloat cornerRadius))setCornerRadius {
    return ^(CGFloat cornerRadius) {
        self.cornerRadius = cornerRadius;
        return self;
    };
}
- (MDToastStyle* (^)(UIFont *font))setTitleFont {
    return ^(UIFont *font) {
        self.titleFont = font;
        return self;
    };
}

- (MDToastStyle* (^)(UIFont *font))setMessageFont {
    return ^(UIFont *font) {
        self.messageFont = font;
        return self;
    };
}


- (MDToastStyle* (^)(NSTextAlignment alignment))setTitleAlignment {
    return ^(NSTextAlignment alignment) {
        self.titleAlignment = alignment;
        return self;
    };
}
- (MDToastStyle* (^)(NSTextAlignment alignment))setMessageAlignment {
    return ^(NSTextAlignment alignment) {
        self.messageAlignment = alignment;
        return self;
    };
}

- (MDToastStyle* (^)(NSInteger lines))setTitleNumberOfLines {
    return ^(NSInteger lines) {
        self.titleNumberOfLines = lines;
        return self;
    };
}
- (MDToastStyle* (^)(NSInteger lines))setMessageNumberOfLines {
    return ^(NSInteger lines) {
        self.messageNumberOfLines = lines;
        return self;
    };
}

- (MDToastStyle* (^)(CGFloat width))setMaxWidthPercentage {
    return ^(CGFloat width) {
        self.maxWidthPercentage = width;
        return self;
    };
}
- (MDToastStyle* (^)(CGFloat height))setMaxHeightPercentage {
    return ^(CGFloat height) {
        self.maxHeightPercentage = height;
        return self;
    };
}

- (MDToastStyle* (^)(CGFloat padding))setHorizontalPadding {
    return ^(CGFloat padding) {
        self.horizontalPadding = padding;
        return self;
    };
}
- (MDToastStyle* (^)(CGFloat padding))setVerticalPadding {
    return ^(CGFloat padding) {
        self.verticalPadding = padding;
        return self;
    };
}

- (MDToastStyle* (^)(BOOL display))setDisplayShadow {
    return ^(BOOL display) {
        self.displayShadow = display;
        return self;
    };
}

- (MDToastStyle* (^)(UIColor *color))setShadowColor {
    return ^(UIColor *color) {
        self.shadowColor = color;
        return self;
    };
}


- (MDToastStyle* (^)(CGFloat shadowFloat))setShadowOpacity {
    return ^(CGFloat shadowFloat) {
        self.shadowOpacity = shadowFloat;
        return self;
    };
}
- (MDToastStyle* (^)(CGFloat shadowFloat))setShadowRadius {
    return ^(CGFloat shadowFloat) {
        self.shadowRadius = shadowFloat;
        return self;
    };
}

- (MDToastStyle* (^)(CGSize shadowOffset))setShadowOffset {
    return ^(CGSize shadowOffset) {
        self.shadowOffset = shadowOffset;
        return self;
    };
}
- (MDToastStyle* (^)(CGSize imageSize))setImageSize {
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
        self.cornerRadius = 8.0;
        self.titleFont = [UIFont boldSystemFontOfSize:16.0];
        self.messageFont = [UIFont systemFontOfSize:15.0];
        self.titleAlignment = NSTextAlignmentLeft;
        self.messageAlignment = NSTextAlignmentLeft;
        self.titleNumberOfLines = 0;
        self.messageNumberOfLines = 0;
        self.displayShadow = NO;
        self.shadowOpacity = 0.8;
        self.shadowRadius = 6.0;
        self.shadowOffset = CGSizeMake(4.0, 4.0);
        self.imageSize = CGSizeMake(80.0, 80.0);
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
