//
//  CZCokingViewController.m
//  GourmetRecipes
//
//  Created by tarena on 16/4/15.
//  Copyright © 2016年 zcz. All rights reserved.
//

#import "CZCokingViewController.h"
#import "CZLeftView.h"
#import "CZRightView.h"
#import <AVFoundation/AVFoundation.h>
@interface CZCokingViewController ()<CZLeftViewDelegate,CZRightViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

/** 右边视图 */
@property(nonatomic ,strong)CZRightView *rightView;
/** 左边视图 */
@property(nonatomic ,strong)CZLeftView *leftView;

/** 是否已设置计时 */
@property (nonatomic ,assign ,getter=isTiming) BOOL timing;

/** 计时模糊界面 */
@property(nonatomic ,strong) UIView * fuzzyView;

/** 添加pickerView的View */
@property(nonatomic ,strong) UIView *timingView;
/** xiaosh */
@property (nonatomic ,assign) NSInteger hour;
/** fenzhong */
@property (nonatomic ,assign) NSInteger min;


/** 定时数据源数组 */
@property(nonatomic ,strong)NSMutableArray *timingArray;
/** 定时总秒数 */
@property (nonatomic ,assign) NSInteger allSecond;
/** 定时器 */
@property(nonatomic ,strong)NSTimer *timer1;

/** 秒定时器 */
@property(nonatomic ,strong)NSTimer *timer2;
/** 显示事件label */
@property(nonatomic ,strong)UILabel *showTimeLabel;
/** 音乐播放 */
@property(nonatomic ,strong)AVAudioPlayer *musicPlayer ;

@end

@implementation CZCokingViewController

#pragma mark - 懒加载
- (NSMutableArray *)timingArray{
    if (_timingArray == nil) {
        NSMutableArray *hours = [[NSMutableArray alloc]initWithCapacity:24];
        NSMutableArray *minutes = [[NSMutableArray alloc]initWithCapacity:60];
        for (NSInteger i = 0; i<24; i++) {
            [hours addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        for (NSInteger i = 0; i<60; i++) {
            [minutes addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        _timingArray = [[NSMutableArray alloc]initWithCapacity:2];
        [_timingArray addObject:hours];
        [_timingArray addObject:minutes];
        
        
    }
    return _timingArray;
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addLeftView];
    [self addRightView];

    

}
- (void)viewDidAppear:(BOOL)animated{
    [UIView animateWithDuration:0.2 animations:^{
    [self leftViewShowPageOfClickNumber:self.inter];
    }];

}
#pragma mark - 方法
/**
 *  添加左边视图
 */
- (void)addLeftView{
    self.leftView = [[CZLeftView alloc]initWithArray:self.steps WithTag:self.inter];
    
    self.leftView.delegate = self;
    [self.view addSubview:self.leftView];
    __weak typeof(self) weakSelf = self;
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.view.left);
        make.top.mas_equalTo(weakSelf.view.top);
        make.height.mas_equalTo(weakSelf.view.height);
        make.width.mas_equalTo(50);
    }];
    self.leftView.backgroundColor = kBgColor;
    
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(weakSelf.view.height);
        make.left.mas_equalTo(50);
        make.top.mas_equalTo(weakSelf.view.top);
    }];
    view.backgroundColor = [UIColor lightGrayColor];
    
    

}


/**
 *  添加右边视图
 */
- (void)addRightView{
    
    self.rightView = [[CZRightView alloc]initWithSteps:self.steps WithInterger:self.inter];
    
    self.rightView.delegate = self;
    [self.view addSubview:self.rightView];
    __weak typeof(self) weakSelf = self;
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(weakSelf.view.height);
        make.width.mas_equalTo(weakSelf.view.width -51);
        make.top.mas_equalTo(weakSelf.view.top);
        make.left.mas_equalTo(weakSelf.view).with.offset(51);
    }];
    self.rightView.backgroundColor = kBgColor;

}

/**
 *  添加计时器
 */
- (void)addTimer1{
    __weak typeof(self) weakSelf = self;
    self.timer1 = [NSTimer timerWithTimeInterval:self.allSecond block:^(NSTimer * _Nonnull timer) {
        weakSelf.musicPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"frxz.mp3" withExtension:nil] error:nil];
        [weakSelf.musicPlayer prepareToPlay];
        [weakSelf.musicPlayer play];
        
        [weakSelf cancelCountDown];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否关闭铃声" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.musicPlayer stop];
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不关闭" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [alert addAction:cancelAction];
        [weakSelf presentViewController:alert animated:YES completion:nil];
        
    } repeats:NO];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
}
- (void)addTimer2:(UILabel *) showLabel{
    __weak typeof(self) weakSelf = self;
    self.timer2 =[NSTimer timerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
        weakSelf.allSecond -=1;
        NSInteger hour = weakSelf.allSecond/3600;
        NSInteger min = weakSelf.allSecond%3600/60;
        NSInteger sec = weakSelf.allSecond%3600%60;
        showLabel.text = [NSString stringWithFormat:@"%ld:%ld:%ld",hour,min,sec];
    } repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer2 forMode:NSRunLoopCommonModes];
}

