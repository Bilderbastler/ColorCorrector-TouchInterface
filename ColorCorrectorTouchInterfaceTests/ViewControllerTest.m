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
#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>

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
    assertThat(sut.colorField, is(notNilValue()));
}


- (void)testluminanceFieldShouldBeConnected {
    // given
    [sut view];
    
    // then
    assertThat([sut luminanceField], is(notNilValue()));
}


- (void)testColorFieldHasGestureRecognizers {
    // given
    [sut view];
    // when
    
    // then
    assertThat(sut.colorField.gestureRecognizers, hasCountOf(3));
    
}

- (void)testLuminanceFieldHasGestureRecognizers {
    // given
    [sut view];
    // when
    
    // then
    assertThat(sut.luminanceField.gestureRecognizers, hasCountOf(3));
    
}

@end
