//
//  CZCokingViewController.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZRecipeStepsModel;
@interface CZCokingViewController : UIViewController
/** 步骤数组 */
@property(nonatomic ,strong)NSArray<CZRecipeStepsModel*> *steps;
/** <#属性#> */
@property (nonatomic ,assign) NSInteger inter;
@end
