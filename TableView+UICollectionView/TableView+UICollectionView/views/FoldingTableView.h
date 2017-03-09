//
//  FoldingTableView.h
//  Buyer
//
//  Created by bfme on 2017/3/3.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoldingSectionHeader.h"

@class FoldingTableView;

@protocol FoldingTableViewDelegate <NSObject>

// header文字、图片定制
- (NSString *)foldingTableView:(FoldingTableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString *)foldingTableView:(FoldingTableView *)tableView imageForHeaderInSection:(NSInteger)section;


- (NSInteger)numberOfSectionForFoldingTableView:(FoldingTableView *)tableView;
- (NSInteger)foldingTableView:(FoldingTableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (CGFloat)foldingTableView:(FoldingTableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)foldingTableView:(FoldingTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCell *)foldingTableView:(FoldingTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)foldingTableView:(FoldingTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

// add
- (void)foldingTableView:(FoldingTableView *)tableView scrollForHeaderInSection:(NSInteger)section;

@end

@interface FoldingTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) id<FoldingTableViewDelegate> foldingDelegate;
@property (nonatomic, copy, readwrite) NSArray *openSectionArray;

@end
