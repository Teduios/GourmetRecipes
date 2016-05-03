//
//  NSObject+Parse.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/9.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "NSObject+Parse.h"

@implementation NSObject (Parse)
- (NSString *)description{
    return [self modelDescription];
}
+(id)parseJSON:(id)json{
    if ([json isKindOfClass:[NSDictionary class]]) {
        return [self modelWithDictionary:json];
    }
    if ([json isKindOfClass:[NSArray class]]) {
        return [NSArray modelArrayWithClass:[self class] json:json];
    }
    return json;
}
@end
