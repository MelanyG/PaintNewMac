//
//  SettongsForColor.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/24/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "SettingsForColor.h"


@implementation SettingsForColor

- (IBAction)closeSettings:(id)sender
{
    [self.delegate closeSettings:self];
}

#pragma mark - Class methods

- (IBAction)sliderChanged:(id)sender
{
    
    UISlider * changedSlider = (UISlider*)sender;
    
    if(changedSlider == self.brushControl)
    {
        
        self.brush = self.brushControl.value;
        self.brushValueLabel.text = [NSString stringWithFormat:@"%.1f", self.brush];
        
    }
    else if(changedSlider == self.opacityControl)
    {
        
        self.opacity = self.opacityControl.value;
        self.opacityValueLabel.text = [NSString stringWithFormat:@"%.1f", self.opacity];
        
    }
    else if(changedSlider == self.redControl)
    {
        
        self.red = self.redControl.value/255.0;
        self.redLabel.text = [NSString stringWithFormat:@"Red: %d", (int)self.redControl.value];
        
    }
    else if(changedSlider == self.greenControl)
    {
        
        self.green = self.greenControl.value/255.0;
        self.greenLabel.text = [NSString stringWithFormat:@"Green: %d", (int)self.greenControl.value];
    }
    else if (changedSlider == self.blueControl)
    {
        
        self.blue = self.blueControl.value/255.0;
        self.blueLabel.text = [NSString stringWithFormat:@"Blue: %d", (int)self.blueControl.value];
        
    }
    
    UIGraphicsBeginImageContext(self.brushPreview.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, 1.0);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), 45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.brushPreview.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContext(self.opacityPreview.frame.size);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(),self.brush);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), self.red, self.green, self.blue, self.opacity);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(),45, 45);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(),45, 45);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.opacityPreview.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // ensure the values displayed are the current values
    
    self.red = 0.5;
    int redIntValue = self.red * 255.0;
    self.redControl.value = redIntValue;
    [self sliderChanged:self.redControl];
    
    self.green = 0.5;
    int greenIntValue = self.green * 255.0;
    self.greenControl.value = greenIntValue;
    [self sliderChanged:self.greenControl];
    
    self.blue= 0.5;
    int blueIntValue = self.blue * 255.0;
    self.blueControl.value = blueIntValue;
    [self sliderChanged:self.blueControl];
    
    self.brushControl.value = self.brush=5;
    [self sliderChanged:self.brushControl];
    
    self.opacityControl.value = self.opacity=1;
    [self sliderChanged:self.opacityControl];
    
}

@end
