//
//  CZSearchScrollView.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/22.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZSearchScrollView.h"
#import "CZFoodDetailedModel.h"
@interface CZSearchScrollView ()
@property(nonatomic ,strong)CZFoodDetailedResultModel *model;

/** <#属性#> */
@property(nonatomic ,assign)CGRect rect;
/**  */
@property (nonatomic ,assign) CGFloat Y;
@end


@implementation CZSearchScrollView

- (instancetype)initWithFrame:(CGRect)frame WithModel:(CZFoodDetailedResultModel *)model{

    if (self = [super initWithFrame:frame]) {
        self.rect = frame;
        self.model = model;
 
        self.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 9);
        self.backgroundColor = [UIColor whiteColor];
        [self addNameLabel];
        [self addDescriptionView];
        [self addSummarylabel];
        
        [self addFoodImageView];
        
        [self addMessageLabel];
        self.contentSize = CGSizeMake(self.bounds.size.width, self.Y);
        
    }
    
    return self;
}
/**
 *  添加标题Label
 */
- (void)addNameLabel{
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.rect.size.width, 40)];
    [self addSubview:self.nameLabel];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    self.nameLabel.backgroundColor = [UIColor whiteColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.text = self.model.name;
    [self addSeparatedViewWithY:CGRectGetMaxY(self.nameLabel.frame)];
}
/**
 *  添加食材描述
 */
- (void)addDescriptionView{
    NSMutableString *string = [NSMutableString stringWithFormat:@"%@",self.model.desc];
    NSRange ran = {0,string.length};
    [string stringByReplacingOccurrencesOfString:@"</p>" withString:@" " options:NSAnchoredSearch range:ran];
    NSRange ran1 = {0,string.length};
    [string stringByReplacingOccurrencesOfString:@"<p>" withString:@"" options:NSAnchoredSearch range:ran1];
    NSRange ran2 = {0,string.length};
    [string replaceOccurrencesOfString:@"<h2>" withString:@" " options:NSLiteralSearch range:ran2];
    NSRange ran3 = {0,string.length};
    [string replaceOccurrencesOfString:@"</h2>" withString:@"" options:NSLiteralSearch range:ran3];
    
    NSRange ran4 = {0,string.length};
    [string replaceOccurrencesOfString:@"<strong>" withString:@"" options:NSLiteralSearch range:ran4];
    NSRange ran5 = {0,string.length};
    [string replaceOccurrencesOfString:@"</strong>" withString:@"" options:NSLiteralSearch range:ran5];
    NSRange ran6 = {0,string.length};
    [string replaceOccurrencesOfString:@"<br />" withString:@"" options:NSLiteralSearch range:ran6];
    NSRange ran7 = {0,string.length};
    [string replaceOccurrencesOfString:@"<br>" withString:@"" options:NSLiteralSearch range:ran7];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.rect.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    
    
    UIView *descriptopnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.Y, self.rect.size.width, size.height+20)];
    [self addSubview:descriptopnView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.rect.size.width-20, 20)];
    titleLabel.text = @"食材描述:";
    titleLabel.font = [UIFont systemFontOfSize:16];
    UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame), self.rect.size.width-20, size.height)];
    [descriptopnView addSubview:descLabel];
    [descriptopnView addSubview:titleLabel];
    descLabel.numberOfLines = 0;
    descLabel.text = string;
    descLabel.font = [UIFont systemFontOfSize:15];
    
    self.Y = CGRectGetMaxY(descriptopnView.frame);

}
/**
 *  添加摘要
 */
