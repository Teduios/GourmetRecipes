//
//  CZFoodDetailedModel.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CZFoodDetailedResultModel;
@interface CZFoodDetailedModel : NSObject

@property (nonatomic, strong) CZFoodDetailedResultModel *result;
//error_code -> errorCode
@property (nonatomic, assign) NSInteger errorCode;

@property (nonatomic, copy) NSString *reason;

@end
@interface CZFoodDetailedResultModel : NSObject
//id ->Id
@property (nonatomic, assign) NSInteger Id;
//description -> desc
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) NSInteger fcount;

@property (nonatomic, copy) NSString *message;

@property (nonatomic, copy) NSString *disease;

@property (nonatomic, copy) NSString *food;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, copy) NSString *summary;

@property (nonatomic, copy) NSString *keywords;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger rcount;

@end

