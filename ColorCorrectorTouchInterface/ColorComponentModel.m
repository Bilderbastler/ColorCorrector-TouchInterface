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
        self.lsvColor = [[LSVColor alloc]init];
        _sensitivityModifier = 10;
    }
    return self;
}

-(void)changeHueAndSaturation:(CGPoint)velocityVector{
    //update lsv values
    self.lsvColor.saturation = [self saturationFromVector:velocityVector];
    self.lsvColor.hue = [self hueFromVector:velocityVector];
    
    //calculate rgb from new lsv values
    [self.rgbColor setRGBFromLSV:self.lsvColor];
    
    // than recalulate lsv because the rgb values are the definite reference values
    // so we can only allow conversion ambiguities in the lsv version
    [self.lsvColor setLSVFromLRGB:self.rgbColor];
    
    [self sendNotificationForChangeType:ComponentChangeTypeColor];
}

- (float)saturationFromVector:(CGPoint)vector {
    float sumOfSqr = vector.x * vector.x + vector.y * vector.y;
    float saturationChange = sqrtf(sumOfSqr);
    saturationChange = saturationChange / self.sensitivityModifier;
    float saturation = self.lsvColor.saturation + saturationChange;
    return saturation;
}

- (float)hueFromVector:(CGPoint)velocityVector {
    float hueChange = atan2f(velocityVector.x, velocityVector.y);
    hueChange = (hueChange + M_PI) / (2 * M_PI) ; // reduce range of value to 0-1,
    hueChange = fmod(hueChange + 0.5, 1.0);
    float hue = self.lsvColor.hue + hueChange;
    return hue;
}

- (void)sendNotificationForChangeType:(NSString *)changeType {
    NSDictionary * dict = @{@"component" : [NSNumber numberWithInteger:_component]};
    [self.notificationCenter postNotificationName:ColorDidChangeNotification
                                      object:self.rgbColor
                                    userInfo:dict];
}

@end
