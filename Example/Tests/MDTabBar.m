//
//  MDTabBar.m
//  MDUI_Example
//
//  Created by mac on 2019/8/12.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDTabBar.h"

@interface MDTabBar ()

@property (nonatomic, strong) UIView                        *backgroundView;
@property (nonatomic, strong) UIImageView                   *topLine;
@property (nonatomic, assign) CGFloat                       itemWidth;

@end

@implementation MDTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

#pragma mark - PrivateMethods
- (void)configUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backgroundView];
    [self addSubview:self.topLine];
}

- (void)layoutSubviews {
    
    CGSize frameSize = self.frame.size;
    CGFloat mininumContentHeight = [self mininumContentHeight];
    self.backgroundView.frame = CGRectMake(0, frameSize.height - mininumContentHeight, frameSize.width, frameSize.height);
    self.topLine.frame = CGRectMake(0, -7.5, SCREEN_WIDTH, 7.5);
    self.itemWidth = (frameSize.width - self.contentEdgeInsets.left - self.contentEdgeInsets.right) / self.items.count;
    
    NSInteger index = 0;
    BOOL passedRiseItem = NO;
    for (MDTabBarItem *item in self.items) {
        CGFloat itemHeight = item.itemHeight;
        if (!itemHeight) {
            itemHeight = frameSize.height;
        }
        item.frame = CGRectMake(self.contentEdgeInsets.left + index * self.itemWidth, frameSize.height - itemHeight - self.contentEdgeInsets.top, self.itemWidth, itemHeight - self.contentEdgeInsets.bottom);
        [item setNeedsDisplay];
        
        if (item.tabBarItemType != MDTabBarItemRise) {
            item.tag = index;
            index++;
        } else {
            passedRiseItem = YES;
        }
    }
}

- (void)setItems:(NSArray *)items {
    
    for (MDTabBarItem *item in _items) {
        [item removeFromSuperview];
    }
    _items = [items copy];
    for (MDTabBarItem *item in _items) {
        [item addTarget:self action:@selector(tabBarItemSelected:) forControlEvents:UIControlEventTouchDown];
    
        [self addSubview:item];
    }
}

- (void)setHeight:(CGFloat)height {
    
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame),
                              CGRectGetWidth(self.frame), height);
}

// 取min的item高度
- (CGFloat)mininumContentHeight {
    
    CGFloat mininumTabBarContentHeight = CGRectGetHeight(self.frame);
    
    for (MDTabBarItem *item in self.items) {
        CGFloat itemHeight = item.itemHeight;
        if (itemHeight && (itemHeight < mininumTabBarContentHeight)) {
            mininumTabBarContentHeight = itemHeight;
        }
    }
    return mininumTabBarContentHeight;
}

- (void)tabBarItemSelected:(id)sender {
    
    MDTabBarItem *item = sender;
    if (item.tabBarItemType != MDTabBarItemRise) {
        if ([self.delegate respondsToSelector:@selector(tabBar:shouldSelectItemAtIndex:)]) {
            NSInteger index = [self.items indexOfObject:sender];
            if (![self.delegate tabBar:self shouldSelectItemAtIndex:index]) {
                return;
            }
        }
        [self setSelectedItem:sender];
        if ([self.delegate respondsToSelector:@selector(tabBar:didSelectItemAtIndex:)]) {
            NSInteger index = [self.items indexOfObject:self.selectedItem];
            [self.delegate tabBar:self didSelectItemAtIndex:index];
        }
    
    } else {
        
        // 突出按钮被点击
        if ([self.delegate respondsToSelector:@selector(tabBarDidSelectedRiseButton)]) {
            [self.delegate tabBarDidSelectedRiseButton];
        }
    }
}

- (void)setSelectedItem:(MDTabBarItem *)selectedItem {
    
    if (selectedItem == _selectedItem) {
        return;
    }
    [_selectedItem setSelected:NO];
    _selectedItem = selectedItem;
    [_selectedItem setSelected:YES];
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        
        for (UIView *subview in self.selectedItem.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                // 转换坐标系
                CGPoint newPoint = [subview convertPoint:point fromView:self];
                // 判断触摸的位置是否存在自己的子控件，即便这个子控件超出了父视图的范围
                if (CGRectContainsPoint(subview.bounds, newPoint)) {
                    // 返回一个拦截事件的对象，这个对象可以是self，也可以是具体的子控件
                    //                        return self;
                    view = subview;
                }
            }
        }
    }
    return view;
}
#pragma mark - Accessibility
// 返回YES，所有子视图的可访问性会被隐藏，不可访问
- (BOOL)isAccessibilityElement{
    
    return NO;
}

// 返回可访问视图元素的数量
- (NSInteger)accessibilityElementCount{
    
    return self.items.count;
}

// 通过索引值返回可访问视图元素
- (id)accessibilityElementAtIndex:(NSInteger)index{
    
    return self.items[index];
}

// 通过视图元素返回索引值
- (NSInteger)indexOfAccessibilityElement:(id)element{
    
    return [self.items indexOfObject:element];
}

#pragma mark - Properties
- (UIView *)backgroundView {
    
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
    }
    return _backgroundView;
}

- (UIImageView *)topLine {
    
    if (!_topLine) {
        _topLine = [[UIImageView alloc]init];
        _topLine.image = [UIImage imageNamed:@"tabbar_line"];
    }
    return _topLine;
}

@end
