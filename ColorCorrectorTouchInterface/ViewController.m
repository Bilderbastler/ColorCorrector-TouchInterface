//
//  ViewController.m
//  ColorCorrectorTouchInterface
//
//  Created by Franzi on 24.05.13.
//  Copyright (c) 2013 Franzi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    
}

- (void)addGestureRecognizrWithHandlerMethod:(SEL)method ForNumberOfFingers:(int)numberOfFingers toView:(UIView *)controllField
{
    UIPanGestureRecognizer * gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:method];
    gr.minimumNumberOfTouches = numberOfFingers;
    gr.maximumNumberOfTouches = numberOfFingers;
    [controllField addGestureRecognizer:gr];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self addGestureRecognizrWithHandlerMethod:@selector(oneFingerMoved:) ForNumberOfFingers:1 toView:self.colorField];
    [self addGestureRecognizrWithHandlerMethod:@selector(twoFingersMoved:) ForNumberOfFingers:2 toView:self.colorField];
    [self addGestureRecognizrWithHandlerMethod:@selector(twoFingersMoved:) ForNumberOfFingers:3 toView:self.colorField];
    
    [self addGestureRecognizrWithHandlerMethod:@selector(oneFingerMoved:) ForNumberOfFingers:1 toView:self.luminanceField];
    [self addGestureRecognizrWithHandlerMethod:@selector(twoFingersMoved:) ForNumberOfFingers:2 toView:self.luminanceField];
    [self addGestureRecognizrWithHandlerMethod:@selector(twoFingersMoved:) ForNumberOfFingers:3 toView:self.luminanceField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)oneFingerMoved:(UIPanGestureRecognizer*)gr{
    NSLog(@"One Finger moved");
}

- (void)twoFingersMoved:(UIPanGestureRecognizer*)gr{
    NSLog(@"Two Fingers moved");
}

- (void)threeFingersMoved:(UIPanGestureRecognizer*)gr{
    NSLog(@"Three Fingers moved");
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
