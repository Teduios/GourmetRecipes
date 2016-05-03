//
//  CZShowRecipeViewController.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZRecipeModel.h"
@interface CZShowRecipeViewController : UIViewController
/** 接收到的需要现显示的菜谱模型 */
@property(nonatomic ,strong)CZRecipeDataModel *model;
@end
