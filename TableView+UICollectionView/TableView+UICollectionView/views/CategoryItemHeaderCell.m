//
//  CategoryItemHeaderCell.m
//  Buyer
//
//  Created by bfme on 2017/3/6.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import "CategoryItemHeaderCell.h"

@interface CategoryItemHeaderCell ()
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@end

@implementation CategoryItemHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setHeaderTitle:(NSString *)headerTitle
{
    _headerTitle = headerTitle;
    self.headerLabel.text = headerTitle;
}
@end
