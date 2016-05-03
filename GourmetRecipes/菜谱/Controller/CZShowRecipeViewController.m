//
//  CZShowRecipeViewController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/13.
//  Copyright © 2016年 zcz. All rights reserved.
//
#define kBgColor kColorRGB(240, 240, 240, 1)

#import "CZShowRecipeViewController.h"
#import "CZRecipeScrollView.h"
#import "CZCokingViewController.h"
@interface CZShowRecipeViewController ()<UIScrollViewDelegate,CZRecipeScrollViewDelegate>

/** 滚动视图 */
@property(nonatomic ,strong)UIScrollView *mainScrollView;
/** 底部显示图片 */
@property(nonatomic ,strong)UIView *headView;
/** <#属性#> */
@property(nonatomic ,strong) UIImageView *headImageView;


@end

@implementation CZShowRecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;//视图被导航栏遮盖的修改
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationItem.title = self.model.title;
    
    [self addHeadImageView];
    CZRecipeScrollView *mainScrollView = [[CZRecipeScrollView alloc] initWithFrame:self.view.bounds WithModel:self.model WithHeadSize:self.headView.frame.size WithNaviSize:self.navigationController.navigationBar.frame.size];
    mainScrollView.delegate = self;
    mainScrollView.recipeDelegate = self;
    [self.view addSubview:mainScrollView];

    
    

    
    
}

#pragma mark - 方法
/**
 *  添加底部图片
 */
- (void)addHeadImageView{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1.0*self.view.frame.size.width*3/4)];
    self.headView.backgroundColor = kBgColor;
    self.headImageView = [[UIImageView alloc]initWithFrame:self.headView.bounds];
    self.headImageView.layer.cornerRadius = 8;
    self.headImageView.clipsToBounds = YES;
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.headImageView];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[self.model.albums firstObject]] placeholderImage:[UIImage imageNamed:@"defaultsPic"]];
}

/**
 *  添加滚动视图
 */
- (void)addMainScrollView{
    self.mainScrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.mainScrollView];
    self.mainScrollView.delegate = self;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
}
#pragma mark - 自定义代理
- (void)stepsButtonClick:(NSArray<CZRecipeStepsModel *> *)array AndButtonTag:(NSInteger)inter{
    CZCokingViewController *cokVC = [[CZCokingViewController alloc]init];
    cokVC.steps = array;
    cokVC.inter = inter;
    [self presentViewController:cokVC animated:YES completion:nil];

}

- (void)addToFavourite{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefaults objectForKey:kFavourite];
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (arr == nil || arr.count == 0) {
        arr = [NSMutableArray array];
        [arr addObject:self.model];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
        [userDefaults setObject:data forKey:kFavourite];
        [self addPrompViewWithString:@"已加入收藏夹"];
    }else{
        
        for (NSInteger i = 0; i<arr.count; i++) {
            CZRecipeDataModel *model = arr[i];
            if (self.model.Id == model.Id) {
                [self addPrompViewWithString:@"已在收藏夹内"];
                break;
            }else if (i == arr.count-1){
                [arr addObject:self.model];
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
                [userDefaults setObject:data forKey:kFavourite];
                [self addPrompViewWithString:@"已加入收藏夹"];
                break;
            }
        }
    }
    
    
    


}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <0) {
        CGRect frame = self.headView.frame;
        frame.size.height = 1.0*self.view.frame.size.width*3/4-scrollView.contentOffset.y;
        self.headView.frame = frame;
        self.headImageView.frame = self.headView.bounds;
    }
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)addPrompViewWithString:(NSString *)str{
    UILabel *promptLabel = [[UILabel alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.view.frame) - 150)*0.5, (CGRectGetHeight(self.view.frame)-40)*0.5, 150, 40)];
    promptLabel.layer.cornerRadius = 5;
    promptLabel.clipsToBounds = YES;
    promptLabel.textAlignment = NSTextAlignmentCenter;
    promptLabel.textColor = [UIColor blackColor];
    promptLabel.backgroundColor = [UIColor grayColor];
    promptLabel.text = str;
    [self.view addSubview:promptLabel];
    
    [UIView animateKeyframesWithDuration:1 delay:1 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
        promptLabel.alpha = 0;
        
    } completion:nil];
}


@end
