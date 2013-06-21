//
//  ColorCorrectorTouchInterface - ColorComponentModelTest.m
//
//  Created by: Franzi
//

    // Class under test
#import "ColorComponentModel.h"

    // Collaborators
#import "RGBtoLSVConverter.h"
    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
//#define HC_SHORTHAND
//#import <OCHamcrestIOS/OCHamcrestIOS.h>

// #define EXP_OLD_SYNTAX // enable backward-compatibility
#define EXP_SHORTHAND
#import "Expecta.h"

@interface ColorComponentModelTest : SenTestCase
@end

@implementation ColorComponentModelTest
{
    // test fixture ivars go here
    ColorComponentModel* sut;
    NSNotification* receivedNotification;
    NSNotificationCenter* testCenter;
    
}

-(void)setUp{
    testCenter = [[NSNotificationCenter alloc]init];
    [testCenter addObserver:self
                   selector:@selector(didReceiveNotification:)
                       name:ColorDidChangeNotification
                     object:nil];
    sut = [[ColorComponentModel alloc]initWithComponentType:ComponentTypeGain];
    sut.notificationCenter = testCenter;
}

-(void)tearDown{
    receivedNotification = nil;
    sut = nil;
    [testCenter removeObserver:self];
    testCenter = nil;
}

-(void)didReceiveNotification:(NSNotification*)aNotification{
    receivedNotification = aNotification;
}

- (void)testInitialStateIsWhite {
    RGBColor* white = [[RGBColor alloc]init];
    expect([sut.rgbColor isEqual:white]).to.beTruthy();
}

- (void)testTealishHue {
    // given
    CGPoint pt = CGPointMake(0, -3); // 180°
    // when
    [sut changeHueAndSaturation:pt];
    LSVColor * color = [RGBtoLSVConverter convertColor:sut.rgbColor];
    // then
    expect(color.hue).to.equal(0.5);
}
- (void)testPurplishHue {
    // given
    CGPoint pt = CGPointMake(1, 0); // 90°
    // when
    [sut changeHueAndSaturation:pt];
    LSVColor * color = [RGBtoLSVConverter convertColor:sut.rgbColor];
    // then
    expect(color.hue).to.equal(0.25);
}
- (void)testGreenishHue {
    // given
    CGPoint pt = CGPointMake(-2, 0); // 270°
    // when
    [sut changeHueAndSaturation:pt];
    LSVColor * color = [RGBtoLSVConverter convertColor:sut.rgbColor];
    // then
    expect(color.hue).to.equal(0.75);
}
- (void)testRedishHue {
    // given
    CGPoint pt = CGPointMake(0, 10); // 0°
    // when
    [sut changeHueAndSaturation:pt];
    LSVColor * color = [RGBtoLSVConverter convertColor:sut.rgbColor];
    // then
    expect(color.hue).to.equal(0.0);
}

- (void)testHasNotificationCenter {
    expect(sut.notificationCenter).notTo.beNil();
}

- (void)testSendsNotificationAfterColorChange {
    // given
    CGPoint pt = CGPointMake(34, 12);
    [testCenter addObserver:self
                   selector:@selector(didReceiveNotification:)
                       name:ColorDidChangeNotification
                     object:nil];
    // when
    [sut changeHueAndSaturation:pt];
    
    // then
    expect(receivedNotification).notTo.beNil();
    
    receivedNotification = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)testNotificationStringExists {
    // then
    expect(ColorDidChangeNotification).notTo.beEmpty();
}

- (void)testNotificationSendsComponentObject {
    // given
    CGPoint pt = CGPointMake(34, 12);
    
    // when
    [sut changeHueAndSaturation:pt];
    
    // then
    expect(sut.rgbColor).to.equal(receivedNotification.object);
}

- (void)testComponentEnumWorks{
    expect(ComponentTypeGain).notTo.equal(ComponentTypeGamma);
}

- (void)testNotficationContainsComponentType {
    // given
    CGPoint pt = CGPointMake(34, 12);
    
    // when
    [sut changeHueAndSaturation:pt];
    NSNumber * componentType = [receivedNotification.userInfo objectForKey:@"component"];
    
    // then
    expect([componentType integerValue]).to.equal(ComponentTypeGain);
}
- (void)testEnum {
    expect(ComponentTypeGain).to.equal(0);
    expect(ComponentTypeGamma).to.equal(1);
    expect(ComponentTypeLift).to.equal(2);
}

- (void)testTwoContraryMovementsResultInOldColor {
    // given
    CGPoint firstMovement = CGPointMake(2, 6);
    CGPoint secondMovement = CGPointMake(3, 4);
    CGPoint contraryMovement = CGPointMake(secondMovement.x * -1, secondMovement.y * -1);
    // when
    [sut changeHueAndSaturation:firstMovement];
    [sut changeHueAndSaturation:secondMovement];
    RGBColor* oldColor = [sut.rgbColor copy];
    [sut changeHueAndSaturation:contraryMovement];
    // then
    expect(sut.rgbColor).to.equal(oldColor);
}

@end
