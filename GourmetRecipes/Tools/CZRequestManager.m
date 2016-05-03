//
//  CZRequestManager.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/5.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZRequestManager.h"
#import "NSObject+request.h"
#import "NSObject+Parse.h"
#import "CZStrConnectManager.h"

@implementation CZRequestManager

+ (void)getRecipeModelWithCategory:(NSString *)category AndParams:(NSDictionary *)params completionHandler:(void (^)( CZRecipeRequestModel *, NSError *))completionHandler{
    NSString *path = [CZStrConnectManager serializeURL:category params:params];
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError * error) {

        completionHandler([CZRecipeRequestModel parseJSON:responseObj],error);
    }];
}
+ (void)getFoodVarietyModelWithCategory:(NSString *)category AndParams:(NSDictionary *)params completionHandler:(void (^)(CZVarietyRequestModel *, NSError *))completionHandler{
    NSString *path = [CZStrConnectManager serializeURL:category params:params];
    
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError * error) {
        
        completionHandler([CZVarietyRequestModel parseJSON:responseObj],error);
    }];
}

+ (void)getFoodDetailedModelWithCategory:(NSString *)category AndParams:(NSDictionary *)params completionHandler:(void (^)(CZFoodDetailedModel *, NSError *))completionHandler{
    NSString *path = [CZStrConnectManager serializeURL:category params:params];
    
    [self GET:path parameters:nil progress:nil completionHandler:^(id responseObj, NSError * error) {
        
        completionHandler([CZFoodDetailedModel parseJSON:responseObj],error);
    }];
}




@end
