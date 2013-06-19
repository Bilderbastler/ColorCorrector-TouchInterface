//
//  ColorSurfaceView.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 12.06.13.
//
//  This view Widget is used for changing the hue and color values
//  of the lift, gamma and gain component. It holds references to
//  it's Core Animation interface compontens.

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
