//
//  SaveLoadPanelViewController.h
//  MyPaint
//
//  Created by Melany on 12/31/15.
//  Copyright © 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"


@protocol SaveLoadDelegate;



@interface SaveLoadPanelViewController : UIViewController

@property(weak, nonatomic) id  delegate;//protocol

//@property (weak, nonatomic) IBOutlet UIButton *imageReview;

//@property (strong, nonatomic) UIImagePickerController* picker;
//@property (nonatomic) NSInteger tag;


@end



