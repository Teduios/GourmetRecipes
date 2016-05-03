//
//  NSObject+request.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/5.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (request)

+ (id)GET:(NSString *)path parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id responseObj, NSError *))completionHandler;

+ (id)POST:(NSString *)path parameters:(NSDictionary *)parameters progress:(void (^)(NSProgress *))downloadProgress completionHandler:(void (^)(id responseObj, NSError *))completionHandler;

@end
