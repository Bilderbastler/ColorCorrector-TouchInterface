//
//  LSVToRGBConverter.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 21.06.13.
//
#import "RGBColor.h"

@interface LSVToRGBConverter : NSObject

+(RGBColor*)convertColor:(LSVColor*)aColor;

@end
