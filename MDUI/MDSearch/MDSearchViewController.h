//
//  MDSearchViewController.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//

#import <UIKit/UIKit.h>
#import "MDSearchMainViewController.h"
#import "MDSearchSuggestViewController.h"
#import "MDSearchResultViewController.h"

@class MDSearchViewController;
@protocol MDSearchViewControllerDelegate <NSObject>
- (void)searchViewController:(MDSearchViewController *)searchViewController
         searchTextDidChange:(UISearchBar *)searchBar
                  searchText:(NSString *)searchText;
@end

@interface MDSearchViewController : UIViewController

@property (nonatomic, strong) UIView                *navigationBarView;
@property (nonatomic, strong) UISearchBar           *searchBar;
@property (nonatomic, strong) UIButton              *cancelButton;

@property (nonatomic, strong) UIView                *contentView;
 
@property (nonatomic, strong) NSMutableArray        *historys;
@property (nonatomic, strong) NSMutableArray        *others;

// 是否有模糊查找
@property (nonatomic, assign) BOOL                                  haveSuggest;

@property (nonatomic, strong) MDSearchMainViewController            *mainVC;
@property (nonatomic, strong) MDSearchSuggestViewController         *suggestVC;
@property (nonatomic, strong) MDSearchResultViewController          *resultVC;

@property (nonatomic, weak)   id<MDSearchViewControllerDelegate>    delegate;

#pragma mark set方法
- (void)setSearhIcon:(UIImage *)image;
- (void)setTextFieldBackgroundColor:(UIColor *)color;

- (void)setSuggests:(NSArray *)suggests;


@end

