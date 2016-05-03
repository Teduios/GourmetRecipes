//
//  CZSearchViewController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZSearchViewController.h"
#import "CZSearchScrollView.h"
#import "CZRequestManager.h"

@interface CZSearchViewController ()<UISearchBarDelegate>
/** textField */
@property(nonatomic ,strong)UITextField *searchTextField;
/**  */
@property(nonatomic ,strong)CZFoodDetailedResultModel *foodModel;

@property(nonatomic ,strong)CZSearchScrollView *mainScrollView;

@end

@implementation CZSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.foodModel = self.model.result;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(goBackControler)];
    self.navigationItem.leftBarButtonItem = item;
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.bar.delegate = self;
    self.bar.layer.cornerRadius = 15;
    self.bar.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bar.layer.masksToBounds = YES;
    [titleView addSubview:self.bar];
    
    self.navigationItem.titleView = titleView;

    if (self.foodModel.Id== 0) {
        UILabel *promptView = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 200)*0.5, (CGRectGetHeight(self.view.frame)-40)*0.5, 200, 40)];
        promptView.layer.cornerRadius = 5;
        promptView.clipsToBounds = YES;
        promptView.textAlignment = NSTextAlignmentCenter;
        promptView.textColor = [UIColor whiteColor];
        promptView.backgroundColor = kColorRGB(80, 80, 80, 1);
        promptView.text = @"没有找到您要找的食材";
        [self.view addSubview:promptView];
        
        [UIView animateKeyframesWithDuration:1 delay:2 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
            promptView.alpha = 0;
          
        } completion:nil];
    }else{
        self.mainScrollView = [[CZSearchScrollView alloc]initWithFrame:self.view.bounds WithModel:self.foodModel];
        
        [self.view addSubview:self.mainScrollView];
    }

}
/**
 *  开始搜索
 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
 
        NSDictionary *pa = @{@"name": [self.bar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};
        
        [CZRequestManager getFoodDetailedModelWithCategory:kFoodMaterialModeAddress AndParams:pa completionHandler:^(CZFoodDetailedModel *model, NSError *error) {
            if (error) {
                UILabel *promptView = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 150)*0.5, (CGRectGetHeight(self.view.frame)-40)*0.5, 150, 40)];
                promptView.layer.cornerRadius = 5;
                promptView.clipsToBounds = YES;
                promptView.textAlignment = NSTextAlignmentCenter;
                promptView.textColor = [UIColor whiteColor];
                promptView.backgroundColor = [UIColor blackColor];
                promptView.text = @"请检查您的网络";
                [self.view addSubview:promptView];
                
                [UIView animateKeyframesWithDuration:1 delay:2 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                    promptView.alpha = 0;
                    //
                } completion:nil];
                
            }else{
                
                [self.bar endEditing:YES];
                CZSearchViewController *seaVC = [CZSearchViewController new];
                seaVC.model = model;
                [self.navigationController pushViewController:seaVC animated:YES];


            }
            
        }];

}
    
    
    
    


- (void)goBackControler{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
