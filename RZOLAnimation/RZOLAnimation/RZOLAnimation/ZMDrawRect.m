//
//  ZMDrawRect.m
//  testDemo
//
//  Created by 赵林瑞 on 16/5/17.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#import "ZMDrawRect.h"
#import "autoButton.h"

#define ZMScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZMScreenHeight [UIScreen mainScreen].bounds.size.height
#define w self.frame.size.width
#define h self.frame.size.height
// 位置适配
#define ZMScacle (w/283.f)
#define ZM_SPACE(x) ((x) * ZMScacle)
#define ZM_circle_X w/2.f
#define ZM_circle_Y h - ZM_SPACE(15)
// 角度
#define ZMAngle_Scacle M_PI_2/90
// 字号适配
#define ZM_FONT(x) [UIFont systemFontOfSize:x*ZMScacle]
// 传入色值////////////////////////////////////
#define ZMHEXCOLOR_a(hex,a) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:(a)]
#define ZMHEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]
// ///////////////////////////////////////////



@interface ZMDrawRect ()
{
    CALayer *_needleLayer;
    CAShapeLayer *_layer_path1;
    CAShapeLayer *_layer_path2;
}

/**
 *  当前角度
 */
@property(nonatomic) CGFloat currentRadian;

/**
 *  存储btn
 */
@property (nonatomic, strong) NSMutableArray *btnArr;

/**
 *  一共多少个月份
 */
@property (nonatomic, strong) NSNumber *month_count;

/**
 *  显示月份
 */
@property (nonatomic, strong) UILabel *label;

@end

@implementation ZMDrawRect

- (id) init
{
    self = [super init];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawLine1];
}
#pragma mark - 画图
- (void)drawLine1 {
    
    CGPoint point = CGPointMake(ZM_circle_X, ZM_circle_Y);
    CGFloat startA = 0;
    CGFloat midA = - M_PI_2 + self.currentRadian;
    CGFloat endA = - M_PI;
    
    // line1
    CGFloat radius = w/2 - ZM_SPACE(12);// 半径
    UIBezierPath *bgpath = [UIBezierPath bezierPath];
    [bgpath addArcWithCenter:point radius:radius startAngle:endA endAngle:startA clockwise:YES];
    [ZMHEXCOLOR(0xf1f1f1) set];
    [bgpath setLineWidth:9.f];// 线宽
    [bgpath setLineCapStyle:kCGLineCapRound];// line的圆角
    [bgpath stroke];
    
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:point radius:radius startAngle:endA endAngle:midA clockwise:YES];
    if (!self.isAnimation)
    {
        [ZMHEXCOLOR(0x23a7f1) set];
        [path1 setLineWidth:9.f];// 线宽
        [path1 setLineCapStyle:kCGLineCapRound];// line的圆角
        [path1 stroke];
    }
    else
    {
        CAShapeLayer *layer_path1 = [CAShapeLayer layer];
        layer_path1.path = path1.CGPath;
        layer_path1.lineWidth = 9.f;
        layer_path1.lineCap = kCALineCapRound;
        layer_path1.fillColor = nil;
        layer_path1.strokeColor = ZMHEXCOLOR(0x23a7f1).CGColor;
        layer_path1.frame = self.bounds;
        [self.layer addSublayer:layer_path1];
        _layer_path1 = layer_path1;
        
        [self addAnimationWithLayer:layer_path1];
    }
    
    
    
    // line2
    CGFloat radius2 = w/2 - ZM_SPACE(3.5);// 半径
    UIBezierPath *bgpath2 = [UIBezierPath bezierPath];
    [bgpath2 addArcWithCenter:point radius:radius2 startAngle:endA endAngle:startA clockwise:YES];
    [ZMHEXCOLOR(0xf1f1f1) set];
    [bgpath2 setLineWidth:2.f];// 线宽
    [bgpath2 stroke];
    
    
    
    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 addArcWithCenter:point radius:radius2 startAngle:endA endAngle:midA clockwise:YES];
    if (!self.isAnimation)
    {
        [ZMHEXCOLOR(0x23a7f1) set];
        [path2 setLineWidth:2.f];// 线宽
        [path2 stroke];
    }
    else
    {
        CAShapeLayer *layer_path2 = [CAShapeLayer layer];
        layer_path2.path = path2.CGPath;
        layer_path2.lineWidth = 2.f;
        layer_path2.lineCap = kCALineCapRound;
        layer_path2.fillColor = nil;
        layer_path2.strokeColor = ZMHEXCOLOR(0x23a7f1).CGColor;
        layer_path2.frame = self.bounds;
        [self.layer addSublayer:layer_path2];
        _layer_path2 = layer_path2;
        
        [self addAnimationWithLayer:layer_path2];
    }
}

