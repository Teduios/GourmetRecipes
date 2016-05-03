//
//  CZRightView.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZRightView.h"
#import "CZStepView.h"
@interface CZRightView ()<UIScrollViewDelegate>
/** 上 */
@property(nonatomic ,strong) UIButton *upBtn;
/** 下 */
@property(nonatomic ,strong)UIButton *downBtn;
/** 步骤数组 */
@property(nonatomic ,strong)NSArray *steps;
/** 滚动视图size */
@property (nonatomic ,assign) CGRect scrollRect;
/** gundong */
@property(nonatomic ,strong)UIScrollView *showRecipeScrollView;
/** <#属性#> */
@property (nonatomic ,assign) NSInteger inter;

@end

@implementation CZRightView

- (instancetype)initWithSteps:(NSArray *)steps WithInterger:(NSInteger)inter{
    if (self = [super init]) {
        self.inter = inter;
     
        self.scrollRect = [[UIScreen mainScreen]bounds];
        self.showRecipeScrollView = [[UIScrollView alloc]init];
        self.upBtn = [[UIButton alloc]init];
        self.downBtn = [[UIButton alloc]init];
        [self addSubview:self.upBtn];
        [self addSubview:self.downBtn];
        
        self.steps = steps;

        if (inter == steps.count) {
            self.downBtn.backgroundColor = [UIColor clearColor];
            self.downBtn.hidden = YES;
        }
        if (inter == 1) {
            self.upBtn.backgroundColor = [UIColor clearColor];
            self.upBtn.hidden = YES;
        }
        [self.upBtn addTarget:self action:@selector(recipeScrollUp) forControlEvents:UIControlEventTouchUpInside];
        [self.downBtn addTarget: self action:@selector(recipeScrollDown) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:self.showRecipeScrollView];
        __weak typeof(self) weakSelf = self;
        [weakSelf.showRecipeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(weakSelf).sizeOffset(CGSizeMake(-40, -200));
            make.top.mas_equalTo(weakSelf.top).with.offset(80);
            make.centerX.equalTo(weakSelf);
        }];
        
        
        self.showRecipeScrollView.showsHorizontalScrollIndicator = NO;
        self.showRecipeScrollView.showsVerticalScrollIndicator = NO;
        self.showRecipeScrollView.contentSize = CGSizeMake(self.showRecipeScrollView.width, (self.scrollRect.size.height-200)*steps.count);
        self.showRecipeScrollView.bounces = NO;
        self.showRecipeScrollView.pagingEnabled = YES;

        self.showRecipeScrollView.delegate = self;
        
        
        [self.upBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.top.mas_equalTo(weakSelf.top).with.offset(20);
            make.centerX.mas_equalTo(weakSelf.centerX);
        }];
        [self.upBtn setBackgroundImage:[UIImage imageNamed:@"previous"] forState:UIControlStateNormal];
        [self.upBtn setBackgroundImage:[UIImage imageNamed:@"previous_h"] forState:UIControlStateHighlighted];
        
        [self.downBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.bottom.mas_equalTo(weakSelf.bottom).with.offset(-60);
            make.centerX.mas_equalTo(weakSelf.centerX);
        }];
        [self.downBtn setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [self.downBtn setBackgroundImage:[UIImage imageNamed:@"next_h"] forState:UIControlStateHighlighted];

        [self addShowRecipeStepView];

    }
    return self;
}
/**
 *  左视图按钮点击
 */
- (void)showNumberpage:(NSInteger)numpage{
    
    self.showRecipeScrollView.contentOffset = CGPointMake(0, (numpage-1) *self.showRecipeScrollView.height);
    
}

/**
 *  向上滚
 */
- (void)recipeScrollUp{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.showRecipeScrollView.contentOffset = CGPointMake(0, (self.inter- 2)*self.showRecipeScrollView.height);
    }];
    
}
/**
 *  向下滚
 */
- (void)recipeScrollDown{

    [UIView animateWithDuration:0.2 animations:^{
        self.showRecipeScrollView.contentOffset = CGPointMake(0, self.inter*self.showRecipeScrollView.height);
    }];
    
}

- (void)addShowRecipeStepView{
    for (int i = 0; i<self.steps.count; i++) {
        
        
        CZStepView *stepView = [[CZStepView alloc]initWithSteps:self.steps[i]];
        
        [self.showRecipeScrollView addSubview:stepView];
        
        [stepView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.equalTo(self.showRecipeScrollView);

            make.centerX.mas_equalTo(self.showRecipeScrollView.centerX);
            make.centerY.mas_equalTo(self.showRecipeScrollView.centerY).with.offset(i*(self.scrollRect.size.height-200));
        }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

        NSInteger inter = self.inter;
        
        self.inter = round(1.0 * scrollView.contentOffset.y/(self.scrollRect.size.height -200))+1;
        
        if (self.inter != inter) {
            [self.delegate rightViewChangeLeftViewBtnSelectdeWithInterger:self.inter];
        }
        if (self.inter == 1) {
            self.upBtn.hidden = YES;
            self.downBtn.hidden = NO;
        }else if (self.inter == self.steps.count) {
            self.downBtn.hidden = YES;
            self.upBtn.hidden = NO;
        }else {
            self.downBtn.hidden = NO;
            self.upBtn.hidden = NO;
        }

}


@end
