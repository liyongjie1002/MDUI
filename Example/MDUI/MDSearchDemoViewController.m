//
//  MDSearchDemoViewController.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDSearchDemoViewController.h"
#import "MDSearchViewController.h"
#import "MDSearchConst.h"
#import "MDSuggestTableViewCell.h"

@interface MDSearchDemoViewController ()<UISearchBarDelegate, MDSearchViewControllerDelegate, MDSearchSuggestionViewDataSource>

@property (nonatomic, strong) NSMutableArray    *suggests;

@end

@implementation MDSearchDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationBarView];
    [self.navigationBarView addSubview:self.searchBar];
    [self initSearchBar];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    MDSearchViewController *search = [[MDSearchViewController alloc]init];
    search.delegate = self;
    search.suggestVC.dataSource = self;
    [self.navigationController pushViewController:search animated:YES];
}

-(void)initSearchBar {
    
    for(int i =  0 ;i < _searchBar.subviews.count;i++){
        UIView * backView = _searchBar.subviews[i];
        if ([backView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
            [backView removeFromSuperview];
            [_searchBar setBackgroundColor:[UIColor clearColor]];
            
            break;
        }else{
            NSArray * arr = _searchBar.subviews[i].subviews;
            for(int j = 0;j<arr.count;j++   ){
                UIView * barView = arr[i];
                if ([barView isKindOfClass:NSClassFromString(@"UISearchBarBackground")] == YES) {
                    
                    [barView removeFromSuperview];
                    [_searchBar setBackgroundColor:[UIColor clearColor]];
                    
                    break;
                }
            }
        }
    }
    UIView *searchTextField = [self.searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
}
#pragma mark 代理
- (void)searchViewController:(MDSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(10); i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"模糊查找 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            self.suggests = searchSuggestionsM;
            [searchViewController setSuggests:searchSuggestionsM];
        });
    }
}

- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestionView {
    return self.suggests.count != 0 ? 1 : 0;
}
- (NSInteger)searchSuggestionView:(UITableView *)searchSuggestionView numberOfRowsInSection:(NSInteger)section {
    return self.suggests.count;
}
- (UITableViewCell *)searchSuggestionView:(UITableView *)searchSuggestionView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDSuggestTableViewCell *cell = [[MDSuggestTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MDSuggestTableViewCell"];
    cell.name = self.suggests[indexPath.row];
    return cell;
}
- (CGFloat)searchSuggestionView:(UITableView *)searchSuggestionView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (UIView *)navigationBarView {
    if (!_navigationBarView) {
        _navigationBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kMDSearchScreenWidth, kMDSearchStatusBarHeight + kMDSearchNavBarHeight)];
    }
    return _navigationBarView;
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(kMDSearchBarLeftMargin, kMDSearchStatusBarHeight + kMDSearchBarTopMargin, self.navigationBarView.frame.size.width - 2*kMDSearchBarLeftMargin, self.navigationBarView.frame.size.height - kMDSearchStatusBarHeight - 2*kMDSearchBarTopMargin)];
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
