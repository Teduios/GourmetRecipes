//
//  CZControlSwitchView.m
//  ControlSwitchView
//
//  Created by tarena on 16/3/30.
//  Copyright © 2016年 zcz. All rights reserved.
//
#define naviColor [UIColor orangeColor]
#define normalColor [UIColor blackColor]
#define selectColor [UIColor whiteColor]
#define ID @"recipeCell"
#import "CZControlSwitchView.h"
#import "CZCollectionViewCell.h"
#import "CZFoodVarietyModel.h"


@interface CZControlSwitchView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CZCollectionViewCellDelegate>

/** <#属性#> */
@property(nonatomic ,strong)UIView *parentView;
/** 内容主体滚动视图 */
@property(nonatomic ,strong)UICollectionView *contentCollectionView;
/** 标题滚动视图 */
@property(nonatomic ,strong)UIScrollView *naviScrollView;
/** 选中滚动视图 */
@property(nonatomic ,strong)UIScrollView *selectScrollView;
/** 显示选中视图 */
@property(nonatomic ,strong)UIView *showView;
/** 标题Frame */
@property(nonatomic ,assign)CGSize titleSize;
/** 记录contentScrollView 与前一次滚动位置的距离 */
@property(nonatomic ,assign)CGFloat contentOffsetX;

/** 模型数据 */
@property(nonatomic ,strong)CZFoodVarietyListModel *varietyList;


@end


@implementation CZControlSwitchView
- (instancetype)initWithFrame:(CGRect)frame WithNaviFrame:(CGRect)naviFrame  WithTitleSize:(CGSize)titleSize WithTitles:(NSArray *)titles {

    if (self = [super initWithFrame:frame]) {
        self.titleSize = titleSize;
        self.titles = titles;
        
//        self.parentView = [[UIView alloc]init];
//        [self addSubview:self.parentView];
        
//naviScrollView
        self.naviScrollView = [[UIScrollView alloc]initWithFrame:naviFrame];
        
        [self addSubview:self.naviScrollView];
        
        self.naviScrollView.contentSize = CGSizeMake(titleSize.width*titles.count,titleSize.height);
        
        self.naviScrollView.backgroundColor = naviColor;
        
        self.naviScrollView.bounces = NO;
        
        self.naviScrollView.showsHorizontalScrollIndicator = NO;
        
        self.naviScrollView.showsVerticalScrollIndicator = NO;
        
        
        [self addLabelToScrollView:self.naviScrollView WithTitleColor:normalColor];

        
//添加button
        for (int i = 0; i< titles.count; i++) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(titleSize.width*i, 0, titleSize.width, titleSize.height)];
            
            [button setBackgroundColor:[UIColor clearColor]];
            
            self.varietyList = titles[i];
            
            button.titleLabel.text = [NSString stringWithFormat:@"%d",i];
            
            [self.naviScrollView addSubview:button];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        }
        
//显示选中的title的View
        self.showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, titleSize.width, titleSize.height)];
        
        self.showView.backgroundColor = [UIColor clearColor];
        
        [self.naviScrollView addSubview:self.showView];

        
//显示选中的的title的滚动视图
        self.selectScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, titleSize.width, titleSize.height)];
        
        [self.showView addSubview:self.selectScrollView];
        
        self.selectScrollView.contentSize = self.naviScrollView.contentSize;
        
        self.selectScrollView.bounces = NO;
        
        self.selectScrollView.userInteractionEnabled = NO;
        
        self.selectScrollView.showsVerticalScrollIndicator = NO;
        
        self.selectScrollView.showsHorizontalScrollIndicator = NO;
        
        self.selectScrollView.backgroundColor = [UIColor clearColor];
        
        [self addLabelToScrollView:self.selectScrollView WithTitleColor:selectColor];
        

//显示主要内容的主scrollView
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

        self.contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(CGRectGetMinX(naviFrame), CGRectGetMaxY(naviFrame), CGRectGetWidth(naviFrame), self.frame.size.height - CGRectGetHeight(naviFrame)) collectionViewLayout:flowLayout];
        
        self.contentCollectionView.contentSize = CGSizeMake(titles.count *naviFrame.size.width, CGRectGetHeight(naviFrame));
        
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
      
        
        [self addSubview:self.contentCollectionView];
        
        [self.contentCollectionView registerClass:[CZCollectionViewCell class] forCellWithReuseIdentifier:ID];
        
        self.contentCollectionView.bounces = NO;
        self.contentCollectionView.delegate = self;
        
        self.contentCollectionView.dataSource = self;
        
        self.contentCollectionView.showsVerticalScrollIndicator = NO;
        
        self.contentCollectionView.showsHorizontalScrollIndicator = NO;
        
        self.contentCollectionView.pagingEnabled = YES;

        self.contentCollectionView.backgroundColor = [UIColor clearColor];
        


        
    }
    return self;
}
#pragma mark - 方法
//添加label
- (void)addLabelToScrollView:(UIScrollView *)scrollView WithTitleColor:(UIColor *)color{
    for (int i = 0; i < self.titles.count; i++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(i *self.titleSize.width, 0, self.titleSize.width, self.titleSize.height)];
        
        [label setTextColor:color];

        CZFoodVarietyListModel *varietyList = self.titles[i];
        
        label.text = varietyList.name;
        
        label.backgroundColor = [UIColor clearColor];
        
        [scrollView addSubview:label];
        
    }


}
//按钮点击
- (void)buttonClick:(UIButton *)button{
    NSString *titleId = button.titleLabel.text;
    
    
    NSInteger index = [titleId integerValue];
    
    self.contentCollectionView.contentOffset = CGPointMake(self.contentCollectionView.frame.size.width *index, 0);

}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
    self.showView.frame = CGRectMake(self.showView.frame.size.width/self.contentCollectionView.frame.size.width *self.contentCollectionView.contentOffset.x , 0, self.showView.frame.size.width, self.showView.frame.size.height);
    
    self.selectScrollView.contentOffset = CGPointMake(self.showView.frame.size.width/self.contentCollectionView.frame.size.width *self.contentCollectionView.contentOffset.x, 0);
  
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (CGRectGetMaxX(self.showView.frame) - self.naviScrollView.contentOffset.x > self.frame.size.width) {
        
        [self.naviScrollView setContentOffset:CGPointMake(self.naviScrollView.contentOffset.x + CGRectGetMaxX(self.showView.frame) - self.naviScrollView.contentOffset.x - self.frame.size.width, 0) animated:YES];
        
    }else if (self.naviScrollView.contentOffset.x - CGRectGetMinX(self.showView.frame) > 0){
        
        [self.naviScrollView setContentOffset:CGPointMake(self.naviScrollView.contentOffset.x - self.naviScrollView.contentOffset.x + CGRectGetMinX(self.showView.frame), 0) animated:YES];
        
    }
}


#pragma mark - CollectionView数据源

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    CZCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.delegate = self;
//        cell.backgroundColor = [UIColor colorWithRed:(indexPath.row*10+100)/255.0 green:(indexPath.row*10+100)/255.0 blue:(indexPath.row*10+100)/255.0 alpha:1];
//    cell.foodListArray = self.titles;
    cell.currentRecipe = self.titles[indexPath.row];
    
    return cell;
}

#pragma mark - collectionViewdelegateflowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
return self.contentCollectionView.frame.size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)cellDidClick:(CZRecipeDataModel *)model{
    [self.delegate changeController:model];
}



@end
