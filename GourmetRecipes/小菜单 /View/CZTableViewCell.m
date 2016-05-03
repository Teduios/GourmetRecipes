//
//  CZTableViewCell.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/18.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZTableViewCell.h"

@interface CZTableViewCell ()

@end


@implementation CZTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+5, 5, self.frame.size.width - self.iconImageView.frame.size.width - 10, 25)];
        self.nameLabel.font = [UIFont systemFontOfSize:18];
        
        self.detailLanel = [[UILabel alloc]initWithFrame:CGRectMake(self.nameLabel.frame.origin.x, CGRectGetMaxY(self.nameLabel.frame)+5, self.nameLabel.frame.size.width, 30)];
        self.detailLanel.font = [UIFont systemFontOfSize:13];
        self.detailLanel.numberOfLines = 0;
        self.detailLanel.textColor = [UIColor grayColor];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.detailLanel];
        
        
    }
    return self;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView WithString:(NSString *)ID{
    
    CZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CZTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
