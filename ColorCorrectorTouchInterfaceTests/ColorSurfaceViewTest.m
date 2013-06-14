//
//  ColorCorrectorTouchInterface - ColorSurfaceViewTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "ColorSurfaceView.h"

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

// Uncomment the next two lines to use OCMockito for mock objects:
//#define MOCKITO_SHORTHAND
//#import <OCMockitoIOS/OCMockitoIOS.h>


@interface ColorSurfaceViewTest : SenTestCase
@end

@implementation ColorSurfaceViewTest
{
    // test fixture ivars go here
}

- (void)testObjectCanBeCreated {    
    // when
    ColorSurfaceView* sut = [[ColorSurfaceView alloc]init];
    // then
    expect(sut).notTo.beNil();
}

@end
