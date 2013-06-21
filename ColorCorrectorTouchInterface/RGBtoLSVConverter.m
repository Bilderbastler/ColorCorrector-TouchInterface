//
//  RGBtoLSVConverter.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 21.06.13.
//
//  Creates an LSV Based Color Object from a
//  RGB based Color Object

#import "RGBtoLSVConverter.h"

static LSVColor* color = nil;

@implementation RGBtoLSVConverter

+(LSVColor *)convertColor:(RGBColor *)aColor{
    LSVColor* newColor = [[LSVColor alloc]init];
    double  min, max, delta, localHue, r, g, b;
    
    r = aColor.red;
    g = aColor.green;
    b = aColor.blue;
    
    min = MIN(r, g);
    min = MIN(min, b);
    
    max = MAX(r, g);
    max = MAX(max, b);
    
    newColor.luminance = max;
    delta = max - min;
    
    if( max > 0.0 ) {
        newColor.saturation = (delta / max);
    } else {
        
        newColor.saturation = 0.0;
        newColor.hue = 0.0;
        return newColor;
    }
    if( r >= max ){
        localHue = ( g - b ) / delta;        // between yellow & magenta
        localHue = isnan(localHue) ? 0.0 : localHue;
        
    }else{
        if( g >= max ){
            localHue = 2.0 + ( b - r ) / delta;  // between cyan & yellow
        }else{
            localHue = 4.0 + ( r - g ) / delta;  // between magenta & cyan
        }
    }
    localHue *= 60.0;                              // degrees
    localHue = round(localHue);
    if( localHue <= 0.0 ){
        localHue += 360.0;
    }
    localHue = 360.0 - localHue;
    newColor.hue = localHue / 360.0;
    return newColor;
}

@end
