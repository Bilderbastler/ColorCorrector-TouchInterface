//
//  ViewFactory.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 15.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LuminanceSurfaceView.h"
#import "ColorSurfaceView.h"

@interface ViewFactory : NSObject

-(LuminanceSurfaceView *)createLuminanceSurface;
-(ColorSurfaceView *)createColorSurface;

@end
