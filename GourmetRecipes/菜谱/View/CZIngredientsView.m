//
//  CZIngredientsView.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/14.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZIngredientsView.h"
#import "CZRecipeModel.h"

@interface CZIngredientsView ()<UITableViewDataSource,UITableViewDelegate>

/** 模型数据 */
@property(nonatomic ,strong)NSDictionary *dict;
@end

@implementation CZIngredientsView

- (instancetype)initWithFrame:(CGRect)frame With:(NSDictionary *)dict WithMainIngredient:(NSString *)mainIngredient{
    if (self = [super initWithFrame:frame]) {
        
        UILabel *mainIngredientLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSeparated, kSeparated, self.frame.size.width - kSeparated*3, kCellHeight)];
        mainIngredientLabel.text = [NSString stringWithFormat:@"主料:%@",mainIngredient];
        [self addSubview:mainIngredientLabel];
        self.backgroundColor = kBgColor;
        
        //显示配料的tableView
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(kSeparated, CGRectGetMaxY(mainIngredientLabel.frame), self.frame.size.width - kSeparated*3, self.frame.size.height-kSeparated*3) style:UITableViewStylePlain];
        [self addSubview: tableView];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.showsVerticalScrollIndicator = NO;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kCellHeight)];
        titleLabel.text = @"配料";
        tableView.tableHeaderView = titleLabel;
        tableView.backgroundColor = kBgColor;
        tableView.bounces = NO;
        self.dict = dict;
        
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dict.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    UILabel *ingredLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width*0.5, kCellHeight)];
    cell.contentView.frame = cell.bounds;
    ingredLabel.text = [self.dict allKeys][indexPath.row];
    ingredLabel.font = [UIFont systemFontOfSize:13];
    ingredLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(ingredLabel.frame.size.width, 0, tableView.frame.size.width*0.5, kCellHeight)];
        amountLabel.text = [self.dict allValues][indexPath.row];
    amountLabel.font = [UIFont systemFontOfSize:13];
    amountLabel.textColor = kColorRGB(164, 164, 164, 1);
    amountLabel.textAlignment = NSTextAlignmentCenter;

    
    [cell.contentView addSubview:ingredLabel];
    [cell.contentView addSubview:amountLabel];
    
    if (indexPath.row%2 != 0) {
        ingredLabel.backgroundColor = kBgColor;
        amountLabel.backgroundColor = kBgColor;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kCellHeight;
}



@end
