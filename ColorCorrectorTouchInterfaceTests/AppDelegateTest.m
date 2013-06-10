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
#import "ViewController.h"

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
    AppDelegate *sut;
}
-(void)setUp{
    sut = [[AppDelegate alloc] init];
}

-(void)tearDown{
    sut = nil;
}


- (void)testApplicationAfterLaunch {    
    // when
    [sut application: nil didFinishLaunchingWithOptions:nil];
    
    // then
    expect(sut.viewController.lift).notTo.beNil();
    expect(sut.viewController.gamma).notTo.beNil();
    expect(sut.viewController.gain).notTo.beNil();
}



@end
