//
//  CZRightView.h
//  GourmetRecipes
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CZRightViewDelegate <NSObject>
- (void)rightViewChangeLeftViewBtnSelectdeWithInterger:(NSInteger)interger;

@end

@interface CZRightView : UIView
- (instancetype)initWithSteps:(NSArray *)steps WithInterger:(NSInteger)inter;

- (void)showNumberpage:(NSInteger)numpage;

/** <#属性#> */
@property(nonatomic ,strong)id<CZRightViewDelegate> delegate;

@end
