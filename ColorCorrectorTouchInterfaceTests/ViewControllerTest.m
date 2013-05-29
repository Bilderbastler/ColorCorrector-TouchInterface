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
#define MOCKITO_SHORTHAND
#import <OCMockitoIOS/OCMockitoIOS.h>


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
}


- (void)testluminanceFieldShouldBeConnected {
    // given
    [sut view];
    
    // then
    expect([sut luminanceField]).notTo.beNil();
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

@end