//
//  ViewController.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 24.05.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController{
    NSUInteger _activeColorComponent;
    NSUInteger _activeLuminanceComponent;
    UIColor* _gammaBrightness;
    UIColor* _gainBrightness;
    UIColor* _liftBrightness;
    UIColor* _liftColor;
    UIColor* _gammaColor;
    UIColor* _gainColor;
}

@synthesize notificationCenter;
- (void)viewDidLoad{
    [super viewDidLoad];
    
    _activeColorComponent = ComponentTypeGain;
    _activeColorComponent = ComponentTypeGain;
    
    [self.notificationCenter addObserver:self selector:@selector(colorModelChanged:) name:ColorDidChangeNotification object:nil];
    
    [self setupGestureRecognizers];
    [self setupColorProperties];
}

- (void)setupGestureRecognizers{
    [self addGestureRecognizrforNumberOfFingers:1 toView:self.colorField];
    [self addGestureRecognizrforNumberOfFingers:2 toView:self.colorField];
    [self addGestureRecognizrforNumberOfFingers:3 toView:self.colorField];
    
    [self addGestureRecognizrforNumberOfFingers:1 toView:self.luminanceField];
    [self addGestureRecognizrforNumberOfFingers:2 toView:self.luminanceField];
    [self addGestureRecognizrforNumberOfFingers:3 toView:self.luminanceField];
}

- (void)addGestureRecognizrforNumberOfFingers:(int)numberOfFingers toView:(UIView *)controllField{
    UIPanGestureRecognizer * gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(fingerMoved:)];
    gr.minimumNumberOfTouches = numberOfFingers;
    gr.maximumNumberOfTouches = numberOfFingers;
    [controllField addGestureRecognizer:gr];
}

- (void)setupColorProperties {
    _gammaBrightness = self.luminanceField.backgroundColor;
    _gainBrightness = self.luminanceField.backgroundColor;
    _liftBrightness = self.luminanceField.backgroundColor;
    
    _liftColor = self.colorField.backgroundColor;
    _gammaColor = self.colorField.backgroundColor;
    _gainColor = self.colorField.backgroundColor;
}

-(void)colorModelChanged:(NSNotification *)notification{
    RGBColor* newColorValues = notification.object;
    NSInteger component = [[notification.userInfo objectForKey:@"component"] integerValue];
    UIColor* newColor = [self createColorFromColorValues:newColorValues];
    switch (component) {
        case ComponentTypeGain:
            _gainColor = newColor;
            break;
        case ComponentTypeGamma:
            _gammaColor = newColor;
            break;
        default:
        case ComponentTypeLift:
            _liftColor = newColor;
            break;
    }
    if (component == _activeColorComponent) {
        self.colorField.backgroundColor = newColor;
    }
}

-(UIColor*)createColorFromColorValues:(RGBColor*)colorValue{
    float red, green, blue, max;
    red = colorValue.red;
    green = colorValue.green;
    blue = colorValue.blue;
    max = MAX(red, MAX(green, blue));
    UIColor* newColor =[UIColor colorWithRed:red / max
                                       green:green / max
                                        blue:blue / max
                                       alpha:1.0];
    return newColor;
}

- (void)fingerMoved:(UIPanGestureRecognizer*)gr{
    CGPoint vector = [gr velocityInView:gr.view];
    switch (gr.numberOfTouches) {
        case 1:
            [self.gain changeHueAndSaturation:vector];
            break;
        case 2:
            [self.gamma changeHueAndSaturation:vector];
            break;
        case 3:
            [self.lift changeHueAndSaturation:vector];
            break;
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc{
    [self.notificationCenter removeObserver:self];
}


@end
