//
//  NSString+BreakUp.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "NSString+BreakUp.h"

@implementation NSString (BreakUp)

+ (NSDictionary *)stringBreakUpString:(NSString *)string{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < string.length; i++) {
        NSRange range = {i,1};
        NSString *str = [string substringWithRange:range];
        
        [array addObject:str];
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSMutableString *key = [NSMutableString string];
    NSMutableString *value = [NSMutableString string];
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i< array.count; i++) {
        if ([array[i]isEqualToString:@","]||[array[i]isEqualToString:@"，"]) {
            key = [str mutableCopy];
            NSRange ra = {0,str.length};
            [str deleteCharactersInRange:ra];
        }else if([array[i]isEqualToString:@"；"]||[array[i]isEqualToString:@";"]){
            value = [str mutableCopy];
            NSRange ra = {0,str.length};
            [str deleteCharactersInRange:ra];
            [dict setObject:value forKey:key];
        }else{
            [str appendString:array[i]];
            if (i == array.count-1) {
                value = [str mutableCopy];
                NSRange ra = {0,str.length};
                [str deleteCharactersInRange:ra];
                [dict setObject:value forKey:key];
            }
        }
        
    }
    return dict;

}
@end
