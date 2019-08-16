//
//  MDTabBarItem.m
//  MDUI_Example
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabBarItem.h"

@interface MDTabBarItem ()

@property (nonatomic, strong) UIImage               *unselectedImage;
@property (nonatomic, strong) UIImage               *selectedImage;

@property (nonatomic, strong) UILabel               *itemTitle;
@property (nonatomic, strong) UIImageView           *itemImage;
@property (nonatomic, strong) UILabel               *badgeLabel;

@end

@implementation MDTabBarItem
{
    UIImage                 *_image;
    BOOL                    _isDefaultBadge;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    self.backgroundColor = [UIColor clearColor];
    
    _title = @"";
    _image = nil;
    _isDefaultBadge = nil;
    _titlePositionAdjustment = UIOffsetZero;
    _badgeBackgroundColor = [UIColor redColor];
    _badgeTextColor = [UIColor whiteColor];
    _badgeTextFont = [UIFont systemFontOfSize:12];
    _badgePositionAdjustment = UIOffsetZero;
    _unselectedTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                   NSForegroundColorAttributeName: [UIColor grayColor],};
    _selectedTitleAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName: [UIColor blackColor],};
}

- (void)drawRect:(CGRect)rect {
    
    NSDictionary *titleAttributes = nil;
    if ([self isSelected]) {
        _image = [self selectedImage];
        titleAttributes = [self selectedTitleAttributes];
        if (!titleAttributes) {
            titleAttributes = [self unselectedTitleAttributes];
        }
    } else {
        _image = [self unselectedImage];
        titleAttributes = [self unselectedTitleAttributes];
    }
    
    [self drawImageAndTitleWithAttribute:titleAttributes];
    [self drawBadge];
}

- (void)drawImageAndTitleWithAttribute:(NSDictionary *)titleAttributes {
    
    CGSize titleSize = CGSizeZero;
    [self.itemImage setImage:_image];
    
    if (![_title length]) {
        
        self.itemImage.frame = CGRectMake(self.frame.size.width / 2.0 - _image.size.width / 2.0 + _imagePositionAdjustment.horizontal, self.frame.size.height / 2.0 - _image.size.height / 2.0 + _imagePositionAdjustment.vertical, _image.size.width, _image.size.height);
        
    } else {
        
        self.itemTitle.text = _title;
        self.itemTitle.attributedText = [[NSAttributedString alloc]initWithString:_title attributes:titleAttributes];
        titleSize = [_title boundingRectWithSize:CGSizeMake(self.frame.size.width, 20)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:titleAttributes
                                         context:nil].size;
        CGFloat imageStartingY = 0;
        if (self.frame.size.height-_image.size.height-titleSize.height < 0) {
            imageStartingY=(self.frame.size.height-_image.size.height-titleSize.height)*2;
        } else {
            imageStartingY = (self.frame.size.height - _image.size.height - titleSize.height) / 2.0;
        }
        self.itemImage.frame = CGRectMake(self.frame.size.width / 2.0 - _image.size.width / 2.0 + _imagePositionAdjustment.horizontal, imageStartingY + _imagePositionAdjustment.vertical, _image.size.width, _image.size.height);
        self.itemTitle.frame = CGRectMake(self.frame.size.width / 2.0 - titleSize.width / 2.0 + _titlePositionAdjustment.horizontal, imageStartingY + _image.size.width + _titlePositionAdjustment.vertical, titleSize.width, titleSize.height);
        [self addSubview:self.itemTitle];
    }
    [self addSubview:self.itemImage];
}

- (void)drawBadge {
    
    NSString *badge = nil;
    if (_isDefaultBadge) {
        
        CGRect badgeBackgroundFrame = CGRectMake(self.frame.size.width / 2.0 + (self.itemImage.frame.size.width / 2.0) * 0.8 + [self badgePositionAdjustment].horizontal, 6.0 +  [self badgePositionAdjustment].vertical, 10, 10);

        self.badgeLabel.backgroundColor = [self badgeBackgroundColor];
        self.badgeLabel.font = [self badgeTextFont];
        self.badgeLabel.layer.cornerRadius = badgeBackgroundFrame.size.height / 2.0;
        self.badgeLabel.layer.masksToBounds = YES;
        self.badgeLabel.frame = badgeBackgroundFrame;
    } else {
        
        if ([_badgeValue integerValue] != 0) {
            if ([_badgeValue integerValue] > 99) {
                badge = @"99+";
            } else {
                badge = _badgeValue;
            }
            CGSize badgeSize = CGSizeZero;
            badgeSize = [badge boundingRectWithSize:CGSizeMake(self.frame.size.width, 20)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName: [self badgeTextFont]}
                                            context:nil].size;
            if (badgeSize.width < badgeSize.height) {
                badgeSize = CGSizeMake(badgeSize.height, badgeSize.height);
            }
            CGRect badgeBackgroundFrame = CGRectMake(self.frame.size.width / 2.0 + (self.itemImage.frame.size.width / 2.0) * 0.9 + [self badgePositionAdjustment].horizontal, 2.0 +  [self badgePositionAdjustment].vertical, badgeSize.width + 2 * 2, badgeSize.height + 2 * 2);
            
            self.badgeLabel.text = badge;
            self.badgeLabel.backgroundColor = [self badgeBackgroundColor];
            self.badgeLabel.textColor = [self badgeTextColor];
            self.badgeLabel.font = [self badgeTextFont];
            self.badgeLabel.layer.cornerRadius = badgeBackgroundFrame.size.height / 2.0;
            self.badgeLabel.layer.masksToBounds = YES;
            self.badgeLabel.frame = CGRectMake(CGRectGetMinX(badgeBackgroundFrame) + 2.0, CGRectGetMinY(badgeBackgroundFrame) + 2.0, badgeBackgroundFrame.size.width, badgeBackgroundFrame.size.height);
        }
        [self addSubview:self.badgeLabel];
    }
}

#pragma mark - Image configuration
- (UIImage *)finishedSelectedImage {
    
    return [self selectedImage];
}

- (UIImage *)finishedUnselectedImage {
    
    return [self unselectedImage];
}

- (void)setFinishedSelectedImage:(UIImage *)selectedImage withFinishedUnselectedImage:(UIImage *)unselectedImage {
    
    if (selectedImage && (selectedImage != [self selectedImage])) {
        [self setSelectedImage:selectedImage];
    }
    
    if (unselectedImage && (unselectedImage != [self unselectedImage])) {
        
        [self setUnselectedImage:unselectedImage];
    }
}

- (void)setBadgeValue:(NSString *)badgeValue {
    
    _badgeValue = [NSString stringWithFormat:@"%@", badgeValue];
    [self setNeedsDisplay];
}

- (void)setDefaultBadge {
    
    _isDefaultBadge = YES;
    [self setNeedsDisplay];
}

#pragma mark - Accessibility
- (NSString *)accessibilityLabel {
    
    return @"tabbarItem";
}

- (BOOL)isAccessibilityElement {
    
    return YES;
}

#pragma mark - Properties
-(UILabel *)itemTitle {
    
    if (!_itemTitle) {
        _itemTitle = [[UILabel alloc]init];
        _itemTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _itemTitle;
}

- (UIImageView *)itemImage {
    
    if (!_itemImage) {
        _itemImage = [[UIImageView alloc]init];
    }
    return _itemImage;
}

- (UILabel *)badgeLabel {
    
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

@end
