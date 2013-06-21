//
//  RGBColor.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 10.06.13.
//

#import <Foundation/Foundation.h>
#import "LSVColor.h"
@class LSVColor;
@interface RGBColor : NSObject <NSCopying>

@property (nonatomic) float red;
@property (nonatomic) float green;
@property (nonatomic) float blue;


+(RGBColor*)colorWithRed:(float)red green:(float)green blue:(float)blue;
-(void)blendWithColor:(RGBColor*)otherColor mix:(float)strength;
-(UIColor*)uiColorFromRGB;
@end
