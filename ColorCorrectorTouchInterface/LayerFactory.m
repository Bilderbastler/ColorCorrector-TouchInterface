//
//  ViewFactory.m
//  ColorCorrectorTouchInterface
//
//  Creates and builds the Luminance and Color Surface Views with it's ui
//  components
//
//  Created by Franzi on 15.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "LayerFactory.h"

@implementation LayerFactory

-(CALayer*)createFourDirectionArrows{
    return [CALayer layer];
}

-(CALayer*)createTwoDirectionArrow{
    CALayer* twoArrows = [CALayer layer];
    twoArrows.bounds = CGRectMake(0, 0, 200, 200);
    twoArrows.position = CGPointMake(50, 50);
    CALayer* topArrow = [self createArrow];
    
    CALayer* bottomArrow = [self createArrow];
    [twoArrows addSublayer:topArrow];
    [twoArrows addSublayer:bottomArrow];
    return twoArrows;
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
    arrowLayer.bounds = CGRectMake(0, 0, 60, 50);
    arrowLayer.position = CGPointMake(0, 0);
//    arrowLayer.anchorPoint = CGPointMake(0.5, 0);
    arrowLayer.strokeColor = [[UIColor whiteColor] CGColor];
    arrowLayer.lineJoin = kCALineJoinBevel;
    arrowLayer.lineWidth = 10;
    arrowLayer.backgroundColor = [[UIColor redColor]CGColor];
    return arrowLayer;
}

-(CGPathRef)createArrowPath{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 25, 50);
    CGPathAddLineToPoint(path, NULL, 50, 0);
    return path;
}

@end
