//
//  DataSource.m
//  TableView+UICollectionView
//
//  Created by bfme on 2017/3/9.
//  Copyright © 2017年 BFMe. All rights reserved.
//

#import "DataSource.h"
#import "CategoryModel.h"

@implementation DataSource

- (instancetype)init
{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    NSString *cityFilePath = [[NSBundle mainBundle] pathForResource:@"category" ofType:@"json"];
    if (!cityFilePath) {
        return;
    }
    NSData *data = [[NSData alloc] initWithContentsOfFile:cityFilePath];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = dictionary[@"Category"];
    
    NSMutableArray *dataSource = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        CategoryModel *model = [[CategoryModel alloc] init];
        model.catId = dict[@"Id"];
        model.name = dict[@"Name"];
        model.icon = dict[@"Icon"];
        model.array = [self secArrayFromArray:dict[@"SubCategory"]];
        
        [dataSource addObject:model];
    }
    
    self.dataArray = dataSource;
}

- (NSMutableArray *)secArrayFromArray:(NSArray *)array
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        SecCategoryModel *model = [[SecCategoryModel alloc] init];
        model.catId = dict[@"Id"];
        model.name = dict[@"Name"];
        model.icon = dict[@"Icon"];
        model.array = [self thirdArrayFromArray:dict[@"SubCategory"]];
        [dataArray addObject:model];
    }
    
    return dataArray;
}

- (NSMutableArray *)thirdArrayFromArray:(NSArray *)array
{
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        ThirdCateforyModel *model = [[ThirdCateforyModel alloc] init];
        model.catId = dict[@"Id"];
        model.name = dict[@"Name"];
        model.icon = dict[@"Icon"];
        [dataArray addObject:model];
    }
    return dataArray;
}


@end
