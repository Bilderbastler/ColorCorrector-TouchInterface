//
//  ColorComponentModel.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 03.06.13.
//
//  The ColorComponentModel represents a Component of a 3-Way Color
//  Correction Filter (Lift, Gamma or Gain). It translates the velocity
//  of a touch swipe into a change of hue, saturation or luminance of a color.
//

#import "ColorComponentModel.h"
#import "LSVToRGBConverter.h"

NSString *const ColorDidChangeNotification = @"ColorDidChange";
NSString *const ComponentChangeTypeColor = @"color";
NSString *const ComponentChangeTypeLuminance = @"luminance";


@implementation ColorComponentModel{
    ComponentType _component;
}

- (id)initWithComponentType:(ComponentType)component{
    self = [super init];
    if (self) {
        _component = component;
        self.notificationCenter = [NSNotificationCenter defaultCenter];
        self.rgbColor = [[RGBColor alloc]init];
        _sensitivityModifier = 0.01;
    }
    return self;
}

-(void)changeHueAndSaturation:(CGPoint)velocityVector{
    RGBColor *colorOffset = [self makeColorFromVektor:velocityVector];
    [self.rgbColor blendWithColor:colorOffset mix:self.sensitivityModifier];
    [self sendNotificationForChangeType:ComponentChangeTypeColor];
}

- (RGBColor *)makeColorFromVektor:(CGPoint)velocityVector {
    LSVColor* colorFromVector = [[LSVColor alloc]init];
    colorFromVector.saturation = [self saturationFromVector:velocityVector];
    colorFromVector.hue = [self hueFromVector:velocityVector];
    RGBColor* colorOffset = [LSVToRGBConverter convertColor:colorFromVector];
    return colorOffset;
}

- (float)saturationFromVector:(CGPoint)vector {
    float sumOfSquares = vector.x * vector.x + vector.y * vector.y;
    float saturation = sqrtf(sumOfSquares);
    saturation = saturation / self.sensitivityModifier;
    return saturation;
}

- (float)hueFromVector:(CGPoint)velocityVector {
    float hue = atan2f(velocityVector.x, velocityVector.y);
    hue = (hue + M_PI) / (2 * M_PI) ; // reduce range of value to 0-1,
    hue = fmod(hue + 0.5, 1.0);
    return hue;
}

- (void)sendNotificationForChangeType:(NSString *)changeType {
    NSDictionary * dict = @{@"component" : [NSNumber numberWithInteger:_component]};
    [self.notificationCenter postNotificationName:ColorDidChangeNotification
                                      object:self.rgbColor
                                    userInfo:dict];
}

-(void)changeLuminance:(float)direction{
    
}

@end
