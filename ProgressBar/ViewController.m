//
//  ViewController.m
//  ProgressBar
//
//  Created by 石虎 on 2017/5/2.
//  Copyright © 2017年 shihu. All rights reserved.
//

#import "ViewController.h"
#import "SHProgressBarView.h"
#import "SHLinearProgresView.h"

#define RGB(r, g, b)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface ViewController ()<SHLinearProgresViewDelegate>

@property (nonatomic,strong) SHProgressBarView *pieChartView;
@property (nonatomic,strong) SHLinearProgresView *progresView;
@property (nonatomic,strong) UILabel *lable;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self arcProgress];//弧形进度条
    [self linearProgress];//直线进度条
    [self lableNumDate];
}


//*********** *********** 弧形进度条 *********** ***********


#pragma mark - 弧形进度条
- (void)arcProgress
{
    //画弧形
    CGFloat width = 200;
    SHProgressBarView *pieChartView = [[SHProgressBarView alloc]initWithFrame:CGRectMake(30,120, width, width)];
    //颜色
    pieChartView.gradientLayer.colors = @[(id)RGB(245, 101, 62).CGColor, (id)RGB(245, 101, 62).CGColor];
    _pieChartView = pieChartView;
    //数值进度
    [pieChartView updatePercent:90 animation:YES];
    //数值字体
    pieChartView.progressLabel.text = [NSString stringWithFormat:@"%@%%",@"90"];
    pieChartView.progressLabel.textColor = [UIColor blackColor];
    [self.view addSubview:pieChartView];
}






//*********** *********** 直线进度条 *********** ***********








#pragma mark - 直线进度条
- (void)linearProgress
{
    [self setStraightLineProgres:88];
}

- (void)setStraightLineProgres:(CGFloat)percent
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10,330, 300, 20)];
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    SHLinearProgresView *progresView = [[SHLinearProgresView alloc]initWithFrame:CGRectMake(0, 0, 300, 20)];
    progresView.progressView.backgroundColor = RGB(236, 98 , 55);
    progresView.delegate = self;
    _progresView = progresView;
    [view addSubview:progresView];
    [progresView setProgress:percent];    //设置进条值
}
#pragma CustomeProgressDelagate
-(void)changeTextProgress:(NSString *)string
{
    NSLog(@"string---%@",string);
    _lable.text = string;//标签上显示进度
}
-(void)endTime
{
    //进度完成时，做某些处理
}

- (void)lableNumDate
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10,370, 120, 20)];
    lable.font = [UIFont systemFontOfSize:20];
    lable.textAlignment = NSTextAlignmentCenter;
    _lable = lable;
    [self.view addSubview:lable];
}
@end
