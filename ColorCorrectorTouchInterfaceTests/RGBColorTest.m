//
//  ColorCorrectorTouchInterface - RGBColorTest.m
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

- (void)testMixGreenWithMagenta {
    // given
    RGBColor* whiteColor = sut;
    RGBColor* redColor = [[RGBColor alloc] init];
    redColor.green = 0;
    redColor.blue = 0;
    RGBColor* magentaColor = [[RGBColor alloc]init];
    magentaColor.red = 0;
    // when
    [redColor blendWithColor:magentaColor mix:1.0];
    // then
    expect(redColor.red).to.equal(whiteColor.red);
    expect(redColor.green).to.equal(whiteColor.green);
    expect(redColor.blue).to.equal(whiteColor.blue);
}

- (void)testMixingTheSameColors {
    // given
    RGBColor* otherWhiteColor = [[RGBColor alloc]init];
    // when
    [sut blendWithColor:otherWhiteColor mix:1.0];
    // then
    expect(sut).to.equal(otherWhiteColor);
}

- (void)testCopyResultInAnotherObject {
    // when
    RGBColor* copy = [sut copy];
    // then
    expect(sut).notTo.beIdenticalTo(copy);
}

- (void)testCopyResultsInEqualColor {
    // given
    sut.red = .4;
    sut.green = 1.9;
    sut.blue = 0;
    // when
    RGBColor* copy = [sut copy];
    // then
    expect(sut).to.equal(copy);
}

- (void)testStaticCreatorMakesColorObject {
    // given
    sut.red = .2;
    sut.green = 1.2;
    sut.blue = .9;
    // when
    RGBColor* newColor = [RGBColor colorWithRed:sut.red
                                          green:sut.green
                                           blue:sut.blue];
    // then
    expect(sut).to.equal(newColor);
}

@end
