//
//  RGBtoLSVConverter.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 21.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSVColor.h"


@interface RGBtoLSVConverter : NSObject

+(LSVColor*)convertColor:(RGBColor*)aColor;

@end
