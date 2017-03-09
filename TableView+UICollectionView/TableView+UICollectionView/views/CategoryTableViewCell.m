//
//  CategoryTableViewCell.m
//  Buyer
//
//  Created by bfme on 2017/3/9.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import "CategoryTableViewCell.h"
#import "CategoryItemHeaderCell.h"
#import "CategoryItemCell.h"

#define  kScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface CategoryTableViewCell () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *itemCollectionView;
    UICollectionViewFlowLayout *layout;
}
@end

NSString *const CategoryItemHeaderCellIdentifier = @"CategoryItemHeaderCellIdentifier";
NSString *const CategoryItemCellIdentifier = @"CategoryItemCellIdentifier";

@implementation CategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        CGFloat width = kScreenWidth/5;
        layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(width, width);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        itemCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height) collectionViewLayout:layout];
        itemCollectionView.delegate = self;
        itemCollectionView.dataSource = self;
        //        itemCollectionView.backgroundColor = FMHex(0xEEEEEE);
        itemCollectionView.backgroundColor = [UIColor whiteColor];
        itemCollectionView.scrollEnabled = NO;
        
        [itemCollectionView registerNib:[UINib nibWithNibName:@"CategoryItemCell" bundle:nil] forCellWithReuseIdentifier:CategoryItemCellIdentifier];
        [itemCollectionView registerNib:[UINib nibWithNibName:@"CategoryItemHeaderCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CategoryItemHeaderCellIdentifier];
        
        [self addSubview:itemCollectionView];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [itemCollectionView setFrame:CGRectMake(0, 0, kScreenWidth, self.frame.size.height)];
}

- (void)setModel:(SecCategoryModel *)model
{
    _model = model;
    [itemCollectionView reloadData];
}

#pragma mark - collectionViewDelegate & dataSourse
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.model.array.count;
}

-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 35);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        CategoryItemHeaderCell *cell = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CategoryItemHeaderCellIdentifier forIndexPath:indexPath];
        cell.headerTitle = self.model.name;
        return cell;
    }
    return nil;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CategoryItemCellIdentifier forIndexPath:indexPath];
    ThirdCateforyModel *thirdModel = self.model.array[indexPath.item];
    cell.model = thirdModel;

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ThirdCateforyModel *thirdModel = self.model.array[indexPath.item];
    if (self.block) {
        self.block(thirdModel);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
