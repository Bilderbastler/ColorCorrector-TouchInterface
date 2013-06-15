//
//  ViewFactory.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 15.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "LuminanceSurfaceView.h"
#import "ColorSurfaceView.h"

@interface LayerFactory : NSObject

-(CALayer*)createFourDirectionArrows;
-(CALayer*)createTwoDirectionArrow;

@end
