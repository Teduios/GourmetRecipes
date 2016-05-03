//
//  CZCollectionViewCell.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZCollectionViewCell.h"
#import "CZTableViewCell.h"
#import "CZRequestManager.h"
#import <MJRefresh.h>
@interface CZCollectionViewCell ()<UITableViewDataSource,UITableViewDelegate>
/** 滚动视图 */
@property(nonatomic ,strong)UITableView *tableView;

/** 第二层结果模型 */
@property(nonatomic ,strong) CZRecipeResultModel *resultModel;

/** 主要菜谱数据的数组 */
@property(nonatomic ,strong)NSMutableArray *recipeDatas;

/** 数据申请条数 */
@property (nonatomic ,assign) NSInteger requestDatas;
/** 数据申请的下标 */
@property (nonatomic ,assign) NSInteger requestIndex;
/** 存储路径 */
@property (nonatomic ,copy) NSString *recipePath;
/** 缓存数组 */
@property(nonatomic ,strong)NSMutableArray *recipeCacheArray;
@end

@implementation CZCollectionViewCell

#pragma mark - 懒加载

- (NSMutableArray *)recipeDatas{
    if (_recipeDatas == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in _resultModel.data) {
            CZRecipeDataModel *dataModel = [CZRecipeDataModel ModelWithDict:dict];
            [array addObject:dataModel];
        }
        _recipeDatas = array;
    }
    return _recipeDatas;
}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.requestDatas = 15;//每次申请15条
        self.requestIndex = 0;//当前申请数据的开始下标为0;
        
        self.tableView = [[UITableView alloc]initWithFrame:self.bounds];
        self.tableView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableView];

        self.tableView.backgroundColor = [UIColor whiteColor];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        
        
        __weak CZCollectionViewCell *weakSelf = self;
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            NSString *path = kVarietySubListModelAddress;
            NSDictionary *pa = @{@"rn":@(weakSelf.requestDatas),
                                 @"pn":@(weakSelf.requestIndex),
                                 @"cid":weakSelf.currentRecipe.Id};
            
            [CZRequestManager getRecipeModelWithCategory:path AndParams:pa completionHandler:^(CZRecipeRequestModel *model, NSError *error) {
                [weakSelf.tableView endFooterRefresh];
                if (!error) {
                    weakSelf.resultModel = [CZRecipeResultModel ModelWithDict:model.result];
                    NSMutableArray *array = [NSMutableArray array];
                    
                    for (NSDictionary *dict in weakSelf.resultModel.data) {
                        CZRecipeDataModel *dataModel = [CZRecipeDataModel ModelWithDict:dict];
                        [array addObject:dataModel];
                    }
                    [weakSelf.recipeDatas addObjectsFromArray:array];
                    [weakSelf.tableView endFooterRefresh];
                    
                    [[NSFileManager defaultManager] removeItemAtPath:weakSelf.recipePath error:nil];

                    [NSKeyedArchiver archiveRootObject:weakSelf.recipeDatas toFile:weakSelf.recipePath];

                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakSelf.tableView reloadData];
                        [self.tableView.mj_footer endRefreshing];
                    });

                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView.mj_footer endRefreshing];
                        [weakSelf addPrompt];
                    });
                }
                
            }];
        }];
        
    }
    
    return self;
}

- (void)setFoodListArray:(NSArray *)foodListArray{
    _foodListArray = foodListArray;

}

- (void)setCurrentRecipe:(CZFoodVarietyListModel *)currentRecipe{
    _currentRecipe = currentRecipe;
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSString *tmp = NSTemporaryDirectory();
    self.recipePath = [tmp stringByAppendingPathComponent:_currentRecipe.name];
    [[NSUserDefaults standardUserDefaults] setObject:tmp forKey:@"recipeCache"];
    BOOL isDir = nil;
    BOOL isPath = [fm fileExistsAtPath:self.recipePath isDirectory:&isDir];
    if (!isPath) {
        NSString *path = kVarietySubListModelAddress;
        NSDictionary *pa = @{@"rn":@(self.requestDatas),
                             @"pn":@(self.requestIndex),
                             @"cid":currentRecipe.Id};
        __weak typeof(self) weakSelf = self;
        [CZRequestManager getRecipeModelWithCategory:path AndParams:pa completionHandler:^(CZRecipeRequestModel *model, NSError *error) {
    
            if (!error) {
                weakSelf.resultModel = [[CZRecipeResultModel alloc]initWithDict:model.result];
                
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dict in weakSelf.resultModel.data) {
                    CZRecipeDataModel *dataModel = [CZRecipeDataModel ModelWithDict:dict];
                    [array addObject:dataModel];
                }
                weakSelf.recipeDatas = array;

                [NSKeyedArchiver archiveRootObject:weakSelf.recipeDatas toFile:weakSelf.recipePath];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakSelf.tableView reloadData];
                });
            }else{
                [weakSelf addPrompt];
            }
        }];

    }else{
        self.recipeDatas = [NSKeyedUnarchiver unarchiveObjectWithFile:self.recipePath];
        [self.tableView reloadData];
    }
}

#pragma mark - tableView数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    self.requestIndex = self.recipeDatas.count;
    return self.recipeDatas.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CZRecipeDataModel *recipe = self.recipeDatas[indexPath.row];
    

    CZTableViewCell *cell = [CZTableViewCell cellWithTableView:tableView WithString:@"recipeList"];
    
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:[recipe.albums lastObject]] placeholderImage:[UIImage imageNamed:@"defaultsPic"]];
    
    cell.nameLabel.text = recipe.title;
    
    cell.detailLanel.text = [NSString stringWithFormat:@"主要食材:%@",recipe.ingredients];
    
    return cell;
    
}
#pragma mark - tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    CZRecipeDataModel *recipe = self.recipeDatas[indexPath.row];

    [self.delegate cellDidClick:recipe];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark - 放法
- (void)addPrompt{
    UILabel *promptView = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.tableView.frame) - 150)*0.5, (CGRectGetHeight(self.tableView.frame)-40)*0.5, 150, 40)];
    promptView.layer.cornerRadius = 5;
    promptView.clipsToBounds = YES;
    promptView.textAlignment = NSTextAlignmentCenter;
    promptView.textColor = [UIColor blackColor];
    promptView.backgroundColor = [UIColor grayColor];
    promptView.text = @"请检查您的网络";
    [self addSubview:promptView];
    
    [UIView animateKeyframesWithDuration:1 delay:2 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        promptView.alpha = 0;
        //
    } completion:nil];


}



@end
