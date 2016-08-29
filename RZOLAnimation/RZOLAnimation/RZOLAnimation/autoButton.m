//
//  autoButton.m
//  LuckyTurntable
//
//  Created by CCP on 15/12/25.
//  Copyright © 2015年 CCP. All rights reserved.
//

#import "autoButton.h"

@implementation autoButton

//取消高亮状态
- (void)setHighlighted:(BOOL)highlighted {
    
}
//自定义按钮中imageView 的 frame 大小
- (CGRect) imageRectForContentRect:(CGRect)contentRect {
    
    CGFloat w = 26;
    
    CGFloat h = 26;
    
    CGFloat x = (contentRect.size.width - w) / 2;
    
    CGFloat y = 8;
    
    return CGRectMake(x, y, w, h);

}

@end
