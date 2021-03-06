//
//  ColorPanelController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "ColorPanelController.h"


@interface ColorPanelController()

@property (nonatomic, assign) CGFloat red;
@property (nonatomic, assign) CGFloat green;
@property (nonatomic, assign) CGFloat blue;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) BOOL mode;
@property (strong, nonatomic) IBOutlet UIButton *settings;
@property (nonatomic, assign) NSInteger selectedButtonColor;
@property (nonatomic, assign) BOOL shouldDelete;
@property (nonatomic, assign) NSInteger alreadySelectedColor;
@property (strong, nonatomic) UIPopoverController* popover;


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
    if(self.alreadySelectedColor != PressedButton.tag)
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

- (IBAction)pressedDelete:(id)sender
{
    self.shouldDelete = YES;
    [self.delegate didSelectDelete];
}
- (IBAction)lastDeletePressed:(id)sender
{
    self.shouldDelete = YES;
    [self.delegate didSelectlastDelete];
    
}
- (IBAction)clearAllPressed:(id)sender
{
    self.shouldDelete = YES;
    [self.delegate didSelectClearAllDelete];
    

    
}




- (IBAction)CorrectMode:(id)sender
{
    if (self.mode == NO)
    {
        [self.delegateBoard didBlockButtonsOnFigurePanel:self.mode];
        self.mode = YES;
    }
    else if(self.mode == YES)
    {
        [self.delegateBoard didBlockButtonsOnFigurePanel:self.mode];
        self.mode = NO;
    }
    [self.delegate didSelectMode:self.mode];
}


#pragma mark -forBeauty

- (void)selectButton:(NSInteger)index
{
    UIView *button = [self.view viewWithTag:index];
    self.alreadySelectedColor = index;
    button.transform = CGAffineTransformMakeScale(1.2, 1.2);
}

- (void)deselectButton:(NSInteger)index
{
    UIView *button = [self.view viewWithTag:index];
    button.transform = CGAffineTransformIdentity;
}

@end
