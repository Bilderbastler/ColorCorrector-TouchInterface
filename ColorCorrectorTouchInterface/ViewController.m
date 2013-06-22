//
//  ViewController.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 24.05.13.
//
//  This ViewController translates touch events to the model and
//  translates changes in the three component models to the view.
//  It stores the background colors of both the luminance and color
//  widget for their three states (lift, gamma and gain)



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
    NSNotificationCenter* _notificationCenter;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil notificationCenter:(NSNotificationCenter*)notificationCenter{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _notificationCenter = notificationCenter;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];    
    _activeColorComponent = ComponentTypeGain;
    _activeLuminanceComponent = ComponentTypeGain;    
    [_notificationCenter addObserver:self selector:@selector(aColorModelHasChanged:) name:ColorDidChangeNotification object:nil];
    [self setupGestureRecognizers];
    [self setupColorProperties];
}

- (void)addGestureRecognizrforNumberOfFingers:(int)numberOfFingers toView:(UIView *)controllField{
    UIPanGestureRecognizer * gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(fingerMoved:)];
    gr.minimumNumberOfTouches = numberOfFingers;
    gr.maximumNumberOfTouches = numberOfFingers;
    [controllField addGestureRecognizer:gr];
}

- (void)setupGestureRecognizers{
    for (int i = 1; i <= 3; i++) {
        [self addGestureRecognizrforNumberOfFingers:i toView:self.colorField];
        [self addGestureRecognizrforNumberOfFingers:i toView:self.luminanceField];
    }
}

- (void)setupColorProperties {
    _gammaBrightness = self.luminanceField.backgroundColor;
    _gainBrightness = [self.luminanceField.backgroundColor copy];
    _liftBrightness = [self.luminanceField.backgroundColor copy];
    
    _liftColor = self.colorField.backgroundColor;
    _gammaColor = [self.colorField.backgroundColor copy];
    _gainColor = [self.colorField.backgroundColor copy];
}

-(void)aColorModelHasChanged:(NSNotification *)notification{
    RGBColor* newColorValues = notification.object;
    NSInteger component = [[notification.userInfo objectForKey:@"component"] integerValue];
    UIColor* newColor = [newColorValues uiColorFromRGB];
    [self updateInterfaceColor:newColor component:component];
}

- (void)updateInterfaceColor:(UIColor *)newColor component:(ComponentType)component {
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

- (void)fingerMoved:(UIPanGestureRecognizer*)gr{
    CGPoint vector = [gr velocityInView:gr.view];
    NSUInteger numberOfTouches = gr.numberOfTouches;
    if (gr.view == self.colorField) {
        [self touch:vector onColorWidgetWithFingers:numberOfTouches];
    }else if (gr.view == self.luminanceField){
        [self touch:vector onLuminanceWidgetWithFingers:numberOfTouches];
    }
}

- (void)touch:(CGPoint)vector onColorWidgetWithFingers:(NSUInteger)numberOfTouches {
    switch (numberOfTouches) {
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

- (void)touch:(CGPoint)vector onLuminanceWidgetWithFingers:(NSUInteger)numberOfTouches {
    switch (numberOfTouches) {
        case 1:
            [self.gain changeLuminance:vector.y];
            break;
        case 2:
            [self.gamma changeLuminance:vector.y];
            break;
        case 3:
            [self.lift changeLuminance:vector.y];
            break;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc{
    [_notificationCenter removeObserver:self];
}


@end
