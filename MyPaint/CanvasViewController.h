//
//  CanvasViewController.h
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Drawer.h"
//#import "Board.h"
#import "Protocols.h"
#import "ColorPanelController.h"
#import "Line.h"

@interface CanvasViewController : UIViewController <FigureDelegate, ColorDelegate, UIGestureRecognizerDelegate, SaveLoadDelegate>



@end
