//
//  CZRecipSubListViewController.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZRecipeModel.h"
@interface CZRecipSubListViewController : UIViewController

/** <#属性#> */
@property(nonatomic ,assign)NSArray *VarietyListArray;

/** 标题 */
@property (nonatomic ,copy) NSString *recipeTitle;

@end
