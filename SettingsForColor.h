//
//  SettongsForColor.h
//  MyPaint
//
//  Created by Melany Gulianovych on 12/24/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ColorPanelController.h"

@protocol SettingsForColorDelegate <NSObject>

- (void)closeSettings:(id)sender;

@end



@interface SettingsForColor : UIViewController

@property (nonatomic, weak) id <SettingsForColorDelegate> delegate;
@property (strong, nonatomic) IBOutlet UISlider *brushControl;
@property (strong, nonatomic) IBOutlet UISlider *opacityControl;
@property (strong, nonatomic) IBOutlet UIImageView *brushPreview;
@property (strong, nonatomic) IBOutlet UIImageView *opacityPreview;
@property (strong, nonatomic) IBOutlet UILabel *brushValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *opacityValueLabel;
@property (nonatomic, assign) CGFloat brush;
@property (nonatomic, assign) CGFloat opacity;
@property (strong, nonatomic) IBOutlet UISlider *redControl;
@property (strong, nonatomic) IBOutlet UISlider *greenControl;
@property (strong, nonatomic) IBOutlet UISlider *blueControl;
@property (strong, nonatomic) IBOutlet UILabel *redLabel;
@property (strong, nonatomic) IBOutlet UILabel *greenLabel;
@property (strong, nonatomic) IBOutlet UILabel *blueLabel;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;

- (IBAction)closeSettings:(id)sender;


@end
