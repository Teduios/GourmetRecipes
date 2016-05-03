//
//  CZCollectionViewCell.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZFoodVarietyModel.h"
#import "CZRecipeModel.h"

//typedef void(^SENDPRCIP)(CZRecipeDataModel *);
@protocol CZCollectionViewCellDelegate <NSObject>
- (void)cellDidClick:(CZRecipeDataModel *)model;

@end

@interface CZCollectionViewCell : UICollectionViewCell

/** <#属性#> */
@property(nonatomic ,strong)NSArray *foodListArray;

/** 当前tableView需要显示的菜谱标题 */
@property(nonatomic ,strong)CZFoodVarietyListModel *currentRecipe;

/** cell点击界面跳转 */
/** 代理属性 */
@property(nonatomic ,strong) id<CZCollectionViewCellDelegate> delegate;


//@property(nonatomic ,strong) void(^clickChangeControllerBlock)(CZRecipeDataModel *model) ;
//- (void)changeControllerBlock:(void(^)(CZRecipeDataModel *model)) block;
//@property (nonatomic, copy) SENDPRCIP block;
@end
