//
//  CZAdverCycleView.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/21.
//  Copyright © 2016年 zcz. All rights reserved.
//

typedef enum{
    LEFT,
    RIGHT
} DIRECTION_TYPE;
#import "CZAdverCycleView.h"

@interface CZAdverCycleView ()<UIScrollViewDelegate>
@property(nonatomic ,strong)UIScrollView *scrollView;
@property(nonatomic ,strong)UIImageView *leftImageView;
@property(nonatomic ,strong)UIImageView *currentImageView;
@property(nonatomic ,strong)UIImageView *rightImageView;
@property(nonatomic ,strong)UIPageControl *pageControl;

@property(nonatomic ,assign)NSInteger currentIndex;

@property(nonatomic ,strong)NSArray *allImages;

@property(nonatomic ,strong)NSTimer *timer;

@end

@implementation CZAdverCycleView

- (instancetype)initWithFrame:(CGRect)frame WithImageArray:(NSArray *)images{
    if (self = [super initWithFrame:frame]) {
        self.allImages = images;
        self.currentIndex = 0;
        [self creatScrollViewAndImageViewWithFram:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self showImage];
        [self creatPageControl];
        
        [self addTimer];
    }
    return self;
    
}
/**
 *  添加定时器自动滚动
 */
- (void)addTimer{
    self.timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(timingScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)removeTimer{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timingScroll{
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+self.scrollView.frame.size.width, 0) animated:YES];
    [self setImageViewLocal];
    
}
- (void)setImageViewLocal{
    
    if (self.scrollView.contentOffset.x >self.scrollView.frame.size.width) {
        
        self.currentIndex =[self changeIndexWithDirectionType:RIGHT And:self.currentIndex];
    }else if(self.scrollView.contentOffset.x <self.scrollView.frame.size.width){
        
        self.currentIndex =[self changeIndexWithDirectionType:LEFT And:self.currentIndex];
    }
    
    
    self.currentImageView.image = [UIImage imageNamed:self.allImages[self.currentIndex]];
    
    NSInteger leftIndex = [self changeIndexWithDirectionType:LEFT And:self.currentIndex];
    NSInteger rightIndex = [self changeIndexWithDirectionType:RIGHT And:self.currentIndex];
    
    
    self.leftImageView.image = [UIImage imageNamed:self.allImages[leftIndex]];
    self.rightImageView.image = [UIImage imageNamed:self.allImages[rightIndex]];
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.pageControl.currentPage = rightIndex;
    
}

/**
 *  创建scrollView和imageView
 */
- (void)creatScrollViewAndImageViewWithFram:(CGRect)frame{
    //scrollView创建
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height)];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*3, self.scrollView.frame.size.height);
    self.scrollView.bounces = NO;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.scrollView];
    //imageView创建
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    self.currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    self.rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrollView.frame.size.width*2, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.currentImageView];
    [self.scrollView addSubview:self.rightImageView];
}
//显示图片
- (void)showImage{
//    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.allImages[self.allImages.count-1]]];
    self.leftImageView.image = [UIImage imageNamed:self.allImages[self.allImages.count-1]];
//    [self.currentImageView sd_setImageWithURL:[NSURL URLWithString:self.allImages[0]]];
    self.currentImageView.image = [UIImage imageNamed:self.allImages[0]];
    self.rightImageView.image = [UIImage imageNamed:self.allImages[1]];
//    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.allImages[1]]];
    
}
//创建pageControl
- (void)creatPageControl{
    CGFloat pageW = self.scrollView.frame.size.width;
    CGFloat pageH = 30;
    CGFloat pageX = 10;
    CGFloat pageY = self.scrollView.frame.size.height-pageH;
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(pageX, pageY, pageW, pageH)];
    self.pageControl.currentPage = 1;
    self.pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    self.pageControl.numberOfPages = self.allImages.count;
    [self addSubview:self.pageControl];
}
#pragma mark - 代理方法

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self removeTimer];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setImageViewLocal];
    [self addTimer];
    
   }

- (NSInteger)changeIndexWithDirectionType:(DIRECTION_TYPE)type And:(NSInteger)index{
    
    switch (type) {
        case LEFT:
            return --index<0? self.allImages.count-1:index;
            break;
        case RIGHT:
            return ++index > self.allImages.count-1?0:index;
            
    }
    
    
}


@end

