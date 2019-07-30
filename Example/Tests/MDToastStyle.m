//
//  MDToastStyle.m
//  MDUI_Example
//
//  Created by mac on 2019/7/24.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDToastStyle.h"

@implementation MDToastStyle

- (instancetype)initWithDefaultStyle {
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.titleColor = [UIColor whiteColor];
        self.messageColor = [UIColor whiteColor];
        self.maxWidthPercentage = 0.7;
        self.maxHeightPercentage = 0.8;
        self.horizontalPadding = 20.0;
        self.verticalPadding = 10.0;
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
        self.fadeDuration = 0.2;
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
