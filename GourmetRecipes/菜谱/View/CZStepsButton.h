//
//  CZStepsButton.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZRecipeStepsModel;

@interface CZStepsButton : UIButton

- (instancetype)initWithFrame:(CGRect)frame With:(CZRecipeStepsModel *)model ;

@end
