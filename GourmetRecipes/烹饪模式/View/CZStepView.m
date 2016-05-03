//
//  CZStepView.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZStepView.h"
#import "CZRecipeModel.h"
@implementation CZStepView

- (instancetype)initWithSteps:(CZRecipeStepsModel *)model{
    if (self = [super init]) {
        UIImageView *stepImageView = [[UIImageView alloc]init];
        [self addSubview:stepImageView];
        stepImageView.layer.cornerRadius = 5;
        //    stepImageView.clipsToBounds = YES;
        stepImageView.contentMode = UIViewContentModeScaleAspectFit;
        [stepImageView.layer setMasksToBounds:YES];
        [stepImageView sd_setImageWithURL:[NSURL URLWithString:model.img]];
        

        UILabel *stepLabel = [[UILabel alloc]init];
        [self addSubview:stepLabel];
        stepLabel.numberOfLines = 0;
        stepLabel.font = [UIFont systemFontOfSize:13];
        stepLabel.textAlignment = NSTextAlignmentCenter;
        stepLabel.text = model.step;

        __weak typeof(self) weakSelf = self;
        [stepImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf).sizeOffset(CGSizeMake(0, -170));
            make.top.mas_equalTo(weakSelf.top);
            make.left.mas_equalTo(weakSelf.left);
            
        }];
        [stepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf);
            make.height.mas_equalTo(170);
            make.left.mas_equalTo(weakSelf.left);
            make.bottom.mas_equalTo(weakSelf.bottom);
        }];
        
        
    }
    return self;
}






@end
