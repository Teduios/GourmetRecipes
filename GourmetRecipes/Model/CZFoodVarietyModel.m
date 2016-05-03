//
//  CZFoodVarietyModel.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZFoodVarietyModel.h"

@implementation CZVarietyRequestModel


@end

@implementation CZFoodVarietyModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)varietyWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}


@end

@implementation CZFoodVarietyListModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"Id":@"id"};
}
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)listWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end