- (void)addSummarylabel{
    NSMutableString *string = [NSMutableString stringWithFormat:@"%@",self.model.summary];
    NSRange ran = {0,string.length};
    [string replaceOccurrencesOfString:@"</p>" withString:@" " options:NSLiteralSearch range:ran];
    NSRange ran1 = {0,string.length};
    [string replaceOccurrencesOfString:@"<p>" withString:@"" options:NSLiteralSearch range:ran1];
    NSRange ran2 = {0,string.length};
    [string replaceOccurrencesOfString:@"<h2>" withString:@" " options:NSLiteralSearch range:ran2];
    NSRange ran3 = {0,string.length};
    [string replaceOccurrencesOfString:@"</h2>" withString:@"" options:NSLiteralSearch range:ran3];
    NSRange ran4 = {0,string.length};
    [string replaceOccurrencesOfString:@"<strong>" withString:@"" options:NSLiteralSearch range:ran4];
    NSRange ran5 = {0,string.length};
    [string replaceOccurrencesOfString:@"</strong>" withString:@"" options:NSLiteralSearch range:ran5];
    NSRange ran6 = {0,string.length};
    [string replaceOccurrencesOfString:@"<br />" withString:@"" options:NSLiteralSearch range:ran6];
    NSRange ran7 = {0,string.length};
    [string replaceOccurrencesOfString:@"<br>" withString:@"" options:NSLiteralSearch range:ran7];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.rect.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    UIView *summaryView = [[UIView alloc]initWithFrame:CGRectMake(0, self.Y+5, self.rect.size.width, size.height+20)];
    [self addSubview:summaryView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.rect.size.width-20, 20)];
    titleLabel.text = @"摘要:";
    titleLabel.font = [UIFont systemFontOfSize:16];
    UILabel *summaryLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame), self.rect.size.width-40, size.height)];
    [summaryView addSubview:summaryLabel];
    [summaryView addSubview:titleLabel];
    summaryLabel.numberOfLines = 0;
    summaryLabel.text = string;
    summaryLabel.font = [UIFont systemFontOfSize:15];
    self.Y = CGRectGetMaxY(summaryView.frame);

}
/**
 *  添加食材图片
 */
- (void)addFoodImageView{
    
    UIImageView *foodImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.Y+5, self.rect.size.width, 1.0*self.rect.size.width*2/3)];
    foodImageView.contentMode = UIViewContentModeScaleAspectFit;
    [foodImageView sd_setImageWithURL:[NSURL URLWithString:self.model.img]];
    
    [self addSubview:foodImageView];
    self.Y = CGRectGetMaxY(foodImageView.frame);

}
/**
 *  添加详细
 */
- (void)addMessageLabel{
    NSMutableString *string = [NSMutableString stringWithFormat:@"%@",self.model.message];
    NSRange ran = {0,string.length};
    [string replaceOccurrencesOfString:@"</p>" withString:@" " options:NSLiteralSearch range:ran];
    NSRange ran1 = {0,string.length};
    [string replaceOccurrencesOfString:@"<p>" withString:@"" options:NSLiteralSearch range:ran1];
    NSRange ran2 = {0,string.length};
    [string replaceOccurrencesOfString:@"<h2>" withString:@" " options:NSLiteralSearch range:ran2];
    NSRange ran3 = {0,string.length};
    [string replaceOccurrencesOfString:@"</h2>" withString:@"" options:NSLiteralSearch range:ran3];
    NSRange ran4 = {0,string.length};
    [string replaceOccurrencesOfString:@"<strong>" withString:@"" options:NSLiteralSearch range:ran4];
    NSRange ran5 = {0,string.length};
    [string replaceOccurrencesOfString:@"</strong>" withString:@"" options:NSLiteralSearch range:ran5];
    NSRange ran6 = {0,string.length};
    [string replaceOccurrencesOfString:@"<br />" withString:@"" options:NSLiteralSearch range:ran6];
    NSRange ran7 = {0,string.length};
    [string replaceOccurrencesOfString:@"<br>" withString:@"" options:NSLiteralSearch range:ran7];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(self.rect.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, self.Y+5, self.rect.size.width-40, size.height)];
    messageLabel.text = string;
    messageLabel.numberOfLines = 0;
    messageLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:messageLabel];

    self.Y = CGRectGetMaxY(messageLabel.frame);
}




/**
 *  添加分割线
 */

- (void)addSeparatedViewWithY:(CGFloat)Y{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, Y, self.frame.size.width, kSeparated)];
    label.textColor = kColorRGB(150, 150, 150, 1);
    label.backgroundColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:25];
    label.text = @" · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · · ";
    label.textAlignment = NSTextAlignmentCenter;
    self.Y = CGRectGetMaxY(label.frame);
    [self addSubview:label];
}

@end
