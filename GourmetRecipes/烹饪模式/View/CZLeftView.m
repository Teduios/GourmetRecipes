//
//  CZLeftView.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZLeftView.h"

@interface CZLeftView ()
/** <#属性#> */
@property(nonatomic ,strong)NSArray *steps;
/** <#属性#> */
@property (nonatomic ,assign) NSInteger inter;
@end

@implementation CZLeftView
- (instancetype)initWithArray:(NSArray *)array WithTag:(NSInteger)inter{
    if (self = [super init]) {
        self.steps = array;
        self.inter = inter;

        [self addBackBtn];
        [self addStepDirectory];
        
        [self addTiming];
        
    
    }
    return self;
}

/**
 *  添加返回按钮
 */
- (void)addBackBtn{
    UIButton *backBtn = [[UIButton alloc]init];
    [self addSubview:backBtn];
    __weak typeof(self) weakSelf = self;
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf).with.offset(5);
        make.top.mas_equalTo(weakSelf).with.offset(15);
        make.right.mas_equalTo(weakSelf).with.offset(-5);
        make.width.mas_equalTo(40);
    }];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_h"] forState:UIControlStateHighlighted];
    [backBtn addTarget:self action:@selector(backController) forControlEvents:UIControlEventTouchUpInside];
}
/**
 *  返回按钮点击
 */
- (void)backController{
    [self.delegate leftViewBackController];
}

/**
 *  添加数字按钮
 */
- (void)addStepDirectory{
    for (int i=0; i<self.steps.count; i++) {
        UIButton *button = [[UIButton alloc]init];
        [self addSubview:button];
        button.tag = i+1;
        __weak typeof(self) weakSelf = self;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.mas_equalTo(weakSelf.left).with.offset(15);
            make.top.mas_equalTo(weakSelf.top).with.offset(100+i*25);
        }];
        if (i+1 == self.inter) {

            button.selected = YES;
        }
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];

        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectSteps:) forControlEvents:UIControlEventTouchUpInside];
    
    }

}



/**
 *  添加计时按钮
 */
- (void)addTiming{
    UIView *timingView = [[UIView alloc]init];
    [self addSubview:timingView];
    __weak typeof(self) weakSelf = self;
    [timingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 60));
        make.left.mas_equalTo(weakSelf.left).with.offset(5);
        make.bottom.mas_equalTo(300).with.offset(-10);
        
    }];
    
    UIButton *timingBtn = [[UIButton alloc]init];
    [timingView addSubview:timingBtn];
    
    [timingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.left.mas_equalTo(timingView.left);
        make.top.mas_equalTo(timingView.top);
    }];
    [timingBtn setBackgroundImage:[UIImage imageNamed:@"timing"] forState:UIControlStateNormal];
    [timingBtn setBackgroundImage:[UIImage imageNamed:@"timing_h"] forState:UIControlStateHighlighted];
    [timingBtn addTarget:self action:@selector(startTiming) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *timingLabel = [[UILabel alloc]init];
    [timingView addSubview:timingLabel];
    [timingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 20));
        make.left.mas_equalTo(timingView.left);
        make.bottom.mas_equalTo(timingView.bottom);
    }];
    timingLabel.textAlignment = NSTextAlignmentCenter;
    timingLabel.font = [UIFont systemFontOfSize:15];
    timingLabel.textColor = [UIColor grayColor];
    timingLabel.text = @"计时";
    
    
    
}

/**
 *  开始设置计时
 */
- (void)startTiming{
    [self.delegate leftAddTiming];
}





/**
 *  步骤选择
 */
- (void)selectSteps:(UIButton *)button{
    [self changeSelecteWithInterger:button.tag];

    [self.delegate leftViewShowPageOfClickNumber:button.tag];
    
}
- (void)changeSelecteWithInterger:(NSInteger)interger{
    UIButton *button = [self viewWithTag:interger];
    button.selected = YES;
    for (int i = 0; i<self.steps.count; i++) {
        UIButton *btn = [self viewWithTag:i+1];
        
        if (btn.tag != button.tag) {
            btn.selected = NO;
        }
    }
}


@end
