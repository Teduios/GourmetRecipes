//
//  CZLeftView.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CZLeftViewDelegate <NSObject>
- (void)leftViewBackController;
- (void)leftViewShowPageOfClickNumber:(NSInteger)pageNumber;
- (void)leftAddTiming;
@end


@interface CZLeftView : UIView

- (instancetype)initWithArray:(NSArray *)array WithTag:(NSInteger)inter;

/** <#属性#> */
@property(nonatomic ,strong)id<CZLeftViewDelegate> delegate;

- (void)changeSelecteWithInterger:(NSInteger)interger;

@end
