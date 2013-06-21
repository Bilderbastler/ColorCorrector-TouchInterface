//
//  ColorCorrectorTouchInterface - LSVToRGBConverterTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "LSVToRGBConverter.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
//#define HC_SHORTHAND
//#import <OCHamcrestIOS/OCHamcrestIOS.h>

// Uncomment the next two lines to use Expecta for test assertions:
//#define EXP_OLD_SYNTAX // enable backward-compatibility
#define EXP_SHORTHAND
#import "Expecta.h"

// Uncomment the next two lines to use OCMockito for mock objects:
//#define MOCKITO_SHORTHAND
//#import <OCMockitoIOS/OCMockitoIOS.h>


@interface LSVToRGBConverterTest : SenTestCase
@end

@implementation LSVToRGBConverterTest{
    RGBColor* rgbColor;
}

- (void)testGreyHSVConvertsToGreyRGB {
    // given
    LSVColor* grey = [[LSVColor alloc]init];
    // when
    grey.luminance = 0.5;
    grey.saturation = 0.0;
    rgbColor = [LSVToRGBConverter convertColor:grey];
    // then
    expect(rgbColor.blue).to.equal(grey.luminance);
    expect(rgbColor.red).to.equal(grey.luminance);
    expect(rgbColor.green).to.equal(grey.luminance);
}

- (void)testRedHSVConvertsToRedRGB {
    // given
    LSVColor* red = [[LSVColor alloc]init];
    // when
    red.hue = 1; // red
    red.luminance = 1;
    red.saturation = 1;
    rgbColor = [LSVToRGBConverter convertColor:red];
    // then
    expect(rgbColor.red).to.equal(1.0);
    expect(rgbColor.green).to.equal(0.0);
    expect(rgbColor.blue).to.equal(0.0);
}
- (void)testGreenHSVConvertsToGreenRGB {
    // given
    LSVColor* green = [[LSVColor alloc]init];
    // when
    green.hue = 2.f/3.f; //green
    green.luminance = 1;
    green.saturation = 1;
    rgbColor = [LSVToRGBConverter convertColor:green];
    // then
    expect(rgbColor.red).to.beCloseToWithin(0.0, 0.0001);
    expect(rgbColor.green).to.beCloseToWithin(1.0, 0.0001);
    expect(rgbColor.blue).to.beCloseToWithin(0.0, 0.0001);
}

- (void)testBlueHSVConvertsToBlueRGB {
    // given
    LSVColor* blue = [[LSVColor alloc]init];
    // when
    blue.hue = 1.f/3.f; //blue
    blue.luminance = 1;
    blue.saturation = 1;
    rgbColor = [LSVToRGBConverter convertColor:blue];
    // then
    expect(rgbColor.red).to.beCloseToWithin(0.0, 0.0001);
    expect(rgbColor.green).to.beCloseToWithin(0.0, 0.0001);
    expect(rgbColor.blue).to.beCloseToWithin(1.0, 0.0001);
}
- (void)testYellowHSVConvertsYellowRGB {
    // given
    LSVColor* yellow = [[LSVColor alloc]init];
    // when
    yellow.hue = 5.0/6.0;
    yellow.luminance = 1.f;
    yellow.saturation = 1.f;
    rgbColor = [LSVToRGBConverter convertColor:yellow];
    // then
    expect(rgbColor.red).to.beCloseToWithin(1.0, 0.0001);
    expect(rgbColor.green).to.beCloseToWithin(1.0, 0.0001);
    expect(rgbColor.blue).to.beCloseToWithin(0.0, 0.0001);
}

- (void)testMagentaHSVConvertsMagentaRGB {
    // given
    LSVColor* magenta = [[LSVColor alloc]init];
    // when
    magenta.hue = 1.0/6.0;
    magenta.luminance = 1.f;
    magenta.saturation = 1.f;
    rgbColor = [LSVToRGBConverter convertColor:magenta];
    // then
    expect(rgbColor.red).to.beCloseToWithin(1.0, 0.0001);
    expect(rgbColor.green).to.beCloseToWithin(0.0, 0.0001);
    expect(rgbColor.blue).to.beCloseToWithin(1.0, 0.0001);
}
- (void)testCyanHSVConvertsCyanRGB {
    // given
    LSVColor* cyan = [[LSVColor alloc]init];
    // when
    cyan.hue = 3.0/6.0;
    cyan.luminance = 1.f;
    cyan.saturation = 1.f;
    rgbColor = [LSVToRGBConverter convertColor:cyan];
    // then
    expect(rgbColor.red).to.beCloseToWithin(0.0, 0.0001);
    expect(rgbColor.green).to.beCloseToWithin(1.0, 0.0001);
    expect(rgbColor.blue).to.beCloseToWithin(1.0, 0.0001);
}
- (void)testBlackHSVConvertsBlackRGB {
    // given
    LSVColor* black = [[LSVColor alloc]init];
    // when
    black.luminance = 0;
    rgbColor = [LSVToRGBConverter convertColor:black];
    // then
    expect(rgbColor.red).to.beCloseToWithin(0.0, 0.0001);
    expect(rgbColor.green).to.beCloseToWithin(0.0, 0.0001);
    expect(rgbColor.blue).to.beCloseToWithin(0.0, 0.0001);
}

- (void)testWhiteHSVConvertsWhiteRGB {
    // given
    LSVColor* white = [[LSVColor alloc]init];
    // when
    white.luminance = 1;
    white.saturation = 0;
    rgbColor = [LSVToRGBConverter convertColor:white];
    // then
    expect(rgbColor.red).to.beCloseToWithin(1.0, 0.0001);
    expect(rgbColor.green).to.beCloseToWithin(1.0, 0.0001);
    expect(rgbColor.blue).to.beCloseToWithin(1.0, 0.0001);
}

@end
