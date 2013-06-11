//
//  RGBColor.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 10.06.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSVColor.h"
@class LSVColor;
@interface RGBColor : NSObject

@property (nonatomic) float red;
@property (nonatomic) float green;
@property (nonatomic) float blue;


-(void)setRGBFromLSV:(LSVColor*)newColor;
@end
