//
//  CZTableViewCell.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/18.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZTableViewCell : UITableViewCell

/** imageView */
@property(nonatomic ,strong)UIImageView *iconImageView;
/** name */
@property(nonatomic ,strong)UILabel *nameLabel;
/** 主料 */
@property(nonatomic ,strong)UILabel *detailLanel;

+ (instancetype)cellWithTableView:(UITableView *)tableView WithString:(NSString *)string;
@end
