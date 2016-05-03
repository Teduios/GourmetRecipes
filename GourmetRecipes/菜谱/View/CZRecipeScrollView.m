//
//  CZRecipeScrollView.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 zcz. All rights reserved.
//


#import "CZRecipeScrollView.h"
#import "NSString+BreakUp.h"
#import "CZIngredientsView.h"
#import "CZStepsButton.h"
@interface CZRecipeScrollView ()

/** 上一个视图的下边线位置 */
@property (nonatomic ,assign) CGFloat Y;
/** 步骤数组 */
@property(nonatomic ,strong)NSArray *steps;
@end

@implementation CZRecipeScrollView

#pragma mark - 懒加载
- (NSArray *)steps{
    if (_steps == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in self.model.steps) {
            CZRecipeStepsModel *step = [CZRecipeStepsModel ModelWithDict:dict];
            [array addObject:step];
        }
        _steps = array;
    }
    return _steps;
}


#pragma mark - 方法
- (instancetype)initWithFrame:(CGRect)frame WithModel:(CZRecipeDataModel *)model WithHeadSize:(CGSize)size WithNaviSize:(CGSize)naviSize{
    if (self = [super initWithFrame:frame]) {
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.model = model;
        [self addTitleLabelWithSize:size WithNaviSize:(CGSize)naviSize];
        [self addImtroLabel];
        [self addinfredientsView];
        [self addMakeRecipeSteps:self.steps];
        

        

    }
    return self;
}

/**
 *  添加菜名标签
 */
- (void)addTitleLabelWithSize:(CGSize)size WithNaviSize:(CGSize)naviSize{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, size.height, naviSize.width, naviSize.height)];
    [self addSubview:self.titleLabel];
    
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.text = self.model.title;
    self.titleLabel.backgroundColor = kBgColor;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

    UIButton *collecBtn = [[UIButton alloc]initWithFrame:CGRectMake(naviSize.width- 50, self.titleLabel.frame.origin.y+3, 40, 40)];
    [self addSubview:collecBtn];
    [collecBtn setBackgroundImage:[UIImage imageNamed:@"shoucang"] forState:UIControlStateNormal];
    [collecBtn setBackgroundImage:[UIImage imageNamed:@"shoucang_h"] forState:UIControlStateHighlighted];
    [collecBtn addTarget:self action:@selector(addCollection) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSeparatedViewWithY:CGRectGetMaxY(self.titleLabel.frame)];//添加分割省略号
    
}
/**
 *  收藏按钮点击
 */
- (void)addCollection{
    [self.recipeDelegate addToFavourite];

}



/**
 *  菜品介绍
 */
- (void)addImtroLabel{
    
    NSString *contenStr = [@"    " stringByAppendingString:self.model.imtro];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    CGSize strSize = [contenStr boundingRectWithSize:CGSizeMake(self.frame.size.width-kSeparated*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame)+kSeparated, self.frame.size.width, strSize.height+kSeparated*2)];
    view.backgroundColor = kBgColor;
    
    
    self.imtroLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSeparated, kSeparated, strSize.width, strSize.height)];
    self.imtroLabel.numberOfLines = 0;
    self.imtroLabel.font = [UIFont systemFontOfSize:13];
    self.imtroLabel.text = contenStr;
    self.imtroLabel.backgroundColor = kBgColor;
    [self addSubview:view];
    [view addSubview:self.imtroLabel];
    self.Y = CGRectGetMaxY(view.frame);
    [self addSeparatedViewWithY:CGRectGetMaxY(view.frame)];
}
/**
 *  添加素材
 */
- (void)addinfredientsView{
    NSDictionary *dict = [NSString stringBreakUpString:self.model.burden];
    
    CZIngredientsView *infredientsView = [[CZIngredientsView alloc]initWithFrame:CGRectMake(0, self.Y, self.frame.size.width+kSeparated, kCellHeight *(dict.count+3)) With:dict WithMainIngredient:self.model.ingredients];
    [self addSubview:infredientsView];
    self.Y = CGRectGetMaxY(infredientsView.frame);
    [self addSeparatedViewWithY:self.Y];
    
}

/**
 *  显示步骤
 */
- (void)addMakeRecipeSteps:(NSArray *)steps{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.Y, self.frame.size.width, 60)];
    view.backgroundColor = kBgColor;
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSeparated, kSeparated, self.frame.size.width- kSeparated*2, 20 )];
    titleLabel.text = @"烹饪步骤";
    titleLabel.backgroundColor = kBgColor;
    
    
    UILabel *detaiLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSeparated, CGRectGetMaxY(titleLabel.frame), self.frame.size.width- kSeparated*2, 20 )];
    detaiLabel.text = @"点击步骤进入烹饪模式";
    detaiLabel.backgroundColor = kBgColor;
    detaiLabel.font = [UIFont systemFontOfSize:12];
    [view addSubview:detaiLabel];
    [view addSubview:titleLabel];
    [self addSubview:view];
    self.Y = CGRectGetMaxY(view.frame);

    
    UIView *subBtnView = [[UIView alloc]init];
    subBtnView.backgroundColor = kBgColor;
    [self addSubview:subBtnView];
    
    
    CGFloat startY = self.Y;
    CGFloat btnY  = 0;
    for (int i = 0; i<steps.count; i++) {
        CZStepsButton *stepsButton = [[CZStepsButton alloc]initWithFrame:CGRectMake( 50, btnY, self.frame.size.width - 20-50, self.frame.size.width- 70)With:steps[i]];
        
        btnY = CGRectGetMaxY(stepsButton.frame);
        [subBtnView addSubview:stepsButton];
        stepsButton.tag = i+1;
        [stepsButton addTarget:self action:@selector(gotoCokingMode:) forControlEvents:UIControlEventTouchUpInside];

        if (i == steps.count-1 ) {
            self.Y = self.Y+btnY;
            subBtnView.frame = CGRectMake(0, startY, self.frame.size.width, self.Y - startY);
            self.contentSize = CGSizeMake(self.frame.size.width, self.Y);
        }

    }

}

/**
 *  分割省略号
 */
- (void)addSeparatedViewWithY:(CGFloat)Y{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Y, self.frame.size.width, kSeparated)];
    label.textColor = kColorRGB(150, 150, 150, 1);
    label.backgroundColor = kBgColor;
    label.font = [UIFont systemFontOfSize:25];
    label.text = @" · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ";
    label.textAlignment = NSTextAlignmentCenter;
    self.Y = CGRectGetMaxY(label.frame);
    [self addSubview:label];
}

/**
 *  进入烹饪模式
 */
- (void)gotoCokingMode:(UIButton *)button{
    [self.recipeDelegate stepsButtonClick:self.steps AndButtonTag:button.tag];
    
}


@end
