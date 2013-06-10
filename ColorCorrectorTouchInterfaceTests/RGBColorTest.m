//
//  ColorCorrectorTouchInterface - RGBColorTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "RGBColor.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
//#define HC_SHORTHAND
//#import <OCHamcrestIOS/OCHamcrestIOS.h>

// Uncomment the next three lines to use Expecta for test assertions:
//#define EXP_OLD_SYNTAX // enable backward-compatibility
#define EXP_SHORTHAND
#import "Expecta.h"

// Uncomment the next two lines to use OCMockito for mock objects:
//#define MOCKITO_SHORTHAND
//#import <OCMockitoIOS/OCMockitoIOS.h>


@interface RGBColorTest : SenTestCase
@end

@implementation RGBColorTest
{
    // test fixture ivars go here
    RGBColor* sut;
}

-(void)setUp{
    sut = [[RGBColor alloc]init];
}

- (void)testObjectISEqualToItSelf {
    // given
    
    // when
    sut.red = 0.2;
    sut.green = 0.9;
    sut.blue = 1.0;
    // then
    expect(sut).to.equal(sut);
}

- (void)testObjectIsEqualToEqualColor {
    // given
    RGBColor* eqCol = [[RGBColor alloc]init];
    sut.green = 0.4;
    sut.blue = 0.0;
    
    // when
    eqCol.red = sut.red;
    eqCol.green = sut.green;
    eqCol.blue = sut.blue;
    
    // then
    expect([sut isEqual:eqCol]).to.beTruthy();
}
- (void)testInitialStateISWhite {
    // given
    
    // when
    
    // then
    expect(sut.red).to.equal(1.0);
    expect(sut.green).to.equal(1.0);
    expect(sut.blue).to.equal(1.0);
}

- (void)testRedCannotBeNegative {
    // given
    
    // when
    sut.red = -1;
    // then
    expect(sut.red).to.equal(0);
}

- (void)testRedCannotBeGreaterThanTen{
    // given
    
    // when
    sut.red = 11;
    // then
    expect(sut.red).to.equal(10);
}

- (void)testGreenCannotBeNegative {
    // given
    
    // when
    sut.green = -1;
    // then
    expect(sut.green).to.equal(0);
}

- (void)testGreenCannotBeGreaterThanTen{
    // given
    
    // when
    sut.green = 11;
    // then
    expect(sut.green).to.equal(10);
}

- (void)testBlueCannotBeNegative {
    // given
    
    // when
    sut.blue = -1;
    // then
    expect(sut.blue).to.equal(0);
}

- (void)testBlueCannotBeGreaterThanTen{
    // given
    
    // when
    sut.blue = 11;
    // then
    expect(sut.blue).to.equal(10);
}

- (void)testGreyHSVConvertsToGreyRGB {
    // given
    LSVColor* grey = [[LSVColor alloc]init];
    // when
    grey.luminance = 0.5;
    grey.saturation = 0.0;
    [sut setRGBFromLSV:grey];
    // then
    expect(sut.blue).to.equal(grey.luminance);
    expect(sut.red).to.equal(grey.luminance);
    expect(sut.green).to.equal(grey.luminance);
}

- (void)testRedHSVConvertsToRedRGB {
    // given
    LSVColor* red = [[LSVColor alloc]init];
    // when
    red.hue = 1; // red
    red.luminance = 1;
    red.saturation = 1;
    [sut setRGBFromLSV:red];
    // then
    expect(sut.red).to.equal(1.0);
    expect(sut.green).to.equal(0.0);
    expect(sut.blue).to.equal(0.0);
}
- (void)testGreenHSVConvertsToGreenRGB {
    // given
    LSVColor* green = [[LSVColor alloc]init];
    // when
    green.hue = 2.f/3.f; //green
    green.luminance = 1;
    green.saturation = 1;
    [sut setRGBFromLSV:green];
    // then
    expect(sut.red).to.beCloseToWithin(0.0, 0.0001);
    expect(sut.green).to.beCloseToWithin(1.0, 0.0001);
    expect(sut.blue).to.beCloseToWithin(0.0, 0.0001);
}

- (void)testYellowHSVConvertsYellowRGB {
    // given
    LSVColor* yellow = [[LSVColor alloc]init];
    // when
    yellow.hue = 5.0/6.0;
    yellow.luminance = 1.f;
    yellow.saturation = 1.f;
    [sut setRGBFromLSV:yellow];
    // then
    expect(sut.red).to.beCloseToWithin(1.0, 0.0001);
    expect(sut.green).to.beCloseToWithin(1.0, 0.0001);
    expect(sut.blue).to.beCloseToWithin(0.0, 0.0001);
}

- (void)testBlackHSVConvertsBlackRGB {
    // given
    LSVColor* black = [[LSVColor alloc]init];
    // when
    black.luminance = 0;
    [sut setRGBFromLSV:black];
    // then
    expect(sut.red).to.beCloseToWithin(0.0, 0.0001);
    expect(sut.green).to.beCloseToWithin(0.0, 0.0001);
    expect(sut.blue).to.beCloseToWithin(0.0, 0.0001);
}

- (void)testWhiteHSVConvertsWhiteRGB {
    // given
    LSVColor* white = [[LSVColor alloc]init];
    // when
    white.luminance = 1;
    white.saturation = 0;
    [sut setRGBFromLSV:white];
    // then
    expect(sut.red).to.beCloseToWithin(1.0, 0.0001);
    expect(sut.green).to.beCloseToWithin(1.0, 0.0001);
    expect(sut.blue).to.beCloseToWithin(1.0, 0.0001);
}
@end
