//
//  ColorCorrectorTouchInterface - ViewControllerTest.m
//
//  Created by: Franzi
//

    // Class under test
#import "ViewController.h"

    // Collaborators

    // Test support
#import <SenTestingKit/SenTestingKit.h>

// Uncomment the next two lines to use OCHamcrest for test assertions:
//#define HC_SHORTHAND
//#import <OCHamcrestIOS/OCHamcrestIOS.h>

// #define EXP_OLD_SYNTAX // enable backward-compatibility
#define EXP_SHORTHAND
#import "Expecta.h"
#import "EXPMatchers+beVerified.h"

// Uncomment the next two lines to use OCMockito for mock objects:
//#define MOCKITO_SHORTHAND
//#import <OCMockitoIOS/OCMockitoIOS.h>

#import <OCMock/OCMock.h>

@interface ViewControllerTest : SenTestCase
@end

@implementation ViewControllerTest{
    // test fixture ivars go here
    ViewController* sut;
    NSNotificationCenter* testCenter;
}

-(void)setUp{
    testCenter = [[NSNotificationCenter alloc]init];
    sut = [[ViewController alloc] initWithNibName:nil bundle:nil notificationCenter:testCenter];
}

- (void)testColorFieldShouldBeConnected {
    // given
    [sut view];
    
    // then
    expect(sut.colorField).notTo.beNil();
    expect(sut.colorField).to.beKindOf([ColorSurfaceView class]);
}

- (void)testluminanceFieldShouldBeConnected {
    // given
    [sut view];
    
    // then
    expect([sut luminanceField]).notTo.beNil();
    expect(sut.luminanceField).to.beKindOf([LuminanceSurfaceView class]);
}

- (void)testColorFieldHasGestureRecognizers {
    // given
    [sut view];    
    // then
    expect(sut.colorField.gestureRecognizers).to.haveCountOf(3);    
}

- (void)testLuminanceFieldHasGestureRecognizers {
    // given
    [sut view];
    // when
    
    // then
    expect(sut.luminanceField.gestureRecognizers).to.haveCountOf(3);    
}

- (void)testViewControllerCallsModelWhenColorInterfaceReceivesMovingTouch {
    // given
    UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    id grMock  = [OCMockObject partialMockForObject:gr];
    [[[grMock stub] andReturnValue: OCMOCK_VALUE((NSUInteger){1})] numberOfTouches];
    CGPoint velocityVektor = CGPointMake(20, 20);
    [[[grMock stub] andReturnValue: OCMOCK_VALUE(velocityVektor)] velocityInView:sut.colorField];
    
    ColorComponentModel *colorComponent = [OCMockObject mockForClass: [ColorComponentModel class]];
    id colorMock = colorComponent;
    [[colorMock expect] changeHueAndSaturation:velocityVektor];
    sut.gain = colorComponent;
    
    // when
    [sut fingerMoved:gr];
    
    // then
    expect(colorMock).to.beVerified();
}

- (void)testViewControllerCallsModelWhenLuminanceInterfaceReceivesMovingTouch {
    // given
    UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    id grMock  = [OCMockObject partialMockForObject:gr];
    [[[grMock stub] andReturnValue: OCMOCK_VALUE((NSUInteger){1})] numberOfTouches];
    id viewMock = [OCMockObject mockForClass: [LuminanceSurfaceView class]];
    sut.luminanceField = viewMock;
    [[[grMock stub] andReturn: sut.luminanceField] view];
    CGPoint velocityVektor = CGPointMake(20, 20);
    [[[grMock stub] andReturnValue: OCMOCK_VALUE(velocityVektor)] velocityInView:sut.luminanceField];
    
    ColorComponentModel *colorComponent = [OCMockObject mockForClass: [ColorComponentModel class]];
    id colorMock = colorComponent;
    [[colorMock expect] changeLuminance:velocityVektor.y];
    sut.gain = colorComponent;
    
    // when
    [sut fingerMoved:gr];
    
    // then
    expect(colorMock).to.beVerified();
}

- (void)testControllerReceivesColorChangeNotification {
    // given
    id observedSUT = [OCMockObject partialMockForObject:sut];
    [[observedSUT expect] aColorModelHasChanged:[OCMArg checkWithBlock:^BOOL(id obj) {
        if ([obj isKindOfClass:[NSNotification class]]) {
            return YES;
        }else{
            return NO;
        }
    }]];
    
    // when
    [sut view];
    [testCenter postNotificationName:ColorDidChangeNotification object:nil];
    
    // then
    //[observedSUT verify];
    expect(observedSUT).to.beVerified();
}

- (void)testBackgroundColorDidChange {
    // given
    ColorSurfaceView* stubView = [[ColorSurfaceView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    sut.colorField = stubView;
    UIColor* originalBG = [stubView.backgroundColor copy];
    
    // when
    [sut view];
    [self simulateChangeOfModelComponent:ComponentTypeGain WithRed:2.0 Green:1 Blue:1];
    
    // then
    expect(sut.colorField.backgroundColor).toNot.equal(originalBG);
}

- (void)testBackgroundColorForLiftDoesNotChangeWhenInGainState {
    // given
    ColorSurfaceView* stubView = [[ColorSurfaceView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    sut.colorField = stubView;
    [sut view];
    UIColor* originalColor = [sut.colorField.backgroundColor copy];
    
    // when
    [self simulateChangeOfModelComponent:ComponentTypeLift WithRed:2.0 Green:1 Blue:1];
    
    // then
    expect(sut.colorField.backgroundColor).to.equal(originalColor);
}

#pragma mark Helper Methods

-(void)simulateTouchOn:(UIView*)surface withNumberOfFingers:(NSUInteger)fingers{
    UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    id grMock  = [OCMockObject partialMockForObject:gr];
    [[[grMock stub] andReturnValue: OCMOCK_VALUE((NSUInteger){fingers})] numberOfTouches];
    CGPoint velocityVektor = CGPointMake(20, 20);
    [[[grMock stub] andReturnValue: OCMOCK_VALUE(velocityVektor)] velocityInView:sut.colorField];
    [sut fingerMoved:grMock];
}

-(void)simulateChangeOfModelComponent:(ComponentType)comp WithRed:(float)red Green:(float)green Blue:(float)blue{
    RGBColor* newColor = [[RGBColor alloc]init];
    newColor.red = red;
    newColor.green = green;
    newColor.blue = blue;
    NSDictionary * infoDictionary = @{@"component": [NSNumber numberWithInteger:comp]};
    NSNotification* notification = [NSNotification notificationWithName:ColorDidChangeNotification
                                                                 object:newColor
                                                               userInfo:infoDictionary];
    [sut aColorModelHasChanged:notification];
}

-(ColorSurfaceView*)createMockSurfaceView{
    ColorSurfaceView* mock = [OCMockObject mockForClass:[ColorSurfaceView class]];
    return mock;
}
@end
