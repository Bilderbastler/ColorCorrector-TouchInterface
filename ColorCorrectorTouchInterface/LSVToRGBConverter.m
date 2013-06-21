//
//  LSVToRGBConverter.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 21.06.13.
//
//  Creates an RGB Based Color Object from a
//  LSV based Color Object

#import "LSVToRGBConverter.h"

@implementation LSVToRGBConverter

+(RGBColor *)convertColor:(LSVColor *)aColor{
    RGBColor* newColor = [[RGBColor alloc]init];
    float   h,s,v;
    h = aColor.hue;
    s = aColor.saturation;
    v = aColor.luminance;
    
    double  hh, p, q, t, ff;
    long    i;
    
    if(s < 0.0) {
        if(isnan(h)) {
            newColor.red = v;
            newColor.green = v;
            newColor.blue = v;
        }else{
            newColor.red = 0.0;
            newColor.green = 0.0;
            newColor.blue = 0.0;
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
                newColor.red = v;
                newColor.green = t;
                newColor.blue = p;
                break;
            case 1: //Magenta
                newColor.red = q;
                newColor.green = p;
                newColor.blue = v;
                break;
            case 2: //Blue
                newColor.red = p;
                newColor.green = t;
                newColor.blue = v;
                break;
                
            case 3: //Cyan
                newColor.red = p;
                newColor.green = q;
                newColor.blue = v;
                break;
            case 4: //Green
                newColor.red = t;
                newColor.green = v;
                newColor.blue= p;
                break;
            case 5: //Yellow
            default:
                newColor.red = v;
                newColor.green = q;
                newColor.blue = p;
                break;
        }
    }
    return newColor;
}

@end
