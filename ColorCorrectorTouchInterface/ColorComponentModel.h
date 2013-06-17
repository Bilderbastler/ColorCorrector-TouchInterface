//
//  ColorComponentModel.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 03.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSVColor.h"
#import "RGBColor.h"

extern NSString *const ColorDidChangeNotification ;


typedef NS_ENUM(NSInteger, ComponentType) {
    ComponentTypeGain,
    ComponentTypeGamma,
    ComponentTypeLift
};

@interface ColorComponentModel : NSObject

@property (nonatomic, strong) LSVColor* lsvColor;
@property (nonatomic, strong) RGBColor* rgbColor;
@property (nonatomic, weak) NSNotificationCenter* notificationCenter;
@property (nonatomic) float sensitivityModifier;

- (id)initWithComponentType:(ComponentType)component;
-(void)changeHueAndSaturation:(CGPoint)velocityVector;

@end
