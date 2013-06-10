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

- (void)hueFromVector:(CGPoint)velocityVector {
    //calculate hue
    float hueChange = atan2f(velocityVector.x, velocityVector.y);
    hueChange = (hueChange + M_PI) / (2 * M_PI) ; // reduce range of value to 0-1,
    hueChange = fmod(hueChange + 0.5, 1.0);
    self.hue = self.hue + hueChange;
}

-(void)changeHueAndLuminance:(CGPoint)velocityVector{
    [self saturationFromVector:velocityVector];

    [self hueFromVector:velocityVector];
    //calculate rgb from new values
        float   h,s,v;
    h = self.hue;
    s = self.saturation;
    v = self.luminance;
    
    double  hh, p, q, t, ff;
    long    i;
    
    if(s <= 0.0) {       
        if(isnan(h)) {   // in.h == NAN
            _red = v;
            _green = v;
            _blue = v;
        }else{
            _red = 0.0;
            _green = 0.0;
            _blue = 0.0;
        }
    }else{
        hh = h;
        if(hh >= 1.0) hh = 0.0;
        hh = hh / (1.0/6.0);
        i = (long)hh;
        ff = hh - i;
        p = v * (1.0 - s);
        q = v * (1.0 - (s * ff));
        t = v * (1.0 - (s * (1.0 - ff)));
        
        switch(i) {
            case 0:
                _red = v;
                _green = t;
                _blue = p;
                break;
            case 1:
                _red = q;
                _green = v;
                _blue = p;
                break;
            case 2:
                _red = p;
                _green = v;
                _blue = t;
                break;
                
            case 3:
                _red = p;
                _green = q;
                _blue = v;
                break;
            case 4:
                _red = t;
                _green = p;
                _blue= v;
                break;
            case 5:
            default:
                _red = v;
                _green = p;
                _blue = q;
                break;
        }
    }

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
