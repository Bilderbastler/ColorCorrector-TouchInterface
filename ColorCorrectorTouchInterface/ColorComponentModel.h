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

NSString *const ColorDidChangeNotification;

@interface ColorComponentModel : NSObject

@property (nonatomic, strong) LSVColor* lsvColor;
@property (nonatomic, strong) RGBColor* rgbColor;

@property (nonatomic) float sensitivityModifier;

-(void)changeHueAndLuminance:(CGPoint)velocityVector;

@end
