//
//  ViewFactory.m
//  ColorCorrectorTouchInterface
//
//  Creates and builds the Luminance and Color Surface Views with it's ui
//  components
//
//  Created by Franzi on 15.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "ViewFactory.h"

@implementation ViewFactory

-(LuminanceSurfaceView *)createLuminanceSurface{
    LuminanceSurfaceView* product = [[LuminanceSurfaceView alloc] init];
    return product;
}

-(ColorSurfaceView *)createColorSurface{
    ColorSurfaceView* product = [[ColorSurfaceView alloc]init];
    return product;
}

@end
