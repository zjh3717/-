//
//  ViewController.m
//  PopViewProgress
//
//  Created by mac on 2017/7/26.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ViewController.h"
#import "JHCircleProgressTool.h"

@interface ViewController ()<JHCircleProgressToolDelegate>
{
    float prog;
}


@property (nonatomic,strong) JHCircleProgressTool * circleView;




@end

@implementation ViewController

-(void)currentProgress:(CGFloat)progress
{
    NSLog(@"%f",progress);
    
}

-(JHCircleProgressTool *)circleView
{
    if (!_circleView) {
        self.circleView = [[JHCircleProgressTool alloc]initWithFrame:self.view.bounds progressViewOfLineWidth:30 withDelegate:self];
        self.circleView.progress = 0;
    }
    return _circleView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    prog =0;
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.circleView];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    prog+=.1;
    self.circleView.progress = prog;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
