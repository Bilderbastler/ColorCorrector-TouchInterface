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
