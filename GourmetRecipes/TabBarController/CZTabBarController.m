//
//  CZTabBarController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/20.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZTabBarController.h"
#import "CZMainViewController.h"
#import "CZPersonTableViewController.h"
#import "CZTabBar.h"
#import "CZRequestManager.h"
#import "CZSearchViewController.h"

@interface CZTabBarController ()<CZTabBarDeletate,UITextFieldDelegate>
/**搜索textFiled */
@property(nonatomic ,strong)UITextField *searchField;
@end

@implementation CZTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加子控制器
    
//    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[CZMainViewController alloc]init]];
    
    [self addChildVc:[[CZMainViewController alloc]init] title:@"菜谱" image:@"caipu" selectedImage:@"caipu_sel"];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"person" bundle:nil];
    CZPersonTableViewController *personVC = [storyBoard instantiateViewControllerWithIdentifier:@"person"];
    [self addChildVc:personVC title:@"个人" image:@"geren" selectedImage:@"geren_sel"];

    
    CZTabBar *tabBar = [[CZTabBar alloc] init];
    // 设置代理
    tabBar.tabDelegate= self;
    // 修改tabBar为自定义tabBar
    [self setValue:tabBar forKey:@"tabBar"];
    CGFloat seachX = self.view.width-15;
    CGFloat seachY = 64;
    CGFloat seachW = 30;
    CGFloat seachH = 30;
    self.searchField = [[UITextField alloc]initWithFrame:CGRectMake(seachX, seachY, seachW, seachH)];
    self.searchField.backgroundColor = [UIColor orangeColor];
    self.searchField.layer.cornerRadius = 15;
    self.searchField.placeholder = @" 内容:食材 搜索栏轻扫收起";
    self.searchField.font = [UIFont systemFontOfSize:15];
    self.searchField.delegate = self;
    self.searchField.returnKeyType = UIReturnKeySearch;
    [self.searchField addTarget:self action:@selector(beginSeach) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    UISwipeGestureRecognizer *rightSeipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(pakeUpSearchField)];
    [self.view addSubview:self.searchField];
    [self.searchField addGestureRecognizer:rightSeipe];
    rightSeipe.direction = UISwipeGestureRecognizerDirectionRight;
    
}
/**
 *  开始搜索
 */
- (void)beginSeach{
    if (self.searchField.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"搜索不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        NSDictionary *pa = @{@"name": [self.searchField.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]};

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
            
            [self.searchField endEditing:YES];
            
            CZSearchViewController *seaVC = [CZSearchViewController new];
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:seaVC];
            seaVC.model = model;
            [self presentViewController:navi animated:YES completion:nil];


        }
        
        
    }];
    
    
    
    }
}


- (void)tabBarDidClickSearchButton:(CZTabBar *)tabBar{
    [self.searchField becomeFirstResponder];


}
/**
 *  手势结束搜索
 */
- (void)pakeUpSearchField{
    [self.searchField endEditing:YES];

}

/**
 *  添加一个子控制器
 */
- (void)addChildVc:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    
    
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVC.title = title;
    
    // 设置子控制器的tabBarItem图片
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorRGB(234, 234, 234, 0.9)} forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorRGB(124, 28, 45, 0.9)} forState:UIControlStateSelected];

    
    // 为子控制器包装导航控制器
    
   
    UINavigationBar *bar = [UINavigationBar appearance];
    bar.tintColor = [UIColor whiteColor];
    //
    [bar setBarTintColor:kColorRGB(91, 50, 15, 0.7)];
    [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    [bar setBarStyle:UIBarStyleBlackOpaque];//设置title颜色
    
    
    UINavigationController *childNavi = [[UINavigationController alloc]initWithRootViewController:childVC];
    
    // 添加子控制器
    [self addChildViewController:childNavi];
}

#pragma mark - textFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.3 animations:^{
        self.searchField.frame = CGRectMake(1.0 *self.view.width/3-20, 64, self.view.width*2/3, 30);
    }];

}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    CGFloat seachX = self.view.width-15;
    CGFloat seachY = 64;
    CGFloat seachW = 30;
    CGFloat seachH = 30;
    [UIView animateWithDuration:0.3 animations:^{
        self.searchField.frame = CGRectMake(seachX, seachY, seachW, seachH);
    }];
    self.searchField.text = @"";
}



@end
