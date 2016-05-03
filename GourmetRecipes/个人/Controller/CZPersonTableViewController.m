//
//  CZPersonTableViewController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZPersonTableViewController.h"
#import "CZAdverCycleView.h"
#import "CZIconModel.h"
#import "CZCacheManager.h"
#import <MessageUI/MessageUI.h>

@interface CZPersonTableViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
/** 缓存路径 */
@property (nonatomic ,copy) NSString *cacheImagesPath;

@end

@implementation CZPersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imageArray = @[@"111",@"222",@"333",@"444"];
    CZAdverCycleView *cycleView = [[CZAdverCycleView alloc]initWithFrame:CGRectMake(8, 8, self.view.bounds.size.width, 1.0 *(self.view.bounds.size.width-16)*2/3) WithImageArray:imageArray];
    self.tableView.tableHeaderView = cycleView;
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"本次清除缓存%@",self.cacheLabel.text] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"下次" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *clearAction = [UIAlertAction actionWithTitle:@"清除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self clearCache];
            }];
            [alert addAction:cancelAction];
            [alert addAction:clearAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}


/**
 *  计算缓存
 */

- (void)viewWillAppear:(BOOL)animated{
    [self creatCacheLabel];

}
- (void)creatCacheLabel{

    NSString *path = [[NSBundle mainBundle]pathForResource:@"recipe.plist" ofType:nil];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    CZIconModel *model = [[CZIconModel alloc]initWithDict:arr[1]];
    
    NSString *cacheImageKey = [[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:model.iconUrl]];
    if (cacheImageKey.length) {
        
        NSString *cacheImagePath = [[SDImageCache sharedImageCache] defaultCachePathForKey:cacheImageKey];
        
        self.cacheImagesPath = [cacheImagePath stringByDeletingLastPathComponent];
        self.cacheLabel.text = [NSString stringWithFormat:@"%.2lfM",[CZCacheManager folderSizeAtPath:self.cacheImagesPath]];
    }

}
- (void)clearCache{
    [CZCacheManager clearCache:self.cacheImagesPath];
    
    [self creatCacheLabel];

}

@end
