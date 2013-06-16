//
//  ViewController.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 24.05.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorComponentModel.h"
#import "LuminanceSurfaceView.h"
#import "ColorSurfaceView.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet ColorSurfaceView *colorField;
@property (weak, nonatomic) IBOutlet LuminanceSurfaceView *luminanceField;
@property (strong, nonatomic) ColorComponentModel * lift;
@property (strong, nonatomic) ColorComponentModel * gamma;
@property (strong, nonatomic) ColorComponentModel * gain;

- (void)fingerMoved:(UIPanGestureRecognizer*)gr;
- (void)colorChanged:(NSNotificationCenter*)notification;
@end
