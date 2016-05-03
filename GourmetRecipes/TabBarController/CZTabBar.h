//
//  CZTabBar.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZTabBar;
@protocol CZTabBarDeletate <UITabBarDelegate>

@optional
- (void)tabBarDidClickSearchButton:(CZTabBar *)tabBar;

@end

@interface CZTabBar : UITabBar

/** 代理属性 */
@property(nonatomic ,weak)id<CZTabBarDeletate> tabDelegate;

@end
