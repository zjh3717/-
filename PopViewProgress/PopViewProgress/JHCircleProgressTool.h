//
//  JHCircleProgressBgView.h
//  PopViewProgress
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol JHCircleProgressToolDelegate <NSObject>

@optional //代理可选方法
-(void)currentProgress:(CGFloat)progress;

@end

@interface JHCircleProgressTool : UIView
//需要用到代理方法时使用
-(instancetype)initWithFrame:(CGRect)frame progressViewOfLineWidth:(CGFloat)lineWidth withDelegate:(id<JHCircleProgressToolDelegate>)delegate;
//不需要用到代理方法时使用
-(instancetype)initWithFrame:(CGRect)frame progressViewOfLineWidth:(CGFloat)lineWidth;

//设置进度条进度
@property(nonatomic,assign)CGFloat progress;

@property(nonatomic,weak)id<JHCircleProgressToolDelegate>delegate;

@end
