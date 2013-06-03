//
//  ViewController.h
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 24.05.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorComponentModel.h"

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *colorField;
@property (weak, nonatomic) IBOutlet UIView *luminanceField;

@property (strong, nonatomic) ColorComponentModel * lift;
@property (strong, nonatomic) ColorComponentModel * gamma;
@property (strong, nonatomic) ColorComponentModel * gain;

- (void)fingerMoved:(UIPanGestureRecognizer*)gr;

@end
