//
//  ColorCorrectorTouchInterface - LSVColorTest.m
//
//  Created by: Franzi
//

    // Class under test
#import "LSVColor.h"

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



@interface LSVColorTest : SenTestCase
@end

@implementation LSVColorTest
{
    // test fixture ivars go here
    LSVColor* sut;
    float range;
    
}

-(void)setUp{
    range = 0.0001;
    sut = [[LSVColor alloc] init];
}

- (void)testInitialStateISWhite {
    expect(sut.saturation).to.equal(0);
    expect(sut.luminance).to.equal(1);
    expect(sut.hue).to.equal(0);
}

- (void)testObjectToEqualSelf {
    // when
    sut.hue = 0.8;
    sut.luminance = 1.3;
    sut.saturation = 0.2;    
    // then
    expect(sut).to.equal(sut);
}

- (void)testColorToEqualSameColor {
    // given
    LSVColor* eqCol = [[LSVColor alloc]init];
    sut.saturation = 0.3;
    sut.luminance = 1.3;
    sut.hue = 0.9;

    // when
    eqCol.luminance = sut.luminance;
    eqCol.hue = sut.hue;
    eqCol.saturation = sut.saturation;
    
    // then
    expect([sut isEqual:eqCol]).to.beTruthy();
}

- (void)testHueCannotBeNegative {    
    // when
    sut.hue = -3;
    
    // then
    expect(sut.hue).to.equal(0);
}

- (void)testHueCanontBeAboveOne {    
    // when
    sut.hue = 5;
    
    // then
    expect(sut.hue).to.equal(1);
}

- (void)testHueValueCanBeSet {
    // given
    float newHue = 0.71;
    
    // when
    sut.hue = newHue;
    
    // then
    expect(sut.hue).to.equal(newHue);
}

- (void)testLuminanceCanGoToTen {    
    // when
    sut.luminance = 11;
    
    // then
    expect(sut.luminance).to.equal(10);
}

- (void)testLuminanceCannotBeNegative {
    // when
    sut.luminance = -3;
    
    // then
    expect(sut.luminance).to.equal(0);
}

- (void)testRGBConversionOfWhite {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(0.0, range);
    expect(sut.saturation).to.beCloseToWithin(0.0, range);
}

- (void)testRGBConversionOfGrey {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.5;
    aColor.green = 0.5;
    aColor.blue = 0.5;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(0.0, range);
    expect(sut.saturation).to.beCloseToWithin(0.0, range);
    expect(sut.luminance).to.beCloseToWithin(0.5, range);
}

- (void)testRGBConversionOfBlack {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 0.0;
    aColor.blue = 0.0;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.luminance).to.beCloseToWithin(0.0, range);
}

- (void)testRGBConversionOfRed {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 1.0;
    aColor.green = 0.0;
    aColor.blue = 0.0;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(0.0, range);
    expect(sut.saturation).to.beCloseToWithin(1.0, range);
    expect(sut.luminance).to.beCloseToWithin(1.0, range);
}

- (void)testRGBConversionOfGreen {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 1.0;
    aColor.blue = 0.0;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(2.0/3.0, range);
    expect(sut.saturation).to.beCloseToWithin(1.0, range);
    expect(sut.luminance).to.beCloseToWithin(1.0, range);
}
- (void)testRGBConversionOfBlue {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 0.0;
    aColor.blue = 1.0;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(1.0/3.0, range);
    expect(sut.saturation).to.beCloseToWithin(1.0, range);
    expect(sut.luminance).to.beCloseToWithin(1.0, range);
}
- (void)testRGBConversionOfMagenta {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 1.0;
    aColor.green = 0.0;
    aColor.blue = 1.0;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(1.0/6.0, range);
    expect(sut.saturation).to.beCloseToWithin(1.0, range);
   
    expect(sut.luminance).to.beCloseToWithin(1.0, range);
}
- (void)testRGBConversionOfCyan {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 1.0;
    aColor.blue = 1.0;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(3.0/6.0, range);
    expect(sut.saturation).to.beCloseToWithin(1.0, range);
    expect(sut.luminance).to.beCloseToWithin(1.0, range);
}

- (void)testRGBConversionOfYellow {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 1.0;
    aColor.green = 1.0;
    aColor.blue = 0.0;
    
    // when
    [sut setLSVFromLRGB:aColor];
    
    // then
    expect(sut.hue).to.beCloseToWithin(5.0/6.0, range);
    expect(sut.saturation).to.beCloseToWithin(1.0, range);
    expect(sut.luminance).to.beCloseToWithin(1.0, range);
}

@end
