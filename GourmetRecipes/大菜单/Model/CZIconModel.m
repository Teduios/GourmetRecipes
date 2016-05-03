//
//  CZIconModel.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZIconModel.h"

@implementation CZIconModel
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.iconUrl = dict[[[dict allKeys]lastObject]];
    }
    return self;
}
@end
