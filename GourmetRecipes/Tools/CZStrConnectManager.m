//
//  CZStrConnectManager.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZStrConnectManager.h"

@implementation CZStrConnectManager
+ (NSString *)serializeURL:(NSString *)baseURL params:(NSDictionary *)params{
    NSArray *keys = [params allKeys];
    NSMutableString *mutableStr = [[NSMutableString alloc]init];
    for (NSString *str in keys) {
        [mutableStr appendFormat:@"&%@=%@",str,params[str]];

    }

    NSString *dictStr =[NSString stringWithFormat:@"%@%@",baseURL,mutableStr];

    return dictStr;
    
}
@end
