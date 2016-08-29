//
//  ViewController.m
//  RZOLAnimation
//
//  Created by 赵林瑞 on 16/8/29.
//  Copyright © 2016年 ROL. All rights reserved.
//

#import "ViewController.h"

#import "ZMDrawRect.h"

#import "ZMDrawCircleWithAnimation.h"

#define ZMSCREEN_Width [UIScreen mainScreen].bounds.size.width
#define ZMSCREEN_Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}


- (void)setupUI {
    
    CGFloat w = 283*ZMSCREEN_Width/320;
    CGFloat h = 157*ZMSCREEN_Width/320;
    CGFloat x = (ZMSCREEN_Width - w)/2.f;
    CGFloat y = 64;
    ZMDrawRect *rect = [[ZMDrawRect alloc] initWithFrame:CGRectMake(x, y, w, h)];
    rect.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rect];
    
    rect.currentMonth = [NSNumber numberWithInteger:12];
    rect.isAnimation = YES;
    [rect show];
    rect.block = ^(NSNumber *n){
        NSLog(@"%@", n);
    };
    
    
    
    ZMDrawCircleWithAnimation *view = [[ZMDrawCircleWithAnimation alloc] initWithFrame:CGRectMake(x, 300, w, h)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

@end
