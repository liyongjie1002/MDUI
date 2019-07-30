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
typedef void(^MDSearchDidClickItemBlock)(MDSearchViewController *search, NSString *searchText, NSIndexPath *indexPath);

typedef void(^MDSearchResultBlock)(MDSearchViewController *search, NSString *result, NSIndexPath *indexPath);

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

@property (nonatomic, copy)   NSArray               *hots;
@property (nonatomic, strong) NSMutableArray        *histories;
@property (nonatomic, strong) NSMutableArray        *others;

// 是否有模糊查找
@property (nonatomic, assign) BOOL                                  haveSuggest;
// 在当前页展示结果页
@property (nonatomic, assign) BOOL                                  showResult;

@property (nonatomic, strong) MDSearchMainViewController            *mainVC;
@property (nonatomic, strong) MDSearchSuggestViewController         *suggestVC;
@property (nonatomic, strong) MDSearchResultViewController          *resultVC;

@property (nonatomic, weak)   id<MDSearchViewControllerDelegate>    delegate;

@property (nonatomic, copy)   MDSearchDidClickItemBlock             didClickItemBlock;
@property (nonatomic, copy)   MDSearchResultBlock                   resultBlock;

#pragma mark set方法
- (void)setSearhIcon:(UIImage *)image;
- (void)setTextFieldBackgroundColor:(UIColor *)color;

- (void)setSuggests:(NSArray *)suggests;

+(instancetype)searchViewControllerWithHotSearches:(NSArray *)hots histories:(NSMutableArray *)histories placeholder:(NSString *)placeholder;

@end

