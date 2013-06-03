//
//  ColorCorrectorTouchInterface - AppDelegateTest.m
//  Copyright 2013 Franzi. All rights reserved.
//
//  Created by: Franzi
//

    // Class under test
#import "AppDelegate.h"

    // Collaborators
#import "ColorComponentModel.h"

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


@interface AppDelegateTest : SenTestCase
@end

@implementation AppDelegateTest
{
    // test fixture ivars go here
    AppDelegate *appDelegate;
}
-(void)setUp{
    appDelegate = [[AppDelegate alloc] init];
}


- (void)testApplicationAfterLaunch {
    // given
    
    // when
    
    // then
    expect(appDelegate.lift).notTo.beNil();
    expect(appDelegate.gamma).notTo.beNil();
    expect(appDelegate.gain).notTo.beNil();
    
    expect(appDelegate.lift).to.beInstanceOf([ColorComponentModel class]);
    
}

@end