/**
 *  开始计时
 */
- (void)beginAddTiming{
    self.timing = YES;
    
    
    [self addTimer1];
    
    
    self.timingView.hidden = NO;
    self.timingView.alpha = 0;
    
    UIView * countDownView = [[UIView alloc]initWithFrame:CGRectMake(80, self.view.frame.size.height/3, self.view.frame.size.width -160, self.view.frame.size.height/3)];
    countDownView.backgroundColor = [UIColor clearColor];
    [self.fuzzyView addSubview:countDownView];

    self.showTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, countDownView.frame.size.width, 40)];
    self.showTimeLabel.font = [UIFont systemFontOfSize:40];
    self.showTimeLabel.backgroundColor = [UIColor clearColor];
    self.showTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.showTimeLabel.textColor = [UIColor whiteColor];
    [countDownView addSubview:self.showTimeLabel];
    
    [self addTimer2:self.showTimeLabel];
    
    
    UIButton *stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(countDownView.frame.size.width*0.2, CGRectGetHeight(countDownView.frame)-25, countDownView.frame.size.width*0.6, 20)];
    [stopBtn setTitle:@"X 取消计时" forState:UIControlStateNormal];
    [stopBtn setBackgroundColor:[UIColor redColor]];
    stopBtn.layer.cornerRadius = 5;
    stopBtn.clipsToBounds = YES;
    [stopBtn addTarget:self action:@selector(cancelCountDown) forControlEvents:UIControlEventTouchUpInside];
    [countDownView addSubview:stopBtn];
    
    UIButton *countDownBtn = [[UIButton alloc]initWithFrame:CGRectMake((countDownView.bounds.size.width-self.view.frame.size.width*0.25) *0.5 ,CGRectGetMaxY(self.showTimeLabel.frame)+10 ,self.view.frame.size.width*0.25,self.view.frame.size.width*0.25)];
    countDownBtn.backgroundColor = [UIColor whiteColor];
    [countDownBtn setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
    [countDownBtn setBackgroundImage:[UIImage imageNamed:@"jixu"] forState:UIControlStateSelected];
    countDownBtn.layer.cornerRadius = CGRectGetWidth(countDownBtn.frame)*0.5;
    countDownBtn.clipsToBounds = YES;
    countDownBtn.backgroundColor = [UIColor clearColor];
    [countDownBtn addTarget:self action:@selector(stopOrBegin:) forControlEvents:UIControlEventTouchUpInside];
    [countDownView addSubview:countDownBtn];
    
    
    
    

}
/**
 *  取消倒计时
 */
- (void)cancelCountDown{
    [self.timer1 invalidate];
    [self.timer2 invalidate];
    self.timing = NO;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.fuzzyView removeFromSuperview];
    }];
    self.fuzzyView = nil;

}

/**
 *  暂停或继续
 */
- (void)stopOrBegin:(UIButton *)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self.timer1 invalidate];
        [self.timer2 invalidate];
    }else{
        [self addTimer1];
        [self addTimer2:self.self.showTimeLabel];
    
    }

    
}


- (void)touchfuzzyView{
    __weak typeof(self) weakSelf = self;
    if (self.isTiming) {
        
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.fuzzyView.transform = CGAffineTransformTranslate(weakSelf.fuzzyView.transform, -weakSelf.fuzzyView.frame.size.width*0.5, 0.5*weakSelf.fuzzyView.frame.size.height);
            weakSelf.fuzzyView.transform = CGAffineTransformScale(weakSelf.fuzzyView.transform, 0.00001, 0.00001);
            weakSelf.fuzzyView.transform = CGAffineTransformRotate(weakSelf.fuzzyView.transform, 0.9*M_2_PI);

        }];
        

    }else{
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.fuzzyView.alpha = 0;
        weakSelf.timingView.alpha = 0;
        weakSelf.fuzzyView = nil;
        weakSelf.timingView = nil;
 
    }];
        
        
    }
    
    
}


#pragma mark - 自定义代理方法
- (void)leftViewBackController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)leftViewShowPageOfClickNumber:(NSInteger)pageNumber{

    [self.rightView showNumberpage:pageNumber];
    
}
/**
 *  添加计时器
 */
