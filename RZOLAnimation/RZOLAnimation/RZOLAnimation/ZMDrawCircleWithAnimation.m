//
//  ZMDrawCircleWithAnimation.m
//  testDemo
//
//  Created by 赵林瑞 on 16/5/18.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#import "ZMDrawCircleWithAnimation.h"

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


@interface ZMDrawCircleWithAnimation ()
{
    CAShapeLayer *_layer;
    BOOL _isDraw;
}

/**
 *  当前角度
 */
@property(nonatomic) CGFloat currentRadian;

@end

@implementation ZMDrawCircleWithAnimation


- (id) init
{
    self = [super init];
    //    [self setupUI];
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self){
        self.opaque = NO;// opaque：不透明的
        self.contentMode = UIViewContentModeRedraw;
        // 添加手势
        [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
        
        _isDraw = NO;
        
        [self draw5];
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [self draw3];
//    [self draw1];
    
}

- (void)draw5 {
    CGPoint point = CGPointMake(ZM_circle_X, ZM_circle_Y);
//    CGFloat startA = 0;
//    CGFloat midA = - M_PI_2 + self.currentRadian;
//    CGFloat endA = - M_PI;
    
    CGFloat radius = w/2 - ZM_SPACE(12);// 半径
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path addArcWithCenter:point radius:radius startAngle:- M_PI_2-M_PI/180 endAngle:- M_PI_2 clockwise:YES];
    CAShapeLayer *layer_s = [CAShapeLayer layer];
    layer_s.path = path.CGPath;
    layer_s.lineWidth = 1.f;
    layer_s.lineCap = kCALineCapRound;
    layer_s.fillColor = nil;
    layer_s.strokeColor = [UIColor orangeColor].CGColor;
    layer_s.frame = self.bounds;
    [self.layer addSublayer:layer_s];
    _layer = layer_s;
    
    NSLog(@"%f,    %f", layer_s.frame.origin.x, layer_s.frame.origin.y);
}

- (void)draw4 {
    CGPoint point = CGPointMake(ZM_circle_X, ZM_circle_Y);
    CGFloat startA = 0;
    CGFloat midA = - M_PI_2 + self.currentRadian;
//    CGFloat endA = - M_PI;
    
    CGFloat radius = w/2 - ZM_SPACE(12);// 半径
    UIBezierPath *bgpath = [UIBezierPath bezierPath];
    [bgpath addArcWithCenter:point radius:radius startAngle:midA endAngle:startA clockwise:YES];
    
    CAShapeLayer *layer_s = [CAShapeLayer layer];
    layer_s.path = bgpath.CGPath;
    layer_s.lineWidth = 12.f;
    layer_s.lineCap = kCALineCapRound;
    layer_s.fillColor = nil;
    layer_s.strokeColor = ZMHEXCOLOR(0xf1f1f1).CGColor;
    layer_s.frame = self.bounds;
    [self.layer addSublayer:layer_s];
}

- (void)draw3 {
    
    CGPoint point = CGPointMake(ZM_circle_X, ZM_circle_Y);
//    CGFloat startA = 0;
    CGFloat midA = - M_PI_2 + self.currentRadian;
    CGFloat endA = - M_PI;
    
    CGFloat radius = w/2 - ZM_SPACE(12);// 半径
    UIBezierPath *bgpath = [UIBezierPath bezierPath];
    [bgpath addArcWithCenter:point radius:radius startAngle:endA endAngle:midA clockwise:YES];
    [ZMHEXCOLOR(0xf1f1f1) set];
    [bgpath setLineWidth:9.f];// 线宽
    [bgpath setLineCapStyle:kCGLineCapRound];// line的圆角
    [bgpath stroke];
}

- (void)draw2 {
    CGPoint point = CGPointMake(ZM_circle_X, ZM_circle_Y);
    CGFloat startA = 0;
    CGFloat midA = - M_PI_2 + self.currentRadian;
    CGFloat endA = - M_PI;
    
    // line1
    CGFloat radius = w/2 - ZM_SPACE(12);// 半径
    UIBezierPath *bgpath = [UIBezierPath bezierPath];
    [bgpath addArcWithCenter:point radius:radius startAngle:midA endAngle:startA clockwise:YES];
    [ZMHEXCOLOR(0xf1f1f1) set];
    [bgpath setLineWidth:9.f];// 线宽
    [bgpath setLineCapStyle:kCGLineCapRound];// line的圆角
    [bgpath stroke];
    
    
    
    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 addArcWithCenter:point radius:radius startAngle:endA endAngle:midA clockwise:YES];
    [ZMHEXCOLOR(0x23a7f1) set];
    [path1 setLineWidth:9.f];// 线宽
    [path1 setLineCapStyle:kCGLineCapRound];// line的圆角
    [path1 stroke];
}

