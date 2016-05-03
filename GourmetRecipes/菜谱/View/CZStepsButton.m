//
//  CZStepsButton.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZStepsButton.h"
#import "CZRecipeModel.h"
@interface CZStepsButton ()
/** 模型属性 */
@property(nonatomic ,strong)CZRecipeStepsModel *model;

/** 图片显示 */
@property (nonatomic ,strong)UIImageView *stepImageView;

/** 步骤 */
@property(nonatomic ,strong)UILabel  *stepLabel;



@end

@implementation CZStepsButton

- (instancetype)initWithFrame:(CGRect)frame With:(CZRecipeStepsModel *)model{
    if (self = [super init]) {

        CGSize size = [model.step boundingRectWithSize:CGSizeMake(frame.size.width -10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
        
        self.stepLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, size.height)];
        self.stepLabel.text = model.step;
        self.stepLabel.backgroundColor = kBgColor;
        self.stepLabel.font = [UIFont systemFontOfSize: 13];
        self.stepLabel.numberOfLines = 0;
        [self addSubview:self.stepLabel];
        
        
        self.stepImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.stepLabel.frame.size.height, frame.size.width, frame.size.height)];
        self.stepImageView.layer.cornerRadius = 5;
        [self.stepImageView.layer setMasksToBounds:YES];
        self.stepImageView.clipsToBounds = YES;
        self.stepImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.stepImageView];
        [self.stepImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"defaultsPic"]];
        

        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, CGRectGetMaxY(self.stepImageView.frame));

    }
    return self;
}


@end
