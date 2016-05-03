//
//  CZSearchScrollView.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZFoodDetailedResultModel;
@interface CZSearchScrollView : UIScrollView
/** title */
@property(nonatomic ,strong)UILabel *nameLabel;

- (instancetype)initWithFrame:(CGRect)frame WithModel:(CZFoodDetailedResultModel *)model;


@end
