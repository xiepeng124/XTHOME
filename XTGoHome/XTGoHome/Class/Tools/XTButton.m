//
//  XTButton.m
//  XTGoHome
//
//  Created by 华驰科技 on 2017/7/13.
//  Copyright © 2017年 华驰科技. All rights reserved.
//

#import "XTButton.h"

@implementation XTButton
{
    CGPoint _startPoint;
    CGFloat _maxWidth;
    NSMutableSet *_recyclePool;
    NSMutableArray *_array;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame maxLeft:(CGFloat)maxLeft maxRight:(CGFloat)maxRight maxHeight:(CGFloat)maxHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        _maxHeight = maxHeight;
        _maxLeft   = maxLeft;
        _maxRight  = maxRight;
        
        [self initData];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    _array = @[].mutableCopy;
    _recyclePool = [NSMutableSet set];
}

- (void)generateBubbleInRandom
{
    CALayer *layer;
    
    if (_recyclePool.count > 0) {
        layer = [_recyclePool anyObject];
        
        [_recyclePool removeObject:layer];
        
    }else {
        UIImage *image = self.images[arc4random() % self.images.count];
        
        layer = [self createLayerWithImage:image];
    }
    
    [self.layer addSublayer:layer];
    [self generateBubbleWithCAlayer:layer];
}

- (void)generateBubbleWithImage:(UIImage *)image
{
    CALayer *layer = [self createLayerWithImage:image];
    
    [self.layer addSublayer:layer];
    [self generateBubbleWithCAlayer:layer];
}

- (void)generateBubbleWithCAlayer:(CALayer *)layer
{
    _maxWidth = _maxLeft + _maxRight + self.bounds.size.width;
    
    _startPoint = CGPointMake(self.frame.size.width / 2, 0);
    
    CGPoint endPoint = CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight);
    CGPoint controlPoint1 = CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight * 0.2);
    CGPoint controlPoint2 = CGPointMake(_maxWidth * [self randomFloat] - _maxLeft, -_maxHeight * 0.6);
    
    CGMutablePathRef curvedPath = CGPathCreateMutable();
    CGPathMoveToPoint(curvedPath, NULL, _startPoint.x, _startPoint.y);
    CGPathAddCurveToPoint(curvedPath, NULL, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
    
    CAKeyframeAnimation *keyFrame = [CAKeyframeAnimation animation];
    keyFrame.keyPath = @"position";
    keyFrame.path = CFAutorelease(curvedPath);
    keyFrame.duration = self.duration;
    keyFrame.calculationMode = kCAAnimationPaced;
    
    [layer addAnimation:keyFrame forKey:@"keyframe"];
    
    CABasicAnimation *scale = [CABasicAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.toValue = @3;
    scale.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)];
    scale.duration = 4;
    
    CABasicAnimation *alpha = [CABasicAnimation animation];
    alpha.keyPath = @"opacity";
    alpha.fromValue = @1;
    alpha.toValue = @0.1;
    alpha.duration = self.duration * 0.4;
    alpha.beginTime = self.duration - alpha.duration;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[keyFrame, scale, alpha];
    group.duration = self.duration;
    group.delegate = self;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [layer addAnimation:group forKey:@"group"];
    //group.repeatCount= 20;
    [_array addObject:layer];
}

- (CGFloat)randomFloat
{
    return (arc4random() % 100)/100.0f;
}

- (CALayer *)createLayerWithImage:(UIImage *)image
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CALayer *layer = [CALayer layer];
    layer.frame    = CGRectMake(0, 0, image.size.width / scale, image.size.height / scale);
    layer.contents = (__bridge id)image.CGImage;;
    return layer;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        NSLog(@"flag = yes");
        for (CALayer *layer in _array) {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];

    }
        for (CALayer *layer in _recyclePool) {
            [layer removeAllAnimations];
            [layer removeFromSuperlayer];
        }
        //CALayer *layer = [_array firstObject];
            [_array removeAllObjects];
        [_recyclePool removeAllObjects];
        //[_recyclePool addObject:layer];
    }
}
@end
