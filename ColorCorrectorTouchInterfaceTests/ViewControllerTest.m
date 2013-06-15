//
//  ColorCorrectorTouchInterface - ViewControllerTest.m
//  Copyright 2013 Franzi. All rights reserved.
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

// Uncomment the next two lines to use OCMockito for mock objects:
//#define MOCKITO_SHORTHAND
//#import <OCMockitoIOS/OCMockitoIOS.h>

#import <OCMock/OCMock.h>

@interface ViewControllerTest : SenTestCase
@end

@implementation ViewControllerTest{
    // test fixture ivars go here
    ViewController* sut;
}

-(void)setUp{
    sut = [[ViewController alloc] init];
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
    // when
    
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

- (void)testViewControllerCallsModelWhenColorInterfaceTouched {
    // given
    UIPanGestureRecognizer *gr = [[UIPanGestureRecognizer alloc] initWithTarget:nil action:nil];
    id grMock  = [OCMockObject partialMockForObject:gr];
    CGPoint velocityVektor = CGPointMake(20, 20);
    gr.maximumNumberOfTouches = 3; // gain
    [[[grMock stub] andReturnValue: OCMOCK_VALUE(velocityVektor)] velocityInView:sut.colorField];
    
    ColorComponentModel *colorComponent = [OCMockObject mockForClass: [ColorComponentModel class]];
    id colorMock = colorComponent;
    [[colorMock expect] changeHueAndLuminance:velocityVektor];
    sut.gain = colorComponent;
    
    // when
    [sut fingerMoved:gr];
    
    // then
    expect(gr.maximumNumberOfTouches).to.equal(3);
    expect(^{[colorMock verify];}).notTo.raiseAny();
    [colorMock verify];
    
    
}


@end
