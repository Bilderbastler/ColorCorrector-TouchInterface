//
//  ColorCorrectorTouchInterface - ViewFactoryTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "ViewFactory.h"
#import "LuminanceSurfaceView.h"
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


@interface ViewFactoryTest : SenTestCase
@end

@implementation ViewFactoryTest
{
    // test fixture ivars go here
    ViewFactory* sut;
}

-(void)setUp{
    sut = [[ViewFactory alloc]init];
}

- (void)testCreatesLuminanceSurface {
    // when
    id product = [sut createLuminanceSurface];
    // then
    expect(product).to.beKindOf([LuminanceSurfaceView class]);
}

- (void)testCreatesColorSurface {
    // when
    id product = [sut createColorSurface];
    // then
    expect(product).to.beKindOf([ColorSurfaceView class]);
}

@end
