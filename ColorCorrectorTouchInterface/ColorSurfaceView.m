//
//  ColorSurfaceView.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 12.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "ColorSurfaceView.h"
#import "LayerFactory.h"
@implementation ColorSurfaceView

@synthesize fourWayArrows;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        LayerFactory* factory = [[LayerFactory alloc]init];
        self.fourWayArrows = [factory createFourDirectionArrows];
        [self.layer addSublayer:fourWayArrows];
        
        [self.layer addSublayer:[factory createTwoDirectionArrow]];
        
    }
    return self;
}



@end
