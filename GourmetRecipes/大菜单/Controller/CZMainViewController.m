//
//  CZMainViewController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//
#define kSpace 10
#import "CZMainViewController.h"
#import "CZFoodVarietyModel.h"
#import "CZRecipSubListViewController.h"
#import "CZRequestManager.h"
#import "CZListCollectionViewCell.h"
#import "CZIconModel.h"
#import "CZTabBarController.h"
#import "CZSearchViewController.h"




@interface CZMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/** 大类别分组数据数组 */
@property(nonatomic ,strong)NSArray *foodVarietys;

/** 大菜单 */
@property(nonatomic ,strong)NSMutableArray *foodVarietysList;

/** <#属性#> */
@property(nonatomic ,strong)UICollectionView *collectionView;

/** 背景 */
//@property(nonatomic ,strong)UIImageView *bgImageView;
/** 组名与图片的数组 */
@property(nonatomic ,strong)NSArray *icons;
@end

@implementation CZMainViewController

#pragma mark - 懒加载
- (NSArray *)icons{
    if (_icons == nil) {
        NSString *path = [[NSBundle mainBundle]pathForResource:@"recipe.plist" ofType:nil];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            CZIconModel *model = [[CZIconModel alloc]initWithDict:dict];
            [arr addObject:model];
        }
        _icons = arr;
    }
    return _icons;
}

- (NSArray *)foodVarietys{
    if (_foodVarietys==nil) {
        NSString *path = kVarietyModelAddress;
        [CZRequestManager getFoodVarietyModelWithCategory:path AndParams:nil completionHandler:^(CZVarietyRequestModel *model, NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (error) {
                UILabel *promptView = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 150)*0.5, (CGRectGetHeight(self.view.frame)-40)*0.5, 150, 40)];
                promptView.layer.cornerRadius = 5;
                promptView.clipsToBounds = YES;
                promptView.textAlignment = NSTextAlignmentCenter;
                promptView.textColor = [UIColor blackColor];
                promptView.backgroundColor = [UIColor grayColor];
                promptView.text = @"请检查您的网络";
                [self.view addSubview:promptView];
              
                [UIView animateKeyframesWithDuration:1 delay:2 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                    promptView.alpha = 0;
//
                } completion:nil];
                
            }else{
                NSArray *array = [NSArray arrayWithArray:model.result];
                NSMutableArray *arr = [NSMutableArray array];
                for (NSDictionary *dict in array) {
                    CZFoodVarietyModel *variety = [CZFoodVarietyModel varietyWithDict:dict];
                    [arr addObject:variety];
                }
                _foodVarietys = arr;
                [self.collectionView reloadData];
            }

        }];
    }
        return _foodVarietys;
}

#pragma mark - collectionView数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.foodVarietys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CZListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"list" forIndexPath:indexPath];
    CZFoodVarietyModel *variety = self.foodVarietys[indexPath.row];
    CZIconModel *model = self.icons[indexPath.row];
    cell.listNameLabel.text = variety.name;
    [cell.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.iconUrl]];
    if (indexPath.row == 1) {
        
    }
    
    return cell;
}

#pragma mark - collectionDelegateFlowlaout代理方法

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat itemW = 1.0 *(self.view.bounds.size.width-kSpace*4)/3-2;
    CGFloat itemH = itemW ;
    return CGSizeMake(itemW, itemH);

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(kSpace, kSpace, kSpace, kSpace);
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kSpace;
}


#pragma mark - collectionView代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    CZRecipSubListViewController *RSLVC = [[CZRecipSubListViewController alloc]init];
    
    CZFoodVarietyModel *variety = self.foodVarietys[indexPath.row];
    
    RSLVC.VarietyListArray = variety.list;
    RSLVC.recipeTitle = variety.name;
    RSLVC.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:RSLVC animated:YES];
    

}


#pragma mark - 方法

- (void)creatCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
//    self.collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-104) collectionViewLayout:flowLayout];


    [self.collectionView registerClass:[CZListCollectionViewCell class] forCellWithReuseIdentifier:@"list"];
    [self.view addSubview:self.collectionView];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;

    

    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    

}


#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self creatCollectionView];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.®
}




@end
