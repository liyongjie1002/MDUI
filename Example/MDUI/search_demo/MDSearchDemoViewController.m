//
//  MDSearchDemoViewController.m
//  MDUI_Example
//
//  Created by 李永杰 on 2019/7/25.
//  Copyright © 2019 iyongjie@yeah.net. All rights reserved.
//

#import "MDSearchDemoViewController.h"
#import "MDSearchViewController.h"
#import "MDSuggestTableViewCell.h"
#import "MDHuYaCollectionViewCell.h"
#import "MDHuyaCollectionReusableView.h"
#import "MDResultTableViewCell.h"
#import "MDSearchDemoModel.h"

#import <SafariServices/SafariServices.h>


@interface MDSearchDemoViewController ()<UISearchBarDelegate, MDSearchViewControllerDelegate, MDSearchSuggestionViewDataSource,MDSearchMainViewDataSource, MDHuyaCollectionReusableViewDelegate, MDSearchResultViewDataSource>

@property (nonatomic, strong) NSMutableArray    *suggests;

@property (nonatomic, copy)   NSArray           *hots;

@property (nonatomic, strong) NSMutableArray    *histories;

@property (nonatomic, copy)   NSArray           *news;

@property (nonatomic, strong) NSMutableArray    *results;

@property (nonatomic, strong) MDSearchViewController    *searchVC;

@end

@implementation MDSearchDemoViewController

-(void)realData {
    [self.results removeAllObjects];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *array = dic[@"server_list"];
    
    NSLog(@"%@",array);
    for (NSDictionary *tmp in array) {
        MDSearchDemoModel   *model = [[MDSearchDemoModel alloc]initWithDic:tmp];
        [self.results addObject:model];
    }
    self.searchVC.resultVC.results = self.results;
}

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
    _results = [NSMutableArray array];
    if (!_histories) {
        _histories = [NSMutableArray array];
    }
    MDSearchViewController *search = [MDSearchViewController searchViewControllerWithHotSearches:self.hots histories:self.histories placeholder:@"搜索英雄"];
//    search.navigationBarView.backgroundColor = [UIColor redColor];
    [search.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    // 文字改变监听
    search.delegate = self;
//    search.showResult = NO;
    // 模糊查找 数据源
    search.suggestVC.dataSource = self;
    [search.suggestVC.tableView registerClass:[MDSuggestTableViewCell class] forCellReuseIdentifier:@"MDSuggestTableViewCell"];
    
//     搜索页 数据源
    search.mainVC.dataSource = self;
    [search.mainVC.collectionView registerClass:[MDHuyaCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MDHuyaCollectionReusableView"];
    [search.mainVC.collectionView registerClass:[MDHuYaCollectionViewCell class] forCellWithReuseIdentifier:@"MDHuYaCollectionViewCell"];
    self.searchVC = search;
    kMDSearch_WeakSelf;
    // 类型区分解耦独立
    search.didClickItemNoResultBlock = ^(MDSearchViewController *searchVC, NSString *searchText, NSIndexPath *indexPath, MDSearchType type) {
        
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor redColor];
        [weakSelf.navigationController pushViewController:vc animated:YES];

    };
    search.didClickItemOtherBlock = ^(MDSearchViewController *search, NSString *searchText, NSIndexPath *indexPath, MDSearchType type) {
        UIViewController *vc = [UIViewController new];
        vc.view.backgroundColor = [UIColor greenColor];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    search.didClickItemResultBlock = ^(MDSearchViewController *search, NSString *searchText, NSIndexPath *indexPath, MDSearchType type) {
        [weakSelf realData];
    };
    // 结果页回调
    search.resultBlock = ^(MDSearchViewController *search, NSString *result, NSIndexPath *indexPath) {
        MDSearchDemoModel *model = self.results[indexPath.row];
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:model.server_url]];
        [weakSelf.navigationController pushViewController:safariVC animated:YES];
    };
    // 结果页 数据源
    search.resultVC.dataSource = self;
    [search.resultVC.tableView registerClass:[MDResultTableViewCell class] forCellReuseIdentifier:@"MDResultTableViewCell"];
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
    _searchBar.backgroundColor = [UIColor grayColor];
    UIView *searchTextField = [self.searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
}
#pragma mark 分区头部代理
- (void)clearHistory {
    [self.histories removeAllObjects];
    [self.searchVC.mainVC.datas removeObjectAtIndex:0];
    [self.searchVC.mainVC.datas removeObject:self.histories];
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
#pragma mark 文字改变代理
- (void)searchViewController:(MDSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    NSMutableArray *searchSuggestionsM = [NSMutableArray array];
    for (int i = 0; i < arc4random_uniform(7); i++) {
        NSString *searchSuggestion = [NSString stringWithFormat:@"模糊查找 %d good", i];
        [searchSuggestionsM addObject:searchSuggestion];
    }
    self.suggests = searchSuggestionsM;
    
    if (searchViewController.haveSuggest) {
        [searchViewController setSuggests:searchSuggestionsM];
    }
}
#pragma mark 建议页代理
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

- (NSInteger)searchResultView:(UITableView *)searchResultView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}
- (UITableViewCell *)searchResultView:(UITableView *)searchResultView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MDResultTableViewCell *cell = [searchResultView dequeueReusableCellWithIdentifier:@"MDResultTableViewCell"];
    
    MDSearchDemoModel   *model = self.results[indexPath.row];
    cell.name = model.resultName;
    cell.model = model;
    return cell;
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
