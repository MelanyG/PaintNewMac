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

//@protocol PopoverClassForFileNameDelegate;



@interface PopoverClassForFileName : UIViewController

//@property (weak, nonatomic) id  delegate;
@property (nonatomic, assign) id <PopoverClassForFileNameDelegate, DismissPopoverDelegate> delegate;
//@property (nonatomic, assign) id <DismissPopoverDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *IntroductionLabel;
@property (weak, nonatomic) IBOutlet UITextField *fileNameField;
@property (weak, nonatomic) IBOutlet UIButton *doneButtonPressed;
- (IBAction)doneButtonPressed:(UIButton *)sender;


@end
