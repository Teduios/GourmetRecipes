//
//  CZWelcomeViewController.m
//  入戏
//
//  Created by tarena on 16/3/17.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZWelcomeViewController.h"
#import "CZTabBarController.h"

@interface CZWelcomeViewController ()<UIScrollViewDelegate>
/* 滚动视图 */
@property (strong, nonatomic) UIScrollView *scrollView;
/* 欢迎界面图片 */
@property(nonatomic ,strong)NSArray *imageArray;
/* 分页视图 */
@property (strong, nonatomic) UIPageControl *pageControl;


@end

@implementation CZWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArray = @[@"welcom1",@"welcom2",@"welcom3"];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame), self.view.bounds.size.width, 40)];
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * self.imageArray.count, self.view.bounds.size.height);
    
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    
    /**
     *  添加imageView
     */

    CGFloat imageW = self.view.bounds.size.width;
    CGFloat imageH = self.view.bounds.size.height;
    CGFloat imageY = 0;
    for (int i = 0; i<self.imageArray.count; i++) {
        CGFloat imageX = self.view.bounds.size.width *i;
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
        [self.scrollView addSubview:imageView];
        if (i == self.imageArray.count - 1) {
            UIButton *goInButton = [[UIButton alloc]initWithFrame:CGRectMake((self.view.bounds.size.width - 100)*0.5, (self.view.bounds.size.height - 130), 100, 30)];
            [goInButton setBackgroundColor:[UIColor orangeColor]];
            [goInButton setTitle:@"进厨房" forState:UIControlStateNormal];
            [goInButton.layer setCornerRadius:5];
            
            goInButton.alpha = 0.7;
            [imageView addSubview:goInButton];
            imageView.userInteractionEnabled = YES;
            
            [goInButton addTarget:self action:@selector(intoPlayer) forControlEvents:UIControlEventTouchUpInside];
        }
        imageView.image = [UIImage imageNamed:self.imageArray[i]];
        [self.scrollView addSubview:imageView];
        
    }

    self.scrollView.delegate = self;
    
    self.pageControl.numberOfPages = self.imageArray.count;
    

}




/**
 *  进入程序
 */
- (void)intoPlayer{
    CZTabBarController *tabVC = [[CZTabBarController alloc]init];
    

    [self presentViewController:tabVC animated:YES completion:nil];
}    


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = round(self.scrollView.contentOffset.x/self.scrollView.bounds.size.width);

}

















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
