//
//  FoldingTableView.m
//  Buyer
//
//  Created by bfme on 2017/3/3.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import "FoldingTableView.h"

@interface FoldingTableView () <FoldingSectionHeaderDelegate>

@property (nonatomic, strong, readwrite) NSMutableArray *multopenSectionArray;

@end

@implementation FoldingTableView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

#pragma mark - 创建数据源和代理
- (void)setupDelegateAndDataSource
{
    self.delegate = self;
    self.dataSource = self;
    if (self.style == UITableViewStylePlain) {
        self.tableFooterView = [[UIView alloc] init];
    }
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeStatusBarOrientationNotification:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    self.multopenSectionArray = [NSMutableArray array];
}

- (void)setOpenSectionArray:(NSArray *)openSectionArray {
    _multopenSectionArray = [NSMutableArray arrayWithArray:openSectionArray];
}

- (void)onChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - UI Configration
- (NSString *)titleForSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:titleForHeaderInSection:)]) {
        return [_foldingDelegate foldingTableView:self titleForHeaderInSection:section];
    }
    return [NSString string];
}

- (NSString *)imageForSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:imageForHeaderInSection:)]) {
        return [_foldingDelegate foldingTableView:self imageForHeaderInSection:section];
    }
    return [NSString string];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(numberOfSectionForFoldingTableView:)]) {
        return [_foldingDelegate numberOfSectionForFoldingTableView:self];
    } else {
        return self.numberOfSections;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_multopenSectionArray containsObject:[NSNumber numberWithInteger:section]]) {
        if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:numberOfRowsInSection:)]) {
            return [_foldingDelegate foldingTableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:heightForHeaderInSection:)]) {
        return [_foldingDelegate foldingTableView:self heightForHeaderInSection:section];
    } else {
        return self.sectionHeaderHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:heightForRowAtIndexPath:)]) {
        return [_foldingDelegate foldingTableView:self heightForRowAtIndexPath:indexPath];
    } else {
        return self.rowHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.style == UITableViewStylePlain) {
        return 0;
    } else {
        return 0.001;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FoldingSectionHeader *sectionHeaderView = [[FoldingSectionHeader alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, [self tableView:self heightForHeaderInSection:section]) withTag:section];
    
    [sectionHeaderView setupWithBackgroundColor:[UIColor whiteColor]
                                    titleString:[self titleForSection:section]
                                     titleColor:[UIColor darkTextColor]
                                      titleFont:[UIFont systemFontOfSize:14]
                                    headerImage:[self imageForSection:section]];
    sectionHeaderView.tapDelegate = self;
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:cellForRowAtIndexPath:)]) {
        return [_foldingDelegate foldingTableView:self cellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIndentifier"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:didSelectRowAtIndexPath:)]) {
        [_foldingDelegate foldingTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark - FoldingSectionHeaderDelegate
-(void)foldingSectionHeaderTappedAtIndex:(NSInteger)index
{
    NSNumber *section = [NSNumber numberWithInteger:index];
    if ([_multopenSectionArray containsObject:section]) {
        NSArray *deleteArray = [self buildEditRowsWithSection:index];
        [_multopenSectionArray removeObject:section];
        [self deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [[_multopenSectionArray copy] enumerateObjectsUsingBlock:^(NSNumber *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *otherDeleteArray = [self buildEditRowsWithSection:[obj integerValue]];
            [_multopenSectionArray removeObject:obj];
            [self deleteRowsAtIndexPaths:otherDeleteArray withRowAnimation:UITableViewRowAnimationTop];
        }];
        
        [_multopenSectionArray addObject:section];
        NSArray *insertArray = [self buildEditRowsWithSection:index];
        [self insertRowsAtIndexPaths:insertArray withRowAnimation:UITableViewRowAnimationTop];
        if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(foldingTableView:scrollForHeaderInSection:)]) {
            [_foldingDelegate foldingTableView:self scrollForHeaderInSection:index];
        }
    }
}

- (NSMutableArray *)buildEditRowsWithSection:(NSInteger)section
{
    NSInteger numberOfRow = [_foldingDelegate foldingTableView:self numberOfRowsInSection:section];
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:section]];
        }
    }
    return rowArray;
}

#pragma mark - Inner
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 100;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(- scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(- sectionHeaderHeight, 0, 0, 0);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
