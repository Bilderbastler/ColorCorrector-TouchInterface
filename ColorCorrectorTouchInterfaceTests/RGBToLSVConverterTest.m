//
//  ColorCorrectorTouchInterface - RGBToLSVConverterTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "RGBtoLSVConverter.h"

    // Collaborators
#import "LSVToRGBConverter.h"
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


@interface RGBToLSVConverterTest : SenTestCase
@end

@implementation RGBToLSVConverterTest{
    LSVColor* lsvColor;
    float range;
}

-(void)setUp{
    range = 0.0001;
}


- (void)testRGBConversionOfWhite {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(0.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(0.0, range);
}

- (void)testRGBConversionOfGrey {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.5;
    aColor.green = 0.5;
    aColor.blue = 0.5;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(0.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(0.0, range);
    expect(lsvColor.luminance).to.beCloseToWithin(0.5, range);
}

- (void)testRGBConversionOfBlack {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 0.0;
    aColor.blue = 0.0;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.luminance).to.beCloseToWithin(0.0, range);
}

- (void)testRGBConversionOfRed {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 1.0;
    aColor.green = 0.0;
    aColor.blue = 0.0;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(0.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(1.0, range);
    expect(lsvColor.luminance).to.beCloseToWithin(1.0, range);
}

- (void)testRGBConversionOfGreen {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 1.0;
    aColor.blue = 0.0;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(2.0/3.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(1.0, range);
    expect(lsvColor.luminance).to.beCloseToWithin(1.0, range);
}
- (void)testRGBConversionOfBlue {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 0.0;
    aColor.blue = 1.0;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(1.0/3.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(1.0, range);
    expect(lsvColor.luminance).to.beCloseToWithin(1.0, range);
}
- (void)testRGBConversionOfMagenta {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 1.0;
    aColor.green = 0.0;
    aColor.blue = 1.0;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(1.0/6.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(1.0, range);
    
    expect(lsvColor.luminance).to.beCloseToWithin(1.0, range);
}
- (void)testRGBConversionOfCyan {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 0.0;
    aColor.green = 1.0;
    aColor.blue = 1.0;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(3.0/6.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(1.0, range);
    expect(lsvColor.luminance).to.beCloseToWithin(1.0, range);
}

- (void)testRGBConversionOfYellow {
    // given
    RGBColor* aColor = [[RGBColor alloc]init];
    aColor.red = 1.0;
    aColor.green = 1.0;
    aColor.blue = 0.0;
    
    // when
    lsvColor = [RGBtoLSVConverter convertColor:aColor];
    
    // then
    expect(lsvColor.hue).to.beCloseToWithin(5.0/6.0, range);
    expect(lsvColor.saturation).to.beCloseToWithin(1.0, range);
    expect(lsvColor.luminance).to.beCloseToWithin(1.0, range);
}

@end
