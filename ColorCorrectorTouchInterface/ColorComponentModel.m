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
        _red = 1;
        _green = 1;
        _blue = 1;
        
        _hue = 0;
        _saturation = 0;
        _luminance = 1;
        
        _sensitivityModifier = 10;
    }
    return self;
}

-(void)changeHueAndLuminance:(CGPoint)velocityVector{
    [self saturationFromVector:velocityVector];

    //calculate hue
    float hueChange = atan2f(velocityVector.x, velocityVector.y);
    hueChange = (hueChange + M_PI) / (2 * M_PI) ; // reduce range of value to 0-1,
    hueChange = fmod(hueChange + 0.5, 1.0);
    self.hue = self.hue + hueChange;
    //calculate rgb from new values
    
    // recalulate hsv from new rgb
}

- (void)saturationFromVector:(CGPoint)vector {
    //calculate saturation
    float sumOfSqr = vector.x * vector.x + vector.y * vector.y;
    float saturationChange = sqrtf(sumOfSqr);
    saturationChange = saturationChange / self.sensitivityModifier;
    self.saturation = self.saturation + saturationChange;
}

-(void)setSaturation:(float)saturation{
    _saturation = MAX(saturation, 0);
    _saturation = MIN(_saturation, 1);
}

-(void)setHue:(float)hue{
    _hue = MAX(hue, 0);
    _hue = MIN(_hue, 1);
}

-(void)setLuminance:(float)luminance{
    _luminance = MAX(luminance, 0);
    _luminance = MIN(_luminance, 1);
}

-(void)setRed:(float)red{
    _red = MIN(red, 10);
    _red = MAX(_red, 0);
}

-(void)setGreen:(float)green{
    _green = MIN(green, 10);
    _green = MAX(_green, 0);
}

-(void)setBlue:(float)blue{
    _blue = MIN(blue, 10);
    _blue = MAX(_blue, 0);
}

@end
