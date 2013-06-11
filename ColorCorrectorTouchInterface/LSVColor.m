//
//  LSVColor.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 10.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "LSVColor.h"

@implementation LSVColor

- (id)init
{
    self = [super init];
    if (self) {
        // start white
        _hue = 0;
        _saturation = 0;
        _luminance = 1.0;
    }
    return self;
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
    _luminance = MIN(_luminance, 10);
}

-(void)setLSVFromLRGB:(RGBColor *)aColor{
    double  min, max, delta, localHue;
    float   r, g, b;
    
    r = aColor.red;
    g = aColor.green;
    b = aColor.blue;
    
    min = MIN(r, g);
    min = MIN(min, b);
    
    max = MAX(r, g);
    max = MAX(max, b);
    
    self.luminance = max;                                
    delta = max - min;
    
    if( max > 0.0 ) {
        self.saturation = (delta / max);
    } else {
        
        self.saturation = 0.0;
        self.hue = 0.0;                            
        return;
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
    
    if( localHue <= 0.0 ){
        localHue += 360.0;
    }
    localHue = 360.0 - localHue;
    self.hue = localHue / 360.0;
    
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

- (BOOL)isEqualToColor:(LSVColor*)aColor {
    if (self.luminance == aColor.luminance &&
        self.hue == aColor.hue &&
        self.saturation == aColor.saturation) {
        return YES;
    }else{
        return NO;
    }
}

@end