- (void)show {
    [self setupUI];
}
#pragma mark - UI
- (void)setupUI {
//    self.currentMonth = [NSNumber numberWithInt:12];
    
    NSInteger index = self.currentMonth.integerValue-1;
    if (index>11) {
        index = 12;
        self.currentMonth = [NSNumber numberWithInteger:18];
    }
    
    self.currentRadian = M_PI/12 * index + (-M_PI_2);// 默认位置为12
    self.month_count = [NSNumber numberWithInteger:13];
    
    self.opaque = NO;// opaque：不透明的
    self.contentMode = UIViewContentModeRedraw;
    // 添加手势
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    
    // 指针
    CALayer *needleLayer = [CALayer layer];
    // 设置锚点
    needleLayer.anchorPoint = CGPointMake(0.5, 1155/1300.f);
    // 锚点位置
    needleLayer.position = CGPointMake(w*0.5, h-ZM_SPACE(15));
    // bounds
    needleLayer.bounds = CGRectMake(0, 0, ZM_SPACE(29), ZM_SPACE(130));
    // 添加图片
    needleLayer.contents = (id)[UIImage imageNamed:@"zhizhen"].CGImage;
    [self.layer addSublayer:needleLayer];
    needleLayer.transform = CATransform3DMakeRotation(self.currentRadian, 0, 0, 1);
    _needleLayer = needleLayer;
    
    if (self.isAnimation) {
        CABasicAnimation *bas2= [CABasicAnimation animationWithKeyPath:@"transform"];
        bas2.duration=1.f;
        bas2.delegate=self;
        bas2.speed = 1.f;
        bas2.fromValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_2, 0, 0, 1)];
        bas2.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(self.currentRadian, 0, 0, 1)];
        [_needleLayer addAnimation:bas2 forKey:@"bas2"];
    }
    
    //    [UIView animateWithDuration:1.f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction animations:^{
    //        _needleLayer.transform = CATransform3DMakeRotation(self.currentRadian, 0, 0, 1);
    //    } completion:^(BOOL finished) {
    //
    //    }];
    
    
    // 循环创建13个按钮
    CGFloat angle = M_PI/12;
    NSArray *imgNameArr = @[@"month-1", @"month-2",@"month-3", @"month-4", @"month-5", @"month-6", @"month-7", @"month-8", @"month-9", @"month-10", @"month-11", @"month-12", @"month-18"];
    NSArray *imgNameArr_press = @[@"month-01_press", @"month-02_press", @"month-03_press", @"month-04_press", @"month-05_press", @"month-06_press", @"month-07_press", @"month-08_press", @"month-09_press", @"month-10_press", @"month-11_press", @"month-12_press", @"month-18_press"];
    
    
    for (int i = 0; i < 13; i++) {
        autoButton *btn = [[autoButton alloc] init];
        btn.bounds = CGRectMake(0, 0, ZM_SPACE(30), w/2.f-ZM_SPACE(9));
        btn.center = CGPointMake(w/2.f, h-ZM_SPACE(15));
        btn.layer.anchorPoint = CGPointMake(0.5, 1);
        // 偏移角度
        btn.transform = CGAffineTransformMakeRotation(angle * i - M_PI_2);
        // 设置btn的图片
        [btn setImage:[UIImage imageNamed:imgNameArr[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imgNameArr_press[i]] forState:UIControlStateSelected];
        [self addSubview:btn];
        [self.btnArr addObject:btn];
        
        btn.tag = 656 + i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    // 变换btn的状态
    int i = 0;
    for (UIButton *btn in self.btnArr) {
        btn.selected = YES;
        if (i==index) {
            break;
        }
        i++;
    }
    
    /*
    // 在中间添加一个label
    CGFloat labelX = w/2.f - ZM_SPACE(25);
    CGFloat labelY = h - ZM_SPACE(105);
    CGFloat labelW = ZM_SPACE(50);
    CGFloat labelH = ZM_SPACE(20);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelW, labelH)];
    
    label.text = [NSString stringWithFormat:@"%@", self.currentMonth];
    label.font = ZM_FONT(14);
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = ZMHEXCOLOR(0xff4343);
    [self addSubview:label];
    self.label = label;
     */
    
    
    /* 
     
    // 两端添加图片
    CGFloat RoundW = 9.f;
    CGFloat RoundH = 4.5f;
    CGFloat RoundX = ZM_SPACE(12)-4.5f;
    CGFloat RoundY = ZM_circle_Y;
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(RoundX, RoundY, RoundW, RoundH)];
    [self addSubview:imgV];
    imgV.backgroundColor = ZMHEXCOLOR(0x23a7f1);
    imgV.layer.cornerRadius = 2.25;
    imgV.image = [UIImage imageNamed:@"banyuan_lan"];
     */
}

#pragma mark - 动画
- (void)btnAction:(UIButton *)btn {
    NSInteger i = btn.tag- 656;
    self.currentRadian = M_PI/12 * i + (-M_PI_2);
    [_layer_path1 removeFromSuperlayer];
    [_layer_path1 removeAllAnimations];
    [_layer_path2 removeFromSuperlayer];
    [_layer_path2 removeAllAnimations];
    _isAnimation = NO;
    [self setNeedsDisplay];
    [self deal];
}
- (void)handlePan:(UIGestureRecognizer *)gesture {
    CGPoint currentPosition = [gesture locationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
//        NSLog(@"[%f, %f]", currentPosition.x, currentPosition.y);
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        self.currentRadian = [self calculateRadian:currentPosition];
        [_layer_path1 removeFromSuperlayer];
        [_layer_path1 removeAllAnimations];
        [_layer_path2 removeFromSuperlayer];
        [_layer_path2 removeAllAnimations];
        _isAnimation = NO;
        [self setNeedsDisplay];
        
        [self deal];
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        if (self.currentMonth.integerValue > 12) {
            self.currentMonth = [NSNumber numberWithInteger:13];
        }
        self.currentRadian = ((self.currentMonth.integerValue-1) * (M_PI/12)) + (-M_PI_2);
        [self setNeedsDisplay];
        [self deal];
    }
    
}
- (void)deal {
    // 指针动画
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _needleLayer.transform = CATransform3DMakeRotation(self.currentRadian, 0, 0, 1);
    [CATransaction commit];
    
    // 当前月份
    [self settingCurrentMonth];
    
    // 显示当前月份
//    self.label.text = [NSString stringWithFormat:@"%@", self.currentMonth];
    
    // 变换btn的状态
    int i = 0;
    for (UIButton *btn in self.btnArr)
    {
        if (i<=self.currentMonth.intValue-1) {
            btn.selected = YES;
        }
        if (i>self.currentMonth.intValue-1) {
            btn.selected = NO;
        }
        i++;
        if (self.currentMonth.intValue == 18) {
            btn.selected = YES;
        }
    }
    
    // block
    if (self.block) {
        self.block(self.currentMonth);
    }
}
- (void)settingCurrentMonth {
    int monthcount = self.month_count.intValue;
    CGFloat monthSection = M_PI/(monthcount-1);
    CGFloat currentSection = -M_PI_2 + monthSection/2.f;
    
    for (int i = 2; i <= monthcount-1; i++) {
        if (self.currentRadian >= currentSection && self.currentRadian < currentSection + monthSection) {
            self.currentMonth = [NSNumber numberWithInt:i];
            break;
        }
        currentSection += monthSection;
    }
    
    if (self.currentRadian >= M_PI_2 - monthSection/2.f) {
        self.currentMonth = [NSNumber numberWithInt:monthcount + 5];
    }
    if (self.currentRadian < -M_PI_2 + monthSection/2.f) {
        self.currentMonth = [NSNumber numberWithInt:monthcount - 12];
    }
    
//    NSLog(@"%@", self.currentMonth);
    
}
- (CGFloat)calculateRadian:(CGPoint)pos {
    
    if (pos.x == ZM_circle_X) {
        return 0;
    }
    if (pos.y > ZM_circle_Y  && pos.x <= ZM_circle_X) {
        return -M_PI_2;
    }
    if (pos.y > ZM_circle_Y  && pos.x > ZM_circle_X) {
        return M_PI_2;
    }
    
    CGFloat x_space = pos.x - ZM_circle_X;
    CGFloat y_space = ZM_circle_Y - pos.y;
    CGFloat r_space = sqrt(x_space*x_space + y_space*y_space);
    
    CGFloat result = M_PI_2 -  acos(x_space/r_space);
    
//    NSLog(@"x_space: %f, y_space: %f,  r_space: %f", x_space,y_space,r_space);
//    NSLog(@"result:------- %f", result);
    
    return result;
}
- (void)addAnimationWithLayer:(CAShapeLayer *)layer {
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    bas.duration=1.f;
    bas.delegate=self;
    bas.speed = 1.f;
    bas.fromValue=[NSNumber numberWithInteger:0];
    bas.toValue=[NSNumber numberWithInteger:1];
    [layer addAnimation:bas forKey:@"bas"];
}


#pragma mark - 懒加载
- (NSMutableArray *)btnArr {
    if (!_btnArr) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}

@end
