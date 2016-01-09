//
//  PopoverClassForFileName.h
//  MyPaint
//
//  Created by Melany on 1/4/16.
//  Copyright © 2016 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveLoadPanelViewController.h"
#import "Protocols.h"





@interface PopoverClassForFileName : UIViewController

@property (nonatomic, assign) id <PopoverClassForFileNameDelegate, DismissPopoverDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *IntroductionLabel;
@property (weak, nonatomic) IBOutlet UITextField *fileNameField;
@property (weak, nonatomic) IBOutlet UIButton *doneButtonPressed;

- (IBAction)doneButtonPressed:(UIButton *)sender;


@end
