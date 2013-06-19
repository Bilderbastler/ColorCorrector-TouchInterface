//
//  ViewFactory.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 15.06.13.
//
//  Creates the Core Animation Layers for
//  the Luminance and Color Surface Widgets

#import "LayerFactory.h"

@implementation LayerFactory

-(CALayer*)createFourDirectionArrows{
    return [CALayer layer];
}

-(CALayer*)createTwoDirectionArrow{
    CALayer* twoArrows = [CALayer layer];
    twoArrows.bounds = CGRectMake(0, 0, 40, 160);
    twoArrows.position = CGPointMake(400, 400);
    [self addTopArrorToALayer:twoArrows];
    [self addBottomArrowToALayer:twoArrows];
    return twoArrows;
}

- (void)addTopArrorToALayer:(CALayer *)holderLayer {
    CALayer* topArrow = [self createArrow];
    float x = holderLayer.bounds.size.width / 2;
    float topY = holderLayer.bounds.size.height - topArrow.bounds.size.height;
    topArrow.position = CGPointMake(x, topY);
    [holderLayer addSublayer:topArrow];
}

- (void)addBottomArrowToALayer:(CALayer *)holderLayer {
    CALayer* bottomArrow = [self createArrow];
    float x = holderLayer.bounds.size.width / 2;
    float bottomY = bottomArrow.bounds.size.height;
    [bottomArrow setAffineTransform:CGAffineTransformMakeRotation(M_PI)];
    bottomArrow.position = CGPointMake(x, bottomY);
    [holderLayer addSublayer:bottomArrow];
}

-(CALayer*)createArrow{
    CAShapeLayer *arrowLayer = [self createArrowLayer];
    CGPathRef cgPath = [self createArrowPath];
    arrowLayer.path = cgPath;
    CGPathRelease(cgPath);
    return arrowLayer;
}

- (CAShapeLayer *)createArrowLayer {
    CAShapeLayer *arrowLayer = [CAShapeLayer layer];
    arrowLayer.bounds = CGRectMake(0, 0, 40, 40);
    arrowLayer.position = CGPointMake(20, 20);
    arrowLayer.anchorPoint = CGPointMake(0.5, 0);
    arrowLayer.fillColor = [[UIColor whiteColor] CGColor];
    return arrowLayer;
}

-(CGPathRef)createArrowPath{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 15, 40);
    CGPathAddLineToPoint(path, NULL, 25, 40);
    CGPathAddLineToPoint(path, NULL, 40, 0);
    CGPathAddLineToPoint(path, NULL, 30, 0);
    CGPathAddLineToPoint(path, NULL, 20, 27);
    CGPathAddLineToPoint(path, NULL, 10, 0);
    CGPathCloseSubpath(path);
    return path;
}

@end
