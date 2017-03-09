//
//  TopViewController.m
//  TableView+UICollectionView
//
//  Created by bfme on 2017/3/9.
//  Copyright © 2017年 BFMe. All rights reserved.
//

#import "TopViewController.h"
#import "FoldingTableView.h"
#import "CategoryTableViewCell.h"
#import "DataSource.h"

#define  kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface TopViewController () <FoldingTableViewDelegate>
@property (nonatomic, strong) FoldingTableView *foldingTableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTableView];

    [self prepareData];
}

- (void)prepareData
{
    DataSource *source =[[DataSource alloc] init];
    self.dataSource = source.dataArray;
    [self.foldingTableView reloadData];
}

-(void)createTableView
{
    self.foldingTableView = [[FoldingTableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    [self.view addSubview:self.foldingTableView];
    self.foldingTableView.foldingDelegate = self;
    self.foldingTableView.openSectionArray = [NSArray arrayWithObject:@0];
}

- (NSString *)foldingTableView:(FoldingTableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CategoryModel *model = self.dataSource[section];
    return model.name;
}

- (NSString *)foldingTableView:(FoldingTableView *)tableView imageForHeaderInSection:(NSInteger)section
{
    //    CategoryModel *model = self.dataSource[section];
    //    return model.icon;
    return @"http://img01.baifomi.com//temp/image/20170307/6362448085230371091349317.jpg";
}

- (NSInteger)numberOfSectionForFoldingTableView:(FoldingTableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)foldingTableView:(FoldingTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CategoryModel *model = self.dataSource[section];
    return model.array.count;
}

- (CGFloat)foldingTableView:(FoldingTableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)foldingTableView:(FoldingTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = kScreenWidth / 5;
    CategoryModel *model = self.dataSource[indexPath.section];
    SecCategoryModel *secModel = model.array[indexPath.row];
    NSInteger num = secModel.array.count / 5;
    if (secModel.array.count % 5 == 0) {
        return num * width + 40;
    } else {
        return (num + 1) * width + 40;
    }
    return 44;
}

- (UITableViewCell *)foldingTableView:(FoldingTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    CategoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[CategoryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    CategoryModel *model = self.dataSource[indexPath.section];
    SecCategoryModel *secModel = model.array[indexPath.row];
    cell.model = secModel;
    cell.block = ^(ThirdCateforyModel *thirdModel) {
        NSLog(@"三级分类名称：%@", thirdModel.name);
    };
    return cell;
}

- (void)foldingTableView:(FoldingTableView *)tableView scrollForHeaderInSection:(NSInteger)section
{
    if (section == self.dataSource.count-1) {
        NSInteger rowCount = [tableView numberOfRowsInSection:section];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowCount-1 inSection:section];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    } else {
        [tableView setContentOffset:CGPointMake(0, 100*section) animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
