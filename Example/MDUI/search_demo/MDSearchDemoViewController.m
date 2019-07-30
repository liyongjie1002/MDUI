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
#import "MDHuYaCollectionViewCell.h"
#import "MDHuyaCollectionReusableView.h"
#import "MDResultTableViewCell.h"

@interface MDSearchDemoViewController ()<UISearchBarDelegate, MDSearchViewControllerDelegate, MDSearchSuggestionViewDataSource,MDSearchMainViewDataSource, MDHuyaCollectionReusableViewDelegate, MDSearchResultViewDataSource>

@property (nonatomic, strong) NSMutableArray    *suggests;

@property (nonatomic, copy)   NSArray           *hots;

@property (nonatomic, strong) NSMutableArray    *histories;

@property (nonatomic, copy)   NSArray           *news;

@property (nonatomic, copy)   NSArray           *results;

@property (nonatomic, strong) MDSearchViewController    *searchVC;

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
    _news = @[@"周赛精彩推荐",@"全球总决赛",@"虎牙独家直播"];
    _hots = @[@"夏侯惇",@"元歌",@"庄周",@"凯",@"孙尚香",@"亚瑟",@"刘禅",@"甄姬",@"后羿",@"鲁班",@"妲己"];
    _histories = [NSKeyedUnarchiver unarchiveObjectWithFile:KMDHistorySearchPath];
    _results = @[@"五虎上将",@"战神"];
    if (!_histories) {
        _histories = [NSMutableArray array];
    }
    MDSearchViewController *search = [MDSearchViewController searchViewControllerWithHotSearches:self.hots histories:self.histories placeholder:@"搜索英雄"];
    search.delegate = self;
    search.suggestVC.dataSource = self;
    search.mainVC.dataSource = self;
    [search.mainVC.collectionView registerClass:[MDHuyaCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MDHuyaCollectionReusableView"];
    [search.mainVC.collectionView registerClass:[MDHuYaCollectionViewCell class] forCellWithReuseIdentifier:@"MDHuYaCollectionViewCell"];
    self.searchVC = search;
    kMDSearch_WeakSelf;
    search.didClickItemBlock = ^(MDSearchViewController *searchVC, NSString *searchText, NSIndexPath *indexPath) {
        weakSelf.
        searchVC.resultVC.results = weakSelf.results;
    };
    
    search.resultBlock = ^(MDSearchViewController *search, NSString *result, NSIndexPath *indexPath) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor redColor];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    search.resultVC.dataSource = self;
    [search.resultVC.tableView registerClass:[MDResultTableViewCell class] forCellReuseIdentifier:@"MDResultTableViewCell"];
    [self.navigationController pushViewController:search animated:YES];
}

