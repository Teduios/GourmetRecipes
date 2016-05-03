//
//  CZRecipeModel.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CZRecipeResultModel,CZRecipeDataModel,CZRecipeStepsModel;
@interface CZRecipeRequestModel : NSObject

@property (nonatomic, strong) NSDictionary *result;
//resultcode->resultCode
@property (nonatomic, copy) NSString *resultCode;

@property (nonatomic, copy) NSString *reason;
//error_code -> errorCode
@property (nonatomic, assign) NSInteger errorCode;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end



//{"resultcode":"200","reason":"Success","result":{"data":[{"id":"909","title":"泰式柠檬蒸鲈鱼","tags":"家常菜;私房菜;海鲜类;美容;瘦身;健脾开胃;护肝;老年人;运动员;骨质疏松;辣;蒸;简单;抗疲劳;鲜;香;孕妇;消化不良;开胃;减肥;柠檬味;补水;补钙;促消化;祛斑;产妇;1-2人;生津止渴;肥胖;养肝护肝;补肝;蒸锅;中等难度;鲈;保湿;增高;晕车","imtro":"菜谱来自电视节目：中华美食频道的《千味坊》 JIMMY老师教的菜，都是一些简单又美味的家常菜，这几天每天中午12点都会收看他的节目。 JIMMY@interface Result : NSObject
@interface CZRecipeResultModel : NSObject

@property (nonatomic, copy) NSString *totalNum;

@property (nonatomic, strong) NSArray<CZRecipeDataModel *> *data;

@property (nonatomic, copy) NSString *pn;

@property (nonatomic, copy) NSString *rn;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;

@end

@interface CZRecipeDataModel : NSObject<NSCoding>
/** 配料 */
@property (nonatomic, copy) NSString *burden;
/** 图片Url数组 */
@property (nonatomic, strong) NSArray<NSString *> *albums;
/** 描述 */
@property (nonatomic, copy) NSString *imtro;
//id -> Id
@property (nonatomic, copy) NSString *Id;
/** 主要食材 */
@property (nonatomic, copy) NSString *ingredients;
/** 菜名 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray<CZRecipeStepsModel *> *steps;
/** 标签 */
@property (nonatomic, copy) NSString *tags;


- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end
@interface CZRecipeStepsModel : NSObject<NSCoding>
/** 标签 */
@property (nonatomic, copy) NSString *img;
/** 步骤 */
@property (nonatomic, copy) NSString *step;



- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)ModelWithDict:(NSDictionary *)dict;
@end




