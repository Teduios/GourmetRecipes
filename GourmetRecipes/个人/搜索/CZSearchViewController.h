//
//  CZSearchViewController.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZFoodDetailedModel.h"
@interface CZSearchViewController : UIViewController
/** 模型 */
@property(nonatomic ,strong)CZFoodDetailedModel *model;

/** searchBar */
@property(nonatomic ,strong)UISearchBar *bar;
@end
