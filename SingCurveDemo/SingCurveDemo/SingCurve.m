//
//  SingCurve.m
//  SingCurveDemo
//
//  Created by apple on 16/9/1.
//  Copyright © 2016年 Lingser. All rights reserved.
//

#import "SingCurve.h"

@implementation SingCurve


- (void)drawRect:(CGRect)rect {
    [self drawSing];
}

- (void)drawSing{
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [[UIColor redColor] setStroke];
    path.lineWidth = 5;
    
    // 画横坐标
    [path moveToPoint:CGPointMake(0, viewHeight / 2)];
    [path addLineToPoint:CGPointMake(viewWidth, viewHeight / 2)];
    
    // 画纵坐标
    [path moveToPoint:CGPointMake(viewWidth / 2, 0)];
    [path addLineToPoint:CGPointMake(viewWidth / 2, viewHeight)];
    
    // 画正弦函数
    [path moveToPoint:CGPointMake(0, viewHeight / 2)];
    
    [path addQuadCurveToPoint:CGPointMake(viewWidth / 2, viewHeight / 2) controlPoint:CGPointMake(viewWidth / 4, viewHeight)];
    
    [path addQuadCurveToPoint:CGPointMake(viewWidth, viewHeight / 2) controlPoint:CGPointMake(viewWidth * 3 / 4, 0)];
    
    [path stroke];
}

@end
