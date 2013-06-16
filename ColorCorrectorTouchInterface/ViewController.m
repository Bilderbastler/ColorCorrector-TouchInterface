//
//  ViewController.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 24.05.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController{
    
}

- (void)addGestureRecognizrforNumberOfFingers:(int)numberOfFingers toView:(UIView *)controllField
{
    UIPanGestureRecognizer * gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(fingerMoved:)];
    gr.minimumNumberOfTouches = numberOfFingers;
    gr.maximumNumberOfTouches = numberOfFingers;
    [controllField addGestureRecognizer:gr];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addGestureRecognizrforNumberOfFingers:1 toView:self.colorField];
    [self addGestureRecognizrforNumberOfFingers:2 toView:self.colorField];
    [self addGestureRecognizrforNumberOfFingers:3 toView:self.colorField];
    
    [self addGestureRecognizrforNumberOfFingers:1 toView:self.luminanceField];
    [self addGestureRecognizrforNumberOfFingers:2 toView:self.luminanceField];
    [self addGestureRecognizrforNumberOfFingers:3 toView:self.luminanceField];
}

-(void)colorChanged:(NSNotificationCenter *)notification{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fingerMoved:(UIPanGestureRecognizer*)gr{
    CGPoint vector = [gr velocityInView:gr.view];
    [self.gain changeHueAndLuminance:vector];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
