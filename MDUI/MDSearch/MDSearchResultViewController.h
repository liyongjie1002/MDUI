//
//  MDSearchResultViewController.h
//  MDUI
//
//  Created by 李永杰 on 2019/7/24.
//

#import <UIKit/UIKit.h>

typedef void(^MDSearchResultSelectedIndexPathBlock)(NSString *resultText, NSIndexPath *indexPath);

// 这个接口，让外界提供数据源
@protocol MDSearchResultViewDataSource <NSObject>

- (NSInteger)numberOfSectionsInSearchResultView:(UITableView *)searchSuggestionView;
- (NSInteger)searchResultView:(UITableView *)searchResultView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)searchResultView:(UITableView *)searchResultView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)searchResultView:(UITableView *)searchResultView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface MDSearchResultViewController : UIViewController

@property (nonatomic, copy)     NSArray     *results;
@property (nonatomic, weak)     id<MDSearchResultViewDataSource>        dataSource;
@property (nonatomic, copy)     MDSearchResultSelectedIndexPathBlock    selectedIndexPathBlock;
@property (nonatomic, strong)   UITableView *tableView;

+(instancetype)searchResultViewControllerWithIndexPathBlock:(MDSearchResultSelectedIndexPathBlock )indexPathBlock;


@end
