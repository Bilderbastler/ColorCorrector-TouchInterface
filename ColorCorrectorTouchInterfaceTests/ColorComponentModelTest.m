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
    NSNotification* receivedNotification;
    
}

-(void)setUp{
    sut = [[ColorComponentModel alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:ColorDidChangeNotification
                                               object:nil];
}

-(void)tearDown{
    receivedNotification = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)didReceiveNotification:(NSNotification*)aNotification{
    receivedNotification = aNotification;
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

- (void)testSendsNotificationAfterColorChange {
    // given
    CGPoint pt = CGPointMake(34, 12);
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveNotification:)
                                                 name:ColorDidChangeNotification
                                               object:nil];
    // when
    [sut changeHueAndLuminance:pt];
    
    // then
    expect(receivedNotification).notTo.beNil();
    
    receivedNotification = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)testNotificationStringExists {
    // then
    expect(ColorDidChangeNotification).notTo.beEmpty();
}

- (void)testChangeTypeStringsExists {
    // then
    expect(ComponentChangeTypeColor).notTo.beEmpty();
    expect(ComponentChangeTypeLuminance).notTo.beEmpty();
}

- (void)testNotificationSendsComponentObject {
    // given
    CGPoint pt = CGPointMake(34, 12);
    
    // when
    [sut changeHueAndLuminance:pt];
    
    // then
    expect(sut).to.equal(receivedNotification.object);
}

- (void)testNotificationSendsChangeTypeInDictionary {
    // given
    CGPoint pt = CGPointMake(34, 12);

    // when
    [sut changeHueAndLuminance:pt];
    
    // then
    NSString * val = receivedNotification.userInfo[@"change"];

    expect(val).to.equal(ComponentChangeTypeColor);
}
@end
