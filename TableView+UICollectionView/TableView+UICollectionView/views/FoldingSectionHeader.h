//
//  FoldingSectionHeader.h
//  Buyer
//
//  Created by bfme on 2017/3/3.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoldingSectionHeaderDelegate <NSObject>

- (void)foldingSectionHeaderTappedAtIndex:(NSInteger)index;

@end

@interface FoldingSectionHeader : UIView

@property (nonatomic, weak) id<FoldingSectionHeaderDelegate> tapDelegate;

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag;

-(void)setupWithBackgroundColor:(UIColor *)backgroundColor
                    titleString:(NSString *)titleString
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
                    headerImage:(NSString *)headerImage;
@end
