//
//  CZRecipeScrollView.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZRecipeModel.h"

@protocol CZRecipeScrollViewDelegate <NSObject>
- (void)stepsButtonClick:(NSArray <CZRecipeStepsModel*>*)array AndButtonTag:(NSInteger)inter;
- (void)addToFavourite;

@end

@interface CZRecipeScrollView : UIScrollView
/** 显示菜名标签 */
@property(nonatomic ,strong)UILabel *titleLabel;
/** 菜品介绍的标签 */
@property(nonatomic ,strong)UILabel *imtroLabel;
/** 显示的模型数据 */
@property(nonatomic ,strong)CZRecipeDataModel *model;
- (instancetype)initWithFrame:(CGRect)frame WithModel:(CZRecipeDataModel *)model WithHeadSize:(CGSize)size WithNaviSize:(CGSize)naviSize;
@property(nonatomic ,strong)void(^backScrollSizeVertical)(CGFloat Y) ;

/** <#属性#> */
@property(nonatomic ,weak)id<CZRecipeScrollViewDelegate> recipeDelegate;
@end
