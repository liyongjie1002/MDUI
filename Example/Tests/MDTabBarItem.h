//
//  MDTabBarItem.h
//  MDUI_Example
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_HEIGHT                       [[UIScreen mainScreen] bounds].size.height
#define SCREEN_WIDTH                        [[UIScreen mainScreen] bounds].size.width

/**
 * 正常或超试图
 */
typedef NS_ENUM(NSUInteger, MDTabBarItemType) {
    MDTabBarItemNormal = 0,
    MDTabBarItemRise,
};

@interface MDTabBarItem : UIControl

@property (nonatomic, assign) CGFloat           itemHeight;
@property (nonatomic, assign) MDTabBarItemType  tabBarItemType;

#pragma mark - Title
/**
 * tabBar title
 */
@property (nonatomic, copy) NSString            *title;
/**
 * tabBar title 的偏移量
 */
@property (nonatomic) UIOffset                  titlePositionAdjustment;
/**
 * 未选中的item title attributes
 */
@property (nonatomic, copy) NSDictionary        *unselectedTitleAttributes;

/**
 * 选中的item title attributes
 */
@property (nonatomic, copy) NSDictionary        *selectedTitleAttributes;


#pragma mark - Image
/**
 * tabBar image 的偏移量
 */
@property (nonatomic) UIOffset                  imagePositionAdjustment;
/**
 * 选中图片样式
 */
- (UIImage *)finishedSelectedImage;
/**
 * 未选中图片样式
 */
- (UIImage *)finishedUnselectedImage;
/**
 * 设置item中image选中和未选中样式
 */
- (void)setFinishedSelectedImage:(UIImage *)selectedImage withFinishedUnselectedImage:(UIImage *)unselectedImage;


#pragma mark - Badge
/**
 * 右上角badge值
 */
@property (nonatomic, copy) NSString        *badgeValue;
/**
 * badge背景颜色
 */
@property (nonatomic, strong) UIColor       *badgeBackgroundColor;
/**
 * badge文字颜色
 */
@property (nonatomic, strong) UIColor       *badgeTextColor;
/**
 * badge的偏移量
 */
@property (nonatomic) UIOffset              badgePositionAdjustment;
/**
 * badge的字体大小
 */
@property (nonatomic, strong) UIFont        *badgeTextFont;

- (void)setDefaultBadge;

@end
