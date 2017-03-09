//
//  FoldingSectionHeader.m
//  Buyer
//
//  Created by bfme on 2017/3/3.
//  Copyright © 2017年 baifumei. All rights reserved.
//

#import "FoldingSectionHeader.h"
#import "UIImageView+WebCache.h"

#define FoldingSepertorLineWidth       1.0f
#define FoldingMargin                  8.0f
#define FoldingIconSize                24.0f

@interface FoldingSectionHeader ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) CAShapeLayer *sepertorLine;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation FoldingSectionHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = tag;
        [self setupSubviews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupSubviews];
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _headerImageView.backgroundColor = [UIColor clearColor];
        _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImageView.clipsToBounds = YES;
    }
    return _headerImageView;
}

-(CAShapeLayer *)sepertorLine
{
    if (!_sepertorLine) {
        _sepertorLine = [CAShapeLayer layer];
        _sepertorLine.strokeColor = [UIColor whiteColor].CGColor;
        _sepertorLine.lineWidth = FoldingSepertorLineWidth;
    }
    return _sepertorLine;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapped:)];
    }
    return _tapGesture;
}

- (UIBezierPath *)getSepertorPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, self.frame.size.height - FoldingSepertorLineWidth)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height - FoldingSepertorLineWidth)];
    return path;
}

- (void)setupWithBackgroundColor:(UIColor *)backgroundColor
                    titleString:(NSString *)titleString
                     titleColor:(UIColor *)titleColor
                      titleFont:(UIFont *)titleFont
                    headerImage:(NSString *)headerImage
{
    [self setBackgroundColor:backgroundColor];
    
    [self setupSubviews];
    
    self.titleLabel.text = titleString;
    self.titleLabel.textColor = titleColor;
    self.titleLabel.font = titleFont;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:headerImage] placeholderImage:[UIImage imageNamed:@"place_2"]];
}

- (void)setupSubviews
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    [self.titleLabel setFrame:CGRectMake(50, (height-30)/2, width-100, 30)];
    [self.headerImageView setFrame:CGRectMake(0, 0, width, height-1)];
    [self.sepertorLine setPath:[self getSepertorPath].CGPath];
    
    [self addSubview:self.headerImageView];
    [self addSubview:self.titleLabel];
    [self addGestureRecognizer:self.tapGesture];
    [self.layer addSublayer:self.sepertorLine];
}

- (void)onTapped:(UITapGestureRecognizer *)gesture
{
    if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(foldingSectionHeaderTappedAtIndex:)]) {
        [_tapDelegate foldingSectionHeaderTappedAtIndex:self.tag];
    }
}


@end
