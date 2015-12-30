//
//  ColorPanelController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "ColorPanelController.h"

@protocol SettingsForColorDelegate;

@interface ColorPanelController()

@property (nonatomic, assign) CGFloat red;
@property (nonatomic, assign) CGFloat green;
@property (nonatomic, assign) CGFloat blue;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) NSInteger mode;
@property (strong, nonatomic) IBOutlet UIButton *settings;
@property (nonatomic, assign) NSInteger selectedButtonColor;
@property (nonatomic, assign) BOOL shouldDelete;

@end


@implementation ColorPanelController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    SettingsForColor * settingsVC = (SettingsForColor *)segue.destinationViewController;
    settingsVC.delegate = self;
    settingsVC.brush = self.brush;
    settingsVC.opacity = self.opacity;
    settingsVC.red = self.red;
    settingsVC.green = self.green;
    settingsVC.blue = self.blue;
    
}

#pragma mark - SettingsForColorDelegate methods

- (void)closeSettings:(id)sender
{
    
    self.brush = ((SettingsForColor*)sender).brush;
    self.opacity = ((SettingsForColor*)sender).opacity;
    self.red = ((SettingsForColor*)sender).red;
    self.green = ((SettingsForColor*)sender).green;
    self.blue = ((SettingsForColor*)sender).blue;
    [self dismissViewControllerAnimated:YES completion:nil];
    self.color= [UIColor colorWithRed:(self.red)
                                green:(self.green)
                                 blue:(self.blue)
                                alpha:self.opacity] ;
    
    [self.delegate didSelectSettings:self];
}



- (IBAction)ColorPressed:(id)sender
{
    UIButton * PressedButton = (UIButton*)sender;
    
    [self deselectButton:self.selectedButtonColor];
    [self selectButton:PressedButton.tag];
    self.selectedButtonColor = PressedButton.tag;
    
    switch(PressedButton.tag)
    {
        case 10:
            self.red = 0.0/255.0;
            self.green = 0.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 1:
            self.red = 105.0/255.0;
            self.green = 105.0/255.0;
            self.blue = 105.0/255.0;
            break;
        case 2:
            self.red = 255.0/255.0;
            self.green = 0.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 3:
            self.red = 0.0/255.0;
            self.green = 0.0/255.0;
            self.blue = 255.0/255.0;
            break;
        case 4:
            self.red = 102.0/255.0;
            self.green = 204.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 5:
            self.red = 102.0/255.0;
            self.green = 255.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 6:
            self.red = 51.0/255.0;
            self.green = 204.0/255.0;
            self.blue = 255.0/255.0;
            break;
        case 7:
            self.red = 160.0/255.0;
            self.green = 82.0/255.0;
            self.blue = 45.0/255.0;
            break;
        case 8:
            self.red = 255.0/255.0;
            self.green = 102.0/255.0;
            self.blue = 0.0/255.0;
            break;
        case 9:
            self.red = 255.0/255.0;
            self.green = 255.0/255.0;
            self.blue = 0.0/255.0;
            break;
    }
    self.color= [UIColor colorWithRed:(self.red)
                                green:(self.green)
                                 blue:(self.blue)
                                alpha:1] ;
    
    [self.delegate didSelectColor:self.color];
   
}
- (IBAction)WidthSelected:(id)sender
{
    self.brush=5;
    [self.delegate didSelectWidth:self.brush];
}

- (IBAction)pressedDelete:(id)sender
{
    self.shouldDelete = YES;
    [self.delegate didSelectDelete];
}


- (IBAction)CorrectMode:(id)sender
{
    if (self.mode == 0)
    {
        self.mode++;
    }
    else if(self.mode == 1)
    {
        self.mode = 0;
    }
    [self.delegate didSelectMode:self.mode];
}


#pragma mark -forBeauty

- (void)selectButton:(NSInteger)index
{
    UIView *button = [self.view viewWithTag:index];
    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
}

- (void)deselectButton:(NSInteger)index
{
    UIView *button = [self.view viewWithTag:index];
    button.transform = CGAffineTransformIdentity;
}

@end