- (void)leftAddTiming{
    if (!self.isTiming) {
        
        self.fuzzyView = [[UIView alloc]initWithFrame:self.view.frame];
        self.fuzzyView.backgroundColor = [UIColor blackColor];
        self.fuzzyView.alpha = 0;
        self.fuzzyView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchfuzzyView)];
        [self.fuzzyView addGestureRecognizer:tap];
        //添加pickerView 的View
        self.timingView = [[UIView alloc]initWithFrame:CGRectMake(20, (self.fuzzyView.frame.size.height - (self.fuzzyView.frame.size.width-40)*2/3)*0.5, self.fuzzyView.frame.size.width-40 ,(self.fuzzyView.frame.size.width-40)*2/3 )];
        self.timingView.layer.cornerRadius = 15;
        self.timingView.clipsToBounds = YES;
        self.timingView.backgroundColor = kBgColor;
        
        UILabel *timingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 8, CGRectGetWidth(self.timingView.frame), 20)];
        timingLabel.font = [UIFont systemFontOfSize:15];
        timingLabel.textAlignment = NSTextAlignmentCenter;
        timingLabel.textColor = [UIColor grayColor];
        timingLabel.text = @"设置时间";
        [self.timingView addSubview:timingLabel];
        
        UIPickerView *hourPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(timingLabel.frame)+5, (CGRectGetWidth(self.timingView.frame)-20)*0.5, CGRectGetHeight(self.timingView.frame)-8 -CGRectGetHeight(timingLabel.frame)-5 -10-25)];
        UIPickerView *minPickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(hourPickerView.frame), CGRectGetMinY(hourPickerView.frame), CGRectGetWidth(hourPickerView.frame), CGRectGetHeight(hourPickerView.frame))];
        minPickerView.backgroundColor = kBgColor;
        hourPickerView.backgroundColor = kBgColor;
        [self.timingView addSubview:hourPickerView];
        [self.timingView addSubview:minPickerView];
        minPickerView.delegate = self;
        minPickerView.dataSource = self;
        hourPickerView.delegate = self;
        hourPickerView.dataSource = self;
        hourPickerView.tag = 1;
        minPickerView.tag =2;
        
        [minPickerView selectRow:3000 inComponent:0 animated:NO];
        
        UILabel *hourLabel = [[UILabel alloc]initWithFrame:CGRectMake(hourPickerView.frame.size.width-50, (hourPickerView.frame.size.height -20)*0.5, 50, 20)];
        UILabel *minLabel = [[UILabel alloc]initWithFrame:CGRectMake(minPickerView.frame.size.width-50, (minPickerView.frame.size.height -20)*0.5, 50, 20)];
        [hourPickerView addSubview:hourLabel];
        [minPickerView addSubview:minLabel];
        hourLabel.text = @"小时";
        minLabel.text = @"分钟";
        hourLabel.font = [UIFont boldSystemFontOfSize:16];
        minLabel.font = [UIFont boldSystemFontOfSize:16];
        
        
        UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake((timingLabel.frame.size.width -80)*0.5, CGRectGetMaxY(hourPickerView.frame)+5, 80, 25)];
        [startBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [startBtn addTarget:self action:@selector(beginAddTiming) forControlEvents:UIControlEventTouchUpInside];
        [startBtn setTitle:@"开始计时" forState:UIControlStateNormal];
        [self.timingView addSubview:startBtn];
        
        [self.view addSubview:self.fuzzyView];
        
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.fuzzyView.alpha = 0.7;
            [weakSelf.view addSubview:self.timingView];
        }];
    }else{
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.5 animations:^{
            weakSelf.fuzzyView.alpha = 0.7;
            weakSelf.fuzzyView.transform = CGAffineTransformScale(self.fuzzyView.transform, 100000, 100000);
            weakSelf.fuzzyView.transform = CGAffineTransformRotate(self.fuzzyView.transform, -0.9*M_2_PI);
            weakSelf.fuzzyView.transform = CGAffineTransformTranslate(self.view.transform, 0, 0);
        }];

        
    }
    
    
    


}






- (void)rightViewChangeLeftViewBtnSelectdeWithInterger:(NSInteger)interger{

    [self.leftView changeSelecteWithInterger:interger];

}

#pragma mark - UIPickerViewDelegate和dateSouse

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1 ;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return [self.timingArray[0] count];
    } else{
        return [self.timingArray[1]count];
    }
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (pickerView.tag == 1) {
        return self.timingArray[0][row];
    }else{
        return self.timingArray[1][row%[self.timingArray[1] count]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
 
    if (pickerView.tag == 2) {
         self.min = [self.timingArray[1][row] integerValue];
        
    }else if( pickerView.tag == 1 ){
         self.hour = [self.timingArray[0][row] integerValue];
    }
    
    self.allSecond = self.hour*60*60+self.min*60;

    

}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
