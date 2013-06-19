//
//  ColorCorrectorTouchInterface - LuminanceSurfaceViewTest.m
//
//  Created by: Franzi
//

    // Class under test
#import "LuminanceSurfaceView.h"

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


@interface LuminanceSurfaceViewTest : SenTestCase
@end

@implementation LuminanceSurfaceViewTest
{
    // test fixture ivars go here
}

- (void)testObjectCanBeCreated {    
    // when
    LuminanceSurfaceView* sut = [[LuminanceSurfaceView alloc]init];
    // then
    expect(sut).notTo.beNil();
}

@end
