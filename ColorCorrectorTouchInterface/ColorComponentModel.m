//
//  ColorComponentModel.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 03.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "ColorComponentModel.h"

@implementation ColorComponentModel


- (id)init
{
    self = [super init];
    if (self) {
        self.rgbColor = [[RGBColor alloc]init];
        self.lsvColor = [[LSVColor alloc]init];
        
        _sensitivityModifier = 10;
    }
    return self;
}

-(void)changeHueAndLuminance:(CGPoint)velocityVector{
    [self saturationFromVector:velocityVector];

    [self hueFromVector:velocityVector];
    
    //calculate rgb from new values
    [self.rgbColor setRGBFromLSV:self.lsvColor];
    
    // recalulate hsv because the rgb values are the definite color value
    [self.lsvColor setLSVFromLRGB:self.rgbColor];
}

- (void)saturationFromVector:(CGPoint)vector {
    //calculate saturation
    float sumOfSqr = vector.x * vector.x + vector.y * vector.y;
    float saturationChange = sqrtf(sumOfSqr);
    saturationChange = saturationChange / self.sensitivityModifier;
    self.lsvColor.saturation = self.lsvColor.saturation + saturationChange;
}

- (void)hueFromVector:(CGPoint)velocityVector {
    //calculate hue
    float hueChange = atan2f(velocityVector.x, velocityVector.y);
    hueChange = (hueChange + M_PI) / (2 * M_PI) ; // reduce range of value to 0-1,
    hueChange = fmod(hueChange + 0.5, 1.0);
    self.lsvColor.hue = self.lsvColor.hue + hueChange;
}

@end
