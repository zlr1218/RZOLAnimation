//
//  ZMDrawRect.h
//  testDemo
//
//  Created by 赵林瑞 on 16/5/17.
//  Copyright © 2016年 RZOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

typedef void(^DrawRectBlock)(NSNumber *currentMonth);

@interface ZMDrawRect : UIView

/**
 *  当前月
 */
@property (nonatomic, strong) NSNumber *currentMonth;
@property (nonatomic, copy) DrawRectBlock block;
@property (nonatomic, assign) BOOL isAnimation;

- (void)show;

@end
