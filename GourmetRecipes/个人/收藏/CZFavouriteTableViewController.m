//
//  CZFavouriteTableViewController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZFavouriteTableViewController.h"
#import "CZTableViewCell.h"
#import "CZRecipeModel.h"
#import "CZShowRecipeViewController.h"
@interface CZFavouriteTableViewController ()
/** 沙盒数据*/
@property(nonatomic ,strong)NSArray *favours;
@end

@implementation CZFavouriteTableViewController

#pragma mark - 懒加载
- (NSArray *)favours{
    if (_favours == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kFavourite];
        if (data != nil) {
            NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            _favours = [NSArray arrayWithArray:arr];
        }
    }
    
    return _favours;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收藏夹";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.favours.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZTableViewCell *cell = [CZTableViewCell cellWithTableView:tableView WithString:@"favour"];
     CZRecipeDataModel *recipe = self.favours[indexPath.row];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[recipe.albums lastObject]] placeholderImage:[UIImage imageNamed:@"defaultsPic"]];
    
    cell.nameLabel.text = recipe.title;
    
    cell.detailLanel.text = [NSString stringWithFormat:@"主要食材:%@",recipe.ingredients];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    CZRecipeDataModel *recipe = self.favours[indexPath.row];
    CZShowRecipeViewController *showVC = [[CZShowRecipeViewController alloc]init];
    showVC.model = recipe;
    [self.navigationController pushViewController:showVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除选中收藏" message:@"删吧,没了再加" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"不删" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *delete = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self determineDeleteFavoriteWithTableView:tableView andindexPath:indexPath];
    }];
    [alert addAction:cancle];
    [alert addAction:delete];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
return @"删除";
}

#pragma mark - 方法

- (void)determineDeleteFavoriteWithTableView:(UITableView *)tableView andindexPath:(NSIndexPath*)indexPath{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kFavourite];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    [arr removeObjectAtIndex:indexPath.row];
    self.favours = arr;
    data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kFavourite];
    
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
}


@end
