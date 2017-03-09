//
//  CategoryTableViewCell.h
//  Buyer
//
//  Created by bfme on 2017/3/9.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

typedef void(^CategoryTableViewCellBlock)(ThirdCateforyModel *thirdModel);

@interface CategoryTableViewCell : UITableViewCell

@property (nonatomic, strong) SecCategoryModel *model;

@property (nonatomic, copy) CategoryTableViewCellBlock block;

@end
