//
//  RGBColor.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 10.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "RGBColor.h"

@implementation RGBColor


- (id)init
{
    self = [super init];
    if (self) {
        _red = 1.0;
        _green = 1.0;
        _blue = 1.0;
    }
    return self;
}


-(void)setRGBFromLSV:(LSVColor *)newColor{
    float   h,s,v;
    h = newColor.hue;
    s = newColor.saturation;
    v = newColor.luminance;
    
    double  hh, p, q, t, ff;
    long    i;
    
    if(s <= 0.0) {
        if(isnan(h)) {   
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
