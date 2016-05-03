//
//  CZFoodVarietyModel.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CZFoodVarietyModel,CZFoodVarietyListModel;

@interface CZVarietyRequestModel : NSObject
@property (nonatomic, strong) NSArray<CZFoodVarietyModel *> *result;

@property (nonatomic, copy) NSString *resultcode;

@property (nonatomic, copy) NSString *reason;

@property (nonatomic, assign) NSInteger error_code;

@end



@interface CZFoodVarietyModel : NSObject
/** 大  菜别分组名 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;

@property (nonatomic, strong) NSArray<CZFoodVarietyListModel *> *list;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)varietyWithDict:(NSDictionary *)dict;
@end



@interface CZFoodVarietyListModel : NSObject
//id -> Id
@property (nonatomic, copy) NSString *Id;
/** 小菜别分组名 */
@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *parentId;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)listWithDict:(NSDictionary *)dict;

@end

