//
//  ColorCorrectorTouchInterface - ColorComponentModelTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "ColorComponentModel.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
//#define HC_SHORTHAND
//#import <OCHamcrestIOS/OCHamcrestIOS.h>

// #define EXP_OLD_SYNTAX // enable backward-compatibility
#define EXP_SHORTHAND
#import "Expecta.h"

// Uncomment the next two lines to use OCMockito for mock objects:
#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>


@interface ColorComponentModelTest : SenTestCase
@end

@implementation ColorComponentModelTest
{
    // test fixture ivars go here
    ColorComponentModel* sut;
    
}

-(void)setUp{
    sut = [[ColorComponentModel alloc]init];
}

- (void)testInitialStateIsWhite {
    // given
    LSVColor* white = [[LSVColor alloc]init];
    // when
    white.luminance = 1.0;
    white.saturation = 0.0;
    // then
    expect([sut.lsvColor isEqual:white]).to.beTruthy();
}

- (void)testInitialStateRGBIsWhite {
    // given
    RGBColor* white = [[RGBColor alloc]init];
    // when
    white.red = 1.0;
    white.green = 1.0;
    white.blue = 1.0;
    // then
    expect(sut.rgbColor).to.equal(white);
}

- (void)testChangingSaturation {
    // given
    CGPoint pt = CGPointMake(23, 18);
    float oldSaturation = sut.lsvColor.saturation;
    // when
    [sut changeHueAndLuminance:pt];
    // then
    expect(sut.lsvColor.saturation).to.beGreaterThan(0);
    expect(oldSaturation).to.equal(0);
}

- (void)testTealishHue {
    // given
    CGPoint pt = CGPointMake(0, -3); // 180°
    // when
    [sut changeHueAndLuminance:pt];
    // then
    expect(sut.lsvColor.hue).to.equal(0.5);
}
- (void)testPurplishHue {
    // given
    CGPoint pt = CGPointMake(10, 0); // 90°
    // when
    [sut changeHueAndLuminance:pt];
    // then
    expect(sut.lsvColor.hue).to.equal(0.25);
}
- (void)testGreenishHue {
    // given
    CGPoint pt = CGPointMake(-8, 0); // 270°
    // when
    [sut changeHueAndLuminance:pt];
    // then
    expect(sut.lsvColor.hue).to.equal(0.75);
}
- (void)testRedishHue {
    // given
    CGPoint pt = CGPointMake(0, 10); // 0°
    // when
    [sut changeHueAndLuminance:pt];
    // then
    expect(sut.lsvColor.hue).to.equal(0.0);
}


@end

/*
 typedef struct {
 double r;       // percent
 double g;       // percent
 double b;       // percent
 } rgb;
 
 typedef struct {
 double h;       // angle in degrees
 double s;       // percent
 double v;       // percent
 } hsv;
 
 static hsv      rgb2hsv(rgb in);
 static rgb      hsv2rgb(hsv in);
 
 hsv rgb2hsv(rgb in)
 {
 hsv         out;
 double      min, max, delta;
 
 min = in.r < in.g ? in.r : in.g;
 min = min  < in.b ? min  : in.b;
 
 max = in.r > in.g ? in.r : in.g;
 max = max  > in.b ? max  : in.b;
 
 out.v = max;                                // v
 delta = max - min;
 if( max > 0.0 ) {
 out.s = (delta / max);                  // s
 } else {
 // r = g = b = 0                        // s = 0, v is undefined
 out.s = 0.0;
 out.h = NAN;                            // its now undefined
 return out;
 }
 if( in.r >= max )                           // > is bogus, just keeps compilor happy
 out.h = ( in.g - in.b ) / delta;        // between yellow & magenta
 else
 if( in.g >= max )
 out.h = 2.0 + ( in.b - in.r ) / delta;  // between cyan & yellow
 else
 out.h = 4.0 + ( in.r - in.g ) / delta;  // between magenta & cyan
 
 out.h *= 60.0;                              // degrees
 
 if( out.h < 0.0 )
 out.h += 360.0;
 
 return out;
 }
 
 
 rgb hsv2rgb(hsv in)
 {
 double      hh, p, q, t, ff;
 long        i;
 rgb         out;
 
 if(in.s <= 0.0) {       // < is bogus, just shuts up warnings
 if(isnan(in.h)) {   // in.h == NAN
 out.r = in.v;
 out.g = in.v;
 out.b = in.v;
 return out;
 }
 // error - should never happen
 out.r = 0.0;
 out.g = 0.0;
 out.b = 0.0;
 return out;
 }
 hh = in.h;
 if(hh >= 360.0) hh = 0.0;
 hh /= 60.0;
 i = (long)hh;
 ff = hh - i;
 p = in.v * (1.0 - in.s);
 q = in.v * (1.0 - (in.s * ff));
 t = in.v * (1.0 - (in.s * (1.0 - ff)));
 
 switch(i) {
 case 0:
 out.r = in.v;
 out.g = t;
 out.b = p;
 break;
 case 1:
 out.r = q;
 out.g = in.v;
 out.b = p;
 break;
 case 2:
 out.r = p;
 out.g = in.v;
 out.b = t;
 break;
 
 case 3:
 out.r = p;
 out.g = q;
 out.b = in.v;
 break;
 case 4:
 out.r = t;
 out.g = p;
 out.b = in.v;
 break;
 case 5:
 default:
 out.r = in.v;
 out.g = p;
 out.b = q;
 break;
 }
 return out;
 
 */
