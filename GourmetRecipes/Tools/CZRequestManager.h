//
//  CZRequestManager.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/5.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CZRecipeModel.h"
#import "CZFoodVarietyModel.h"
#import "CZFoodDetailedModel.h"
//typedef NS_ENUM(NSUInteger, RequestMode) {
//    RequestModeRefresh, //刷新数据
//    RequestModeMore, //获取更多数据
//};
@interface CZRequestManager : NSObject

+ (void)getRecipeModelWithCategory:(NSString *)category AndParams:(NSDictionary *)params completionHandler:(void (^)(CZRecipeRequestModel *model, NSError *error))completionHandler;

+ (void)getFoodVarietyModelWithCategory:(NSString *)category AndParams:(NSDictionary *)params completionHandler:(void (^)(CZVarietyRequestModel *model, NSError *error))completionHandler;

+ (void)getFoodDetailedModelWithCategory:(NSString *)category AndParams:(NSDictionary *)params completionHandler:(void (^)(CZFoodDetailedModel *model, NSError *error))completionHandler;

@end
