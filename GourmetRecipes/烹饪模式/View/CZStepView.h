//
//  CZStepView.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/16.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZRecipeStepsModel;
@interface CZStepView : UIView
- (instancetype)initWithSteps:(CZRecipeStepsModel *)model;
@end
