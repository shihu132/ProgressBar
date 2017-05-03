//
//  SHinearProgresView.h
//  ProgressBar
//
//  Created by 石虎 on 2017/5/2.
//  Copyright © 2017年 shihu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  SHLinearProgresViewDelegate<NSObject>

- (void)changeTextProgress:(NSString*)string;//修改进度标签内容
- (void)endTime;//进度条结束时
@end

@interface SHLinearProgresView : UIView

@property (retain, nonatomic) UIImageView *trackView;// 背景图像
@property (retain, nonatomic) UIImageView *progressView;// 填充图像
@property (retain, nonatomic) NSTimer *progressTimer; //时间定时器
@property (nonatomic) CGFloat targetProgress; //进度
@property (nonatomic) CGFloat currentProgress; //当前进度
@property (nonatomic, strong)id<SHLinearProgresViewDelegate> delegate;
- (void)setProgress:(CGFloat)progress;//设置进度
@end
