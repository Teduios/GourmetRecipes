//
//  CZStrConnectManager.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZStrConnectManager : NSObject
+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params;
@end
