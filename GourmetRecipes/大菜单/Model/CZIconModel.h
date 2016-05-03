//
//  CZIconModel.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZIconModel : NSObject
/** 图片网址 */
@property (nonatomic ,copy) NSString *iconUrl;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
