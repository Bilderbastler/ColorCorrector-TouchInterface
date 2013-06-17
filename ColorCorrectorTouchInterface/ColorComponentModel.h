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
extern NSString *const ComponentChangeTypeColor;
extern NSString *const ComponentChangeTypeLuminance;

typedef NS_ENUM(NSInteger, ComponentType) {
    ComponentTypeLift,
    ComponentTypeGamma,
    ComponentTypeGain
};

@interface ColorComponentModel : NSObject

@property (nonatomic, strong) LSVColor* lsvColor;
@property (nonatomic, strong) RGBColor* rgbColor;
@property (nonatomic, weak) NSNotificationCenter* notificationCenter;
@property (nonatomic) float sensitivityModifier;

- (id)initWithComponentType:(ComponentType)component;
-(void)changeHueAndLuminance:(CGPoint)velocityVector;

@end
