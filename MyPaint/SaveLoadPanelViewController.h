//
//  SaveLoadPanelViewController.h
//  MyPaint
//
//  Created by Melany on 12/31/15.
//  Copyright © 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopoverClassForFileName.h"
#import "Protocols.h"






@interface SaveLoadPanelViewController : UIViewController <PopoverClassForFileNameDelegate,DismissPopoverDelegate>

@property(weak, nonatomic) id  delegate;//protocol



@end



