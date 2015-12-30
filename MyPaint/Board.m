//
//  ViewController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/17/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "Board.h"
#import "Drawer.h"


@interface Board ()

@property(nonatomic, strong) FigureViewController* Figure;
@property(nonatomic, strong) ColorPanelController* Colors;
@property(nonatomic, strong) CanvasViewController* Canvas;

@end

//Note: The error “this class is not key value coding-compliant for the key XXX” usually occurs when loading a nib that refers to a property that doesn’t actually exist. This usually happens when you remove an outlet property from your code but not from the connections in the nib.

@implementation Board

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CanvasStory"])
    {
        self.Canvas = (CanvasViewController *)[segue destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"FigureSegue"])
    {
        self.Figure = (FigureViewController *)[segue destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"ColorSegue"])
    {
        self.Colors = (ColorPanelController *)[segue destinationViewController];
    }
    
    self.Figure.delegate = self.Canvas;
    self.Colors.delegate = self.Canvas;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
