//
//  SHProgressBarView.h
//  ProgressBar
//
//  Created by 石虎 on 2017/5/2.
//  Copyright © 2017年 shihu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHProgressBarView : UIView

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, assign) UIColor *progressColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, assign) CGFloat percent; //饼状图显示的百分比，最大为100
@property (nonatomic, assign) CGFloat animationDuration;//动画持续时长
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat pathWidth;
@property (nonatomic, strong) UILabel *progressLabel;

@property (nonatomic, assign) BOOL panAnimationing;
- (void)updatePercent:(CGFloat)percent animation:(BOOL)animationed;
@end
