//
//  RGBColor.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 10.06.13.
//
//  The RGBColor Class represents a color in Red, Green and Blue
//  Channels. The normal range for this channels is betweet 0 and 1
//  and a maximum value of 10.
//  It handles conversion from LSVColor and to UIColor

#import "RGBColor.h"

static float maximumValue = 10;

@implementation RGBColor

+(RGBColor*)colorWithRed:(float)red green:(float)green blue:(float)blue{
    RGBColor* color = [[RGBColor alloc] init];
    color.red = red;
    color.green = green;
    color.blue = blue;
    return color;
}

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

-(void)blendWithColor:(RGBColor *)otherColor mix:(float)strength{
    _red = MIN(_red + (otherColor.red * strength), maximumValue);
    _green = MIN(_green + (otherColor.green * strength), maximumValue);
    _blue = MIN(_blue + (otherColor.blue * strength), maximumValue);
    
}

-(UIColor *)uiColorFromRGB{
    float max = MAX(self.red, MAX(self.green, self.blue));
    UIColor* newColor =[UIColor colorWithRed:self.red / max
                                       green:self.green / max
                                        blue:self.blue / max
                                       alpha:1.0];
    return newColor;
}

-(void)setRed:(float)red{
    _red = MIN(red, maximumValue);
    _red = MAX(_red, 0);
}

-(void)setGreen:(float)green{
    _green = MIN(green, maximumValue);
    _green = MAX(_green, 0);
}

-(void)setBlue:(float)blue{
    _blue = MIN(blue, maximumValue);
    _blue = MAX(_blue, 0);
}

-(id)copyWithZone:(NSZone *)zone{
    RGBColor *copy = [[RGBColor allocWithZone:zone]init];
    copy.red = _red;
    copy.green = _green;
    copy.blue = _blue;
    return copy;
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
