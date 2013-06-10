//
//  ColorComponentModel.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 03.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ColorComponentModel : NSObject

@property (nonatomic) float hue;
@property (nonatomic) float saturation;
@property (nonatomic) float luminance;

@property (nonatomic) float red;
@property (nonatomic) float green;
@property (nonatomic) float blue;

@property (nonatomic) float sensitivityModifier;

-(void)changeHueAndLuminance:(CGPoint)velocityVector;

@end
