//
//  CZRecipeModel.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZRecipeModel.h"
@implementation CZRecipeRequestModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"resultCode":@"resultcode",
             @"errorCode":@"error_code"};
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}


@end

@implementation CZRecipeResultModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

@end

@implementation CZRecipeDataModel
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"Id":@"id"};
}

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}



+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.albums forKey:@"albums"];
    [aCoder encodeObject:self.burden forKey:@"burden"];
    [aCoder encodeObject:self.imtro forKey:@"imtro"];
    [aCoder encodeObject:self.Id forKey:@"Id"];
    [aCoder encodeObject:self.ingredients forKey:@"ingredients"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.steps forKey:@"steps"];
    [aCoder encodeObject:self.tags forKey:@"tags"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.burden =[aDecoder decodeObjectForKey:@"burden"];
        self.albums = [aDecoder decodeObjectForKey:@"albums"];
        self.imtro = [aDecoder decodeObjectForKey:@"imtro"];
        self.Id = [aDecoder decodeObjectForKey:@"Id"];
        self.ingredients = [aDecoder decodeObjectForKey:@"ingredients"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.steps = [aDecoder decodeObjectForKey:@"steps"];
        self.tags = [aDecoder decodeObjectForKey:@"tags"];
    }
    return self;
}


@end

@implementation CZRecipeStepsModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.img forKey:@"img"];
    [aCoder encodeObject:self.step forKey:@"step"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.img = [aDecoder decodeObjectForKey:@"img"];
        self.step = [aDecoder decodeObjectForKey:@"step"];
    }
    return self;
}
@end











