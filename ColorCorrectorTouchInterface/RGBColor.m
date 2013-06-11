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
    
    if(s < 0.0) {
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
        h = h * 360;
        hh = h;
        if(hh >= 360) hh = 0.0;
        hh = hh / 60;
        i = (long)hh;
        ff = hh - i;
        p = v * (1.0 - s);
        q = v * (1.0 - (s * ff));
        t = v * (1.0 - (s * (1.0 - ff)));
        
        switch(i) {
            case 0: //Red
                _red = v;
                _green = t;
                _blue = p;
                break;
            case 1: //Magenta
                _red = q;
                _green = p;
                _blue = v;
                break;
            case 2: //Blue
                _red = p;
                _green = t;
                _blue = v;
                break;
                
            case 3: //Cyan
                _red = p;
                _green = q;
                _blue = v;
                break;
            case 4: //Green
                _red = t;
                _green = v;
                _blue= p;
                break;
            case 5: //Yellow
            default:
                _red = v;
                _green = q;
                _blue = p;
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

-(BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    if (!object || ! [self isKindOfClass:[object class]]) {
        return NO;
    }
    
    return [self isEqualToColor:object];
}

- (BOOL)isEqualToColor:(RGBColor*)aColor {
    if (self.red == aColor.red &&
        self.green == aColor.green &&
        self.blue == aColor.blue) {
        return YES;
    }else{
        return NO;
    }
}


@end
