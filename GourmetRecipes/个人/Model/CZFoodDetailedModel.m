//
//  CZFoodDetailedModel.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZFoodDetailedModel.h"

@implementation CZFoodDetailedModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"errorCode":@"error_code"};
}
@end
@implementation CZFoodDetailedResultModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"Id":@"id",
             @"desc":@"description"};
}
@end