-(void)initSearchBar {
    
    for(int i =  0 ;i < self.searchBar.subviews.count;i++){
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
#pragma mark 分区头部代理
- (void)clearHistory {
    [self.histories removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.histories toFile:KMDHistorySearchPath];
    [self.searchVC.mainVC.collectionView reloadData];
}
#pragma mark 搜索view代理
- (NSInteger)numberOfSectionsInSearchMainView:(UICollectionView *)searchMainView {
    if (self.histories.count != 0) {
        return 3;
    }
    return 2;
}
- (NSInteger)searchMainView:(UICollectionView *)searchMainView numberOfItemsInSection:(NSInteger)section {
    
    if (self.histories.count != 0) {
        if (section == 0) {
            return self.histories.count;
        } else  if (section == 1) {
            return self.hots.count;
        }else if (section == 2) {
            return self.news.count;
        }
    }else {
        if (section == 0) {
            return self.hots.count;
        } else  if (section == 1) {
            return self.news.count;
        }
    }
    return 0;
}
- (UICollectionViewCell *)searchMainView:(UICollectionView *)searchMainView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MDHuYaCollectionViewCell *cell = [searchMainView dequeueReusableCellWithReuseIdentifier:@"MDHuYaCollectionViewCell" forIndexPath:indexPath];
    cell.histories = self.histories;
    cell.section = indexPath.section;
    if (self.histories.count != 0) {
        if (indexPath.section == 0) {
            cell.title = self.histories[indexPath.row];
        } else if (indexPath.section == 1) {
            cell.title = self.hots[indexPath.row];
            cell.row = indexPath.row;
        } else if (indexPath.section == 2) {
            cell.title = self.news[indexPath.row];
        }
    }else {
        if (indexPath.section == 0) {
            cell.title = self.hots[indexPath.row];
            cell.row = indexPath.row;
        } else if (indexPath.section == 1) {
            cell.title = self.news[indexPath.row];
        }
    }
   
    return cell;
}
- (UICollectionReusableView *)searchMainView:(UICollectionView *)searchMainView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString: UICollectionElementKindSectionHeader ]){
        // 默认分区头
        MDHuyaCollectionReusableView *view = [searchMainView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MDHuyaCollectionReusableView" forIndexPath:indexPath];
        view.delegate = self;
        if (self.histories.count != 0) {
            if (indexPath.section == 0) {
                view.titleLabel.text = @"我搜过的";
                view.isHistory = YES;
                view.rightTitle = @"清空";
                if (self.histories.count == 0) {
                    return nil;
                }
            } else if (indexPath.section == 1) {
                view.titleLabel.text = @"热门搜索";
                view.isHistory = NO;
                view.rightTitle = @"热搜榜";
                if (self.hots.count == 0) {
                    return nil;
                }
            } else if (indexPath.section == 2) {
                view.titleLabel.text = @"热门资讯";
                view.isHistory = NO;
                view.rightTitle = @"更多";
                if (self.news.count == 0) {
                    return nil;
                }
            }
        }else {
            if (indexPath.section == 0) {
                view.titleLabel.text = @"热门搜索";
                view.isHistory = NO;
                view.rightTitle = @"热搜榜";
                if (self.hots.count == 0) {
                    return nil;
                }
            } else if (indexPath.section == 1) {
                view.titleLabel.text = @"热门资讯";
                view.isHistory = NO;
                view.rightTitle = @"更多";
                if (self.news.count == 0) {
                    return nil;
                }
            }
        }
        return view;
    }
    return nil;
}
- (CGSize)searchMainView:(UICollectionView *)searchMainView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize size = CGSizeZero;
    
    NSString *text = @"";
    
    if (self.histories.count != 0) {
        if (indexPath.section == 0) {
            text = self.histories[indexPath.row];
            size = [self textSizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:CGSizeMake(80, 23) lineBreakMode:NSLineBreakByWordWrapping text:text];
            if (size.width > kMDSearchScreenWidth - 2*kMDSearchMainHeaderLeftMargin - 20) {
                size.width = kMDSearchScreenWidth - 2*kMDSearchMainHeaderLeftMargin - 20;
            }
            // 字体宽度+20
            return CGSizeMake(size.width + 20 + 50, 30);
        } else if (indexPath.section == 1) {
            return CGSizeMake(searchMainView.frame.size.width / 2.0 - kMDSearchMainHeaderLeftMargin * 2, 30);
        } else if (indexPath.section == 2) {
            return CGSizeMake(searchMainView.frame.size.width - 30, 30);
        }
    }else {
        if (indexPath.section == 0) {
            return CGSizeMake(searchMainView.frame.size.width / 2.0 - kMDSearchMainHeaderLeftMargin * 2, 30);
        }else if (indexPath.section == 1) {
            return CGSizeMake(searchMainView.frame.size.width - 30, 30);
        }
    }
    return CGSizeZero;
}
- (CGSize)searchMainView:(UICollectionView *)searchMainView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.histories.count != 0) {
        if (section == 0) { // 历史
            if (self.histories.count == 0) {
                return CGSizeZero;
            }
        }else if (section == 1) { // 热门
            if (self.hots.count == 0) {
                return CGSizeZero;
            }
        }else if (section == 2) {
            if (self.news.count == 0) {
                return CGSizeZero;
            }
        }
    }else {
        if (section == 0) {
            if (self.hots.count == 0) {
                return CGSizeZero;
            }
        }else if (section == 1) {
            if (self.news.count == 0) {
                return CGSizeZero;
            }
        }
    }
    return CGSizeMake(searchMainView.frame.size.width, 30);
}
#pragma mark 模糊搜索view自定义代理
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
#pragma mark 结果页代理

- (NSInteger)numberOfSectionsInSearchResultView:(UITableView *)searchSuggestionView {
    return 1;
}
- (NSInteger)searchResultView:(UITableView *)searchResultView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}
- (UITableViewCell *)searchResultView:(UITableView *)searchResultView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDResultTableViewCell *cell = [searchResultView dequeueReusableCellWithIdentifier:@"MDResultTableViewCell"];
    cell.name = self.results[indexPath.row];
    return cell;
}
- (CGFloat)searchResultView:(UITableView *)searchResultView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark lazy
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
- (CGSize)textSizeWithFont:(UIFont *)font
         constrainedToSize:(CGSize)size
             lineBreakMode:(NSLineBreakMode)lineBreakMode text:(NSString *)text {
    CGSize textSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [text sizeWithAttributes:attributes];
    } else {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [text boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}
@end
