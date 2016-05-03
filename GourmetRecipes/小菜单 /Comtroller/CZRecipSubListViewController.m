//
//  CZRecipSubListViewController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/2.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZRecipSubListViewController.h"
#import "CZFoodVarietyModel.h"
#import "CZControlSwitchView.h"
#import "CZCollectionViewCell.h"
#import "CZShowRecipeViewController.h"
#define kNaviW  60
#define kNaviH  30
@interface CZRecipSubListViewController ()<CZControlSwitchViewDelegate>
/** <#属性#> */
@property(nonatomic ,strong)NSMutableArray *recipeSubLists;
@end

@implementation CZRecipSubListViewController


#pragma mark - 懒加载
- (NSMutableArray *)recipeSubLists{
    if (_recipeSubLists == nil) {
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dict in self.VarietyListArray) {
            CZFoodVarietyListModel *varietyList = [CZFoodVarietyListModel listWithDict:dict];
            [array addObject:varietyList];
        }
        _recipeSubLists = array;
    }
    return _recipeSubLists;
}





#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = self.recipeTitle;
    CZControlSwitchView *collectionscrollView = [[CZControlSwitchView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.frame.size.width, self.view.frame.size.height - CGRectGetMaxY(self.navigationController.navigationBar.frame)) WithNaviFrame:CGRectMake(0, 0, kScreenW, kNaviH) WithTitleSize:CGSizeMake(kNaviW, kNaviH) WithTitles:self.recipeSubLists];
    
    [self.view addSubview:collectionscrollView];
   
    collectionscrollView.delegate = self;
    
    
    

}
- (void)changeController:(CZRecipeDataModel *)model{
    CZShowRecipeViewController *showVC = [[CZShowRecipeViewController alloc]init];
    showVC.model = model;
    [self.navigationController pushViewController:showVC animated:YES];

}

























- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
