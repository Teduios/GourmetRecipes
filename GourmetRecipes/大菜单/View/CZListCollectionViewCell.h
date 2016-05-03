//
//  CZListCollectionViewCell.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CZIconModel.h"
@interface CZListCollectionViewCell : UICollectionViewCell
/** 图片显示 */
@property(nonatomic ,strong)UIImageView *iconImageView;
/** 文字显示 */
@property(nonatomic ,strong)UILabel *listNameLabel;



- (instancetype)initWithFrame:(CGRect)frame;
@end
