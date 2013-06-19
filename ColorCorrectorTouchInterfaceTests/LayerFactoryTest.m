//
//  ColorCorrectorTouchInterface - ViewFactoryTest.m
//
//  Created by: Franzi
//

    // Class under test
#import "LayerFactory.h"
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


@interface LayerFactoryTest : SenTestCase
@end

@implementation LayerFactoryTest
{
    // test fixture ivars go here
    LayerFactory* sut;
    CALayer* product;
}

-(void)setUp{
    sut = [[LayerFactory alloc]init];
}

- (void)testTwoDirectionArrow {
    // when
    product = [sut createTwoDirectionArrow];
    // then
    expect(product).to.beKindOf([CALayer class]);
}

- (void)testTwoArrowsHaveFourLayers {
    // when
    product = [sut createTwoDirectionArrow];
    // then
    expect(product.sublayers).to.haveCountOf(2);
}

- (void)testCreatesFourArrowLayer {
    // given
    
    // when
    product = [sut createFourDirectionArrows];
    // then
    expect(product).to.beKindOf([CALayer class]);
}

@end
