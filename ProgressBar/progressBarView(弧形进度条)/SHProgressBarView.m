//
//  SHProgressBarView.m
//  ProgressBar
//
//  Created by 石虎 on 2017/5/2.
//  Copyright © 2017年 shihu. All rights reserved.
//

#import "SHProgressBarView.h"

#define RGB(r, g, b)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation SHProgressBarView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {

        self.animationDuration = 5;
        self.pathWidth = self.bounds.size.width / 1.15;
        [self trackLayer];
        [self gradientLayer];
    }
    return self;
}

//进度和背景的宽度
- (void)loadLayer:(CAShapeLayer *)layer WithColor:(UIColor *)color {
    
    CGFloat layerWidth = self.pathWidth;
    CGFloat layerX = (self.bounds.size.width - layerWidth)/2;
    layer.frame = CGRectMake(layerX, layerX, layerWidth, layerWidth);
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineCap = kCALineCapButt;
    layer.lineWidth = self.lineWidth;
    layer.path = self.path.CGPath;
}

#pragma mark - Animation
- (void)updatePercent:(CGFloat)percent animation:(BOOL)animationed {
    self.percent = percent;
    [self.progressLayer removeAllAnimations];
    
    if (!animationed) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [CATransaction setAnimationDuration:1];
        
        self.progressLayer.strokeEnd = self.percent / 100.0;
        
        [CATransaction commit];
    } else {
        CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        animation.fromValue = @(0.0);
        animation.toValue = @(self.percent / 100.);
        animation.duration = self.animationDuration * self.percent / 100;
        animation.removedOnCompletion = YES;
        animation.delegate = self;
        animation.timingFunction    = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        self.progressLayer.strokeEnd = self.percent / 100;
        [self.progressLayer addAnimation:animation forKey:@"strokeEndAnimation"];
    }
}

#pragma mark - CAAnimationDelegate
//字体的动画
- (void)animationDidStart:(CAAnimation *)anim {
    
    self.timer = [NSTimer timerWithTimeInterval:1/60.f target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
#pragma  mark - 石虎  弧形赋值
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        [self invalidateTimer];
        //self.progressLabel.text = [NSString stringWithFormat:@"%.1f%%", self.percent];        
    }
}

- (void)timerAction {
    id strokeEnd = [[_progressLayer presentationLayer] valueForKey:@"strokeEnd"];
    if (![strokeEnd isKindOfClass:[NSNumber class]]) {
        return;
    }
    CGFloat progress = [strokeEnd floatValue];
    //字体赋值
        self.progressLabel.text = [NSString stringWithFormat:@"%0.f%%",floorf(progress * 100)];
}

- (void)invalidateTimer {
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Getters & Setters
#pragma mark - 背景圆形图
- (CAShapeLayer *)trackLayer {
    if (!_trackLayer) {
        _trackLayer = [CAShapeLayer layer];
#warning -- 进度条颜色--调整
        
        UIColor *color = RGB(251, 213,213);
        [self loadLayer:_trackLayer WithColor:color];
        [self.layer addSublayer:_trackLayer];
    }
    return _trackLayer;
}
- (CAShapeLayer *)progressLayer {
    if (!_progressLayer) {
        _progressLayer = [CAShapeLayer layer];
        UIColor *color = RGB(245, 101, 62);
        [self loadLayer:_progressLayer WithColor:color];
        _progressLayer.strokeEnd = 0;
    }
    return _progressLayer;
}
#pragma mark - 进度条颜色
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
#warning -- 进度条颜色--调整

        _gradientLayer.colors = @[(id)[UIColor cyanColor].CGColor,
                                  (id)[UIColor colorWithRed:0.000 green:10.502 blue:1.000 alpha:1.000].CGColor];
        [_gradientLayer setStartPoint:CGPointMake(0.5, 1.0)];
        [_gradientLayer setEndPoint:CGPointMake(0.5, 0.0)];
        
        [_gradientLayer setMask:self.progressLayer];
        [self.layer addSublayer:_gradientLayer];
        
    }
    return _gradientLayer;
}
#pragma mark - 进度条里面字体
- (UILabel *)progressLabel {
    if (!_progressLabel) {

        _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 - 25, self.frame.size.width, 50)];
        _progressLabel.textColor = [UIColor whiteColor];
        _progressLabel.textAlignment = NSTextAlignmentCenter;
        _progressLabel.font = [UIFont systemFontOfSize:27];
        
        [self addSubview:_progressLabel];
    }
    return _progressLabel;
}
- (void)setPercent:(CGFloat)percent {
    _percent = percent;
    _percent = _percent > 100 ? 100 : _percent;
    _percent = _percent < 0 ? 0 : _percent;
}

#pragma mark - 动画画圆
- (UIBezierPath *)path {
    if (!_path) {
        
        CGFloat halfWidth = self.pathWidth / 2;
        _path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(halfWidth, halfWidth)  radius:(self.pathWidth - self.lineWidth)/2 startAngle:-M_PI/2 endAngle:M_PI/2*3 clockwise:YES];
    }
    return _path;
}

- (CGFloat)lineWidth {
    if (_lineWidth == 0) {
        _lineWidth = 5;
    }
    return _lineWidth;
}
@end
