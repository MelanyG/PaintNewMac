//
//  FigureViewController.h
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"



@protocol FigureDelegate;

@interface FigureViewController: UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(weak, nonatomic) id  delegate;//protocol

@property (weak, nonatomic) IBOutlet UIButton *imageReview;

@property (strong, nonatomic) UIImagePickerController* picker;
@property (nonatomic) NSInteger tag;


@end







