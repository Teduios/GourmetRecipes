//
//  CZListCollectionViewCell.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZListCollectionViewCell.h"

@implementation CZListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        CGFloat iconX = 5;
        CGFloat iconY = 5;
        CGFloat iconW = frame.size.width -iconX*2;
        CGFloat iconH = 1.0 *iconW *2/3;

        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(iconX, iconY , iconW, iconH)];
        self.iconImageView.layer.borderWidth = 2;
        self.iconImageView.layer.borderColor = kColorRGB(124, 28, 45, 0.9).CGColor;
        self.iconImageView.layer.cornerRadius = 8;
        self.iconImageView.clipsToBounds = YES;


        [self.contentView addSubview:self.iconImageView];
        
        CGFloat listX = 5;
        CGFloat listY = CGRectGetMaxY(self.iconImageView.frame)+5;
        CGFloat listW = iconW;
        CGFloat listH = frame.size.height - listY;
        self.listNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(listX, listY, listW, listH)];
        self.listNameLabel.backgroundColor = [UIColor clearColor];
        self.listNameLabel.textAlignment = NSTextAlignmentCenter;
        self.listNameLabel.font = [UIFont systemFontOfSize:16];
        self.listNameLabel.textColor = kColorRGB(124, 28, 45, 1);
        [self.contentView addSubview:self.listNameLabel];
        
    }
    return self;
}



@end
