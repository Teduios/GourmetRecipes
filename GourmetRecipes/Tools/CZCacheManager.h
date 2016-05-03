//
//  CZCacheManager.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/24.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZCacheManager : NSObject
/** 计算单个文件大小 */
+ (float)fileSizeAtPath:(NSString *)path;
/** 计算路径文件大小 */
+ (float)folderSizeAtPath:(NSString *)path;
/** 清除缓存 */
+ (void)clearCache:(NSString *)path;
@end
