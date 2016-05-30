//
//  XZCustomGestureRecognizer.m
//  XZCustomGestureRecognizer
//
//  Created by 徐章 on 16/5/30.
//  Copyright © 2016年 徐章. All rights reserved.
//



#import "XZCustomGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

#define REQUIRED_TICKLES        2/** 位移的最小距离*/
#define MOVE_AMT_PER_TICKLE     25/** 左右滑动的次数*/

typedef NS_ENUM(NSInteger, Direction){

    DirectionLeft,
    DirectionRight,
    DirectionUnknown
};

@interface XZCustomGestureRecognizer(){
    
    CGPoint _startPoint;
    Direction _lastDirection;
    
    NSInteger _tickleCount;
}

@end

@implementation XZCustomGestureRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    _startPoint = [touch locationInView:self.view];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    CGFloat moveAmt = point.x - _startPoint.x;
    
    Direction curDirection;
    if (moveAmt < 0) {
        curDirection = DirectionLeft;
    } else {
        curDirection = DirectionRight;
    }
    if (ABS(moveAmt) < MOVE_AMT_PER_TICKLE) return;
    
    // 确认方向改变了
    if (_lastDirection == DirectionUnknown ||
        (_lastDirection == DirectionLeft && curDirection == DirectionRight) ||
        (_lastDirection == DirectionRight && curDirection == DirectionLeft)) {
        
        // 挠痒次数
        _tickleCount++;
        _startPoint = point;
        _lastDirection = curDirection;
        
        // 一旦挠痒次数超过指定数，设置手势为结束状态
        // 这样回调函数会被调用。
        if (self.state == UIGestureRecognizerStatePossible && _tickleCount > REQUIRED_TICKLES) {
            [self setState:UIGestureRecognizerStateEnded];
        }
    }
    
}

- (void)reset {
    _tickleCount = 0;
    _startPoint = CGPointZero;
    _lastDirection = DirectionUnknown;
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reset];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self reset];
}

@end
