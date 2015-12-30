//
//  ColorPanelController.h
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "SettingsForColor.h"





@interface ColorPanelController : UIViewController <SettingsForColorDelegate>




@property (nonatomic, weak) id delegate;
@property(nonatomic, strong) UIColor* color;
@property(nonatomic, assign) CGFloat brush;
@property(nonatomic, assign) CGFloat opacity;

@end

