//
//  UIScrollView+Refresh.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/10.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "UIScrollView+Refresh.h"

@implementation UIScrollView (Refresh)
- (void)addHeaderRefresh:(MJRefreshComponentRefreshingBlock)block{
    self.mj_header = [MJRefreshHeader headerWithRefreshingBlock:block];
}
- (void)beginHeaderRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header beginRefreshing];
    });
}
- (void)endHeadrtRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_header endRefreshing];
    });
}



- (void)addAutoFooterRefresh:(MJRefreshComponentRefreshingBlock)block{
    self.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:block];

}
- (void)addBackFooterRefresh:(MJRefreshComponentRefreshingBlock)block{
    
    self.mj_footer = [MJRefreshBackFooter footerWithRefreshingBlock:block];
    
}
- (void)beginFooterRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer beginRefreshing];
    });
}
- (void)endFooterRefresh{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mj_footer endRefreshing];
    });

}


@end