- (void)draw1 {
    CGPoint point = CGPointMake(ZM_circle_X, ZM_circle_Y);
    CGFloat startA = 0;
    CGFloat midA = - M_PI_2 + self.currentRadian;
    CGFloat endA = - M_PI;
    
    // line1
    CGFloat radius = w/2 - ZM_SPACE(12);// 半径
    UIBezierPath *bgpath = [UIBezierPath bezierPath];
    [bgpath addArcWithCenter:point radius:radius startAngle:endA endAngle:startA clockwise:YES];
    [ZMHEXCOLOR(0xf1f1f1) set];
    [bgpath setLineWidth:12.f];// 线宽
    [bgpath setLineCapStyle:kCGLineCapRound];// line的圆角
    [bgpath stroke];
    
    /*
    CAShapeLayer *layer_s = [CAShapeLayer layer];
    layer_s.path = bgpath.CGPath;
    layer_s.lineWidth = 12.f;
    layer_s.lineCap = kCALineCapRound;
    layer_s.fillColor = nil;
    layer_s.strokeColor = ZMHEXCOLOR(0xf1f1f1).CGColor;
    layer_s.frame = self.bounds;
    [self.layer addSublayer:layer_s];
    */
     
    
    if (_isDraw) {
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 addArcWithCenter:point radius:radius startAngle:endA endAngle:midA clockwise:YES];
        [ZMHEXCOLOR(0x23a7f1) set];
        [path1 setLineWidth:12.f];// 线宽
        [path1 setLineCapStyle:kCGLineCapRound];// line的圆角
        [path1 stroke];
    }
    else
    {
        CGFloat radius2 = w/2 - ZM_SPACE(12);// 半径
        UIBezierPath *bgpath2 = [UIBezierPath bezierPath];
        [bgpath2 addArcWithCenter:point radius:radius2 startAngle:endA endAngle:midA clockwise:YES];
        
        CAShapeLayer *layer_s2 = [CAShapeLayer layer];
        layer_s2.path = bgpath2.CGPath;
        layer_s2.lineWidth = 12.f;
        layer_s2.lineCap = kCALineCapRound;
        layer_s2.fillColor = nil;
        layer_s2.strokeColor = ZMHEXCOLOR(0x23a7f1).CGColor;
        layer_s2.frame = self.bounds;
        [self.layer addSublayer:layer_s2];
        _layer = layer_s2;
        
        CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        bas.duration=1.f;
        bas.delegate=self;
        bas.speed = 1.f;
        bas.fromValue=[NSNumber numberWithInteger:0];
        bas.toValue=[NSNumber numberWithInteger:1];
        [_layer addAnimation:bas forKey:@"key"];
//        [layer_s addAnimation:bas forKey:@"key"];
        
        
        
    }
    
    
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//    });
}

- (void)handlePan:(UIGestureRecognizer *)gesture {
    
    CGPoint currentPosition = [gesture locationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        NSLog(@"[%f, %f]", currentPosition.x, currentPosition.y);
        NSLog(@"1111111111");
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        self.currentRadian = [self calculateRadian:currentPosition];
        
        
        
//        [_layer removeFromSuperlayer];
//        [_layer removeAllAnimations];
//        _isDraw = YES;
        [self setNeedsDisplay];
        
//        [self deal];
        NSLog(@"[%f, %f]", currentPosition.x, currentPosition.y);
        NSLog(@"222222222222");
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"[%f, %f]", currentPosition.x, currentPosition.y);
        NSLog(@"333333333333");
    }
    
    
    
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
    
    NSLog(@"x_space: %f, y_space: %f,  r_space: %f", x_space,y_space,r_space);
    NSLog(@"result:------- %f", result);
    
    return result;
}

@end
