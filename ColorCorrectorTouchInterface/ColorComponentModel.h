//
//  ColorComponentModel.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 03.06.13.
//

#import <Foundation/Foundation.h>
#import "LSVColor.h"
#import "RGBColor.h"

extern NSString *const ColorDidChangeNotification ;
extern NSString *const ComponentChangeTypeColor;
extern NSString *const ComponentChangeTypeLuminance;

typedef NS_ENUM(NSInteger, ComponentType) {
    ComponentTypeGain = 0,
    ComponentTypeGamma = 1,
    ComponentTypeLift = 2
};

@interface ColorComponentModel : NSObject

@property (nonatomic, strong) RGBColor* rgbColor;
@property (nonatomic, weak) NSNotificationCenter* notificationCenter;
@property (nonatomic) float sensitivityModifier;

-(id)initWithComponentType:(ComponentType)component;
-(void)changeHueAndSaturation:(CGPoint)velocityVector;
-(void)changeLuminance:(float)direction;

@end
