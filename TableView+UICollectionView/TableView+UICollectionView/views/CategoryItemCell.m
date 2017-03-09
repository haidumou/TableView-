//
//  CategoryItemCell.m
//  Buyer
//
//  Created by bfme on 2017/3/6.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import "CategoryItemCell.h"
#import "UIImageView+WebCache.h"

@interface CategoryItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@end

@implementation CategoryItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(ThirdCateforyModel *)model
{
    _model = model;
    [self.categoryImageView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"place_1"]];
    self.categoryNameLabel.text = model.name;
}
@end
