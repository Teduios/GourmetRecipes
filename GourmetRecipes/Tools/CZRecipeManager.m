//
//  CZRecipeManager.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/12.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZRecipeManager.h"

@implementation CZRecipeManager
+ (instancetype)shareManager{
    static CZRecipeManager *manager;

    return manager;
    
}
@end
