//
//  ColorCorrectorTouchInterface - ColorSurfaceViewTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "ColorSurfaceView.h"

    // Collaborators
#import <QuartzCore/QuartzCore.h>
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
    ColorSurfaceView* sut;
}


-(void)setUp{
    sut = [[ColorSurfaceView alloc]initWithCoder:nil];
}

- (void)testObjectCanBeCreated {    
    // then
    expect(sut).notTo.beNil();
}

- (void)testHasArrows {        
    expect(sut.fourWayArrows).notTo.beNil();
}

- (void)testArrowsAreVisible {
    // given
    NSArray* layers = sut.layer.sublayers;
    id arrowsLayer = sut.fourWayArrows;
    // then
    expect(layers).to.contain(arrowsLayer);
}

@end
