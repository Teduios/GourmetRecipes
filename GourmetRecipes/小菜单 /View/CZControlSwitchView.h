//
//  CZControlSwitchView.h
//  ControlSwitchView
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZRecipeModel.h"
@protocol CZControlSwitchViewDelegate <NSObject>

- (void)changeController:(CZRecipeDataModel *)model;

@end

@interface CZControlSwitchView : UIView

/** 导航标题数组 */
@property(nonatomic ,strong)NSArray *titles;

- (instancetype)initWithFrame:(CGRect)frame WithNaviFrame:(CGRect)naviFrame WithTitleSize:(CGSize)titleSize WithTitles:(NSArray *)titles;

/** <#属性#> */
@property(nonatomic ,strong)id<CZControlSwitchViewDelegate> delegate;
@end
