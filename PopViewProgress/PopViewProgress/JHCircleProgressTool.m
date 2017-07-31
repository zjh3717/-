//
//  JHCircleProgressBgView.m
//  PopViewProgress
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "JHCircleProgressTool.h"
#import "JHCircleProgress.h"

#define KcircleFrameBgViewOfTop 20*KAutoLayoutWidth
#define KcircleFrameBgViewOfSide 20*KAutoLayoutWidth
#define KAutoLayoutWidth  SCREEN_WIDTH/320
#define KAutoLayoutHeight  SCREEN_HEIGHT/568

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface JHCircleProgressTool()
@property (nonatomic,strong) JHCircleProgress *pathView;

@property(nonatomic,assign)CGFloat lineWidth;

@property (nonatomic,strong) UIView * bgView;
@property (nonatomic,strong) UIButton *closeBtn;

@end



@implementation JHCircleProgressTool

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UIView *)bgView
{
    if (!_bgView) {
        self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (self.frame.size.width - 60*KAutoLayoutWidth), self.frame.size.width)];
        self.bgView.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
        self.bgView.layer.cornerRadius = 10;
        self.bgView.center = self.center;
//        [self showViewWithAlertAnimation:self.bgView];
        
    }
    return _bgView;
}
-(JHCircleProgress *)pathView
{
    if (!_pathView) {
        
        self.pathView =[[JHCircleProgress alloc]initWithFrame:CGRectMake(KcircleFrameBgViewOfSide, KcircleFrameBgViewOfTop, (self.frame.size.width - 100*KAutoLayoutWidth), (self.frame.size.width - 80*KAutoLayoutHeight)) lineWidth:_lineWidth];
        _pathView.backgroundColor =[UIColor clearColor];
        //        _pathView.center = self.view.center;
        
    }
    return _pathView;
}

-(UIButton *)closeBtn
{
    if (!_closeBtn) {
        self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.closeBtn.frame = CGRectMake(40, self.pathView.frame.size.height+KcircleFrameBgViewOfTop, self.bgView.frame.size.width-80,30*KAutoLayoutHeight) ;
        //        self.closeBtn.center = self.bgView.center;
        [self.closeBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.closeBtn.backgroundColor = [UIColor whiteColor];
        [self.closeBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [self.closeBtn addTarget:self action:@selector(finishBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn.backgroundColor = [UIColor blueColor];
        self.closeBtn.layer.cornerRadius = 10;
    }
    return _closeBtn;
}

-(void)finishBtnClick:(UIButton *)sender
{
    [self removeFromSuperview];
}

-(instancetype)initWithFrame:(CGRect)frame progressViewOfLineWidth:(CGFloat)lineWidth withDelegate:(id<JHCircleProgressToolDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth*KAutoLayoutWidth;
        self.delegate = delegate;
//        _lineWidth = lineWidth;
        
        [self setBackGroundViewWithFrame:frame];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame progressViewOfLineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        _lineWidth = lineWidth*KAutoLayoutWidth;
//        self.delegate = delegate;
//                _lineWidth = lineWidth;
        
        [self setBackGroundViewWithFrame:frame];
    }
    return self;
}

-(void)setBackGroundViewWithFrame:(CGRect)frame
{
    [self.bgView addSubview:self.closeBtn];
    [self.bgView addSubview:self.pathView];
    [self showViewWithAlertAnimation:self.bgView];

    [self addSubview:self.bgView];
    
}
//弹窗动画
-(void)showViewWithAlertAnimation:(UIView *)view
{
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 0.9)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName: @"easeInEaseOut"];
    
    [view.layer addAnimation:animation forKey:nil];
    
    view.transform = CGAffineTransformMakeScale(1, 1);
}

-(void)setProgress:(CGFloat)progress
{
    self.pathView.progress = progress;
    if ([self.delegate respondsToSelector:@selector(currentProgress:)]) {
        [self.delegate currentProgress:progress];
    }
    
    NSString * pro = [NSString stringWithFormat:@"%f",progress];
    if ([pro isEqualToString:@"1.000000"]) {
        [self.closeBtn setEnabled:YES];
        self.closeBtn.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:1];
    }else
    {
        [self.closeBtn setEnabled:NO];
        self.closeBtn.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];

    }
    
}

@end
