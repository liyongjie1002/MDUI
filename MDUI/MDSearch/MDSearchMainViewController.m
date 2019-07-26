//
//  MDSearchMainViewController.m
//  MDUI
//
//  Created by 李永杰 on 2019/7/25.
//

#import "MDSearchMainViewController.h"
#import "MDSearchConst.h"

@interface MDSearchMainViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation MDSearchMainViewController

#pragma mark life
+ (instancetype)searchMainViewControllerWithHotSearches:(NSArray *)hots
                                         didSearchBlock:(MDSearchMainSelectedIndexPathBlock)block {
    
    MDSearchMainViewController *mainVC = [[MDSearchMainViewController alloc]init];
    mainVC.selectedIndexPathBlock = block;
    mainVC.hots = hots;
    return mainVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHistory:) name:kMDHistoryNotificationName object:nil];

}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.collectionView.frame = self.view.bounds;
}

- (void)changeHistory:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSMutableArray *history = userInfo[@"history"];
    self.histories = history;
    [self.collectionView reloadData];
}
- (void)clearHistory {
    [self.histories removeAllObjects];
    [NSKeyedArchiver archiveRootObject:self.histories toFile:KMDHistorySearchPath];
    [self.collectionView reloadData];
}
#pragma mark 代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchMainView:)]) {
        return [self.dataSource numberOfSectionsInSearchMainView:collectionView];
    }
    return 2; // 默认只有热门和发现
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchMainView:numberOfItemsInSection:)]) {
        return [self.dataSource searchMainView:collectionView numberOfItemsInSection:section];
    }
    // 0历史
    // 1热门
    return section ? self.hots.count : self.histories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.dataSource respondsToSelector:@selector(searchMainView:cellForItemAtIndexPath:)]) {
        UICollectionViewCell *cell= [self.dataSource searchMainView:collectionView cellForItemAtIndexPath:indexPath];
        if (cell) return cell;
    }
    
    static NSString *cellID = @"MDSearchMainCellID";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc]initWithFrame:cell.bounds];

    [cell.contentView addSubview:label];
    cell.contentView.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor  = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f];
    label.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0f];
    
    if (indexPath.section == 0) { // 历史
        label.text = self.histories[indexPath.item];
    }else {
        label.text = _hots[indexPath.item];
    }
    cell.layer.cornerRadius = 4;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString: UICollectionElementKindSectionHeader ]){
        
        if ([self.dataSource respondsToSelector:@selector(searchMainView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
            UICollectionReusableView *view = [self.dataSource searchMainView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
            return view;
        }
        static NSString *viewID = @"MDSearchMainReusableView";
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:viewID forIndexPath:indexPath];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(kMDSearchMainHeaderLeftMargin, kMDSearchMainHeaderTopMargin, 100, kMDSearchMainHeaderHeight - 2*kMDSearchMainHeaderTopMargin)];
        [view addSubview:label];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        
        if (indexPath.section == 0 ) { // 历史
            label.text = @"最近搜索";
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] bundlePath]] pathForResource:@"md_clear" ofType:@"png"];
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
            UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [clearButton setImage:image forState:UIControlStateNormal];
            CGFloat clearWidth = view.frame.size.height - 2*kMDSearchMainHeaderTopMargin;
            [clearButton setFrame:CGRectMake(view.frame.size.width - kMDSearchMainHeaderRightMargin - clearWidth, kMDSearchMainHeaderTopMargin, clearWidth, clearWidth)];
            [clearButton setImageEdgeInsets:UIEdgeInsetsMake(12.5, 25, 12.5, 0)];
            [clearButton addTarget:self action:@selector(clearHistory) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:clearButton];
            if (self.histories.count == 0) {
                return nil;
            }
        }else if (indexPath.section == 1) { // 热门
            label.text = @"热门搜索";
            if (self.hots.count == 0) {
                return nil;
            }
        }
        return view;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.dataSource respondsToSelector:@selector(searchMainView:layout:sizeForItemAtIndexPath:)]) {
        CGSize size = [self.dataSource searchMainView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
        return size;
    }
    NSString *text = @"";
    CGSize size = CGSizeZero;
    if (indexPath.section == 0) {
        text = self.histories[indexPath.row];
    }else if (indexPath.section == 1) {
        text = self.hots[indexPath.row];
    }
    size = [self textSizeWithFont:[UIFont systemFontOfSize:15]constrainedToSize:CGSizeMake(80, 23) lineBreakMode:NSLineBreakByWordWrapping text:text];
    if (size.width > kMDSearchScreenWidth - 2*kMDSearchMainHeaderLeftMargin - 20) {
        size.width = kMDSearchScreenWidth - 2*kMDSearchMainHeaderLeftMargin - 20;
    }
    // 字体宽度+20
    return CGSizeMake(size.width + 20, 30);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(searchMainView:layout:referenceSizeForHeaderInSection:)]) {
        CGSize size = [self.dataSource searchMainView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
        return size;
    }
    if (section == 0) { // 历史
        if (self.histories.count == 0) {
            return CGSizeZero;
        }
    }else if (section == 1) { // 热门
        if (self.hots.count == 0) {
            return CGSizeZero;
        }
    }
    return CGSizeMake(collectionView.frame.size.width, kMDSearchMainHeaderHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kMDSearchMainHeaderLeftMargin, 0, kMDSearchMainHeaderLeftMargin);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectedIndexPathBlock) {
        if (indexPath.section == 0) {
            self.selectedIndexPathBlock(self.histories[indexPath.item]);
        }else if (indexPath.section == 1) {
            self.selectedIndexPathBlock(self.hots[indexPath.item]);
        }
    }
}

#pragma mark lazy
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"MDSearchMainCellID"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MDSearchMainReusableView"];
    }
    return _collectionView;
}

- (NSMutableArray *)histories {
    if (!_histories) {
        _histories = [NSKeyedUnarchiver unarchiveObjectWithFile:KMDHistorySearchPath];
        if (!_histories) {
            _histories = [NSMutableArray array];
        }
    }
    return _histories;
}
#pragma mark 计算文字size
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
