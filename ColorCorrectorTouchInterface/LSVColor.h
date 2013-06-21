//
//  LSVColor.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 10.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RGBColor.h"

@class RGBColor;
@interface LSVColor : NSObject

@property (nonatomic) float hue;
@property (nonatomic) float saturation;
@property (nonatomic) float luminance;

@end
