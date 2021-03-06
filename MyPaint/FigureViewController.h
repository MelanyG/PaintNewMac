//
//  FigureViewController.h
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Protocols.h"
#import "GalleryOfImages.h"



@interface FigureViewController: UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property(weak, nonatomic) id <FigureDelegate> delegate;
@property(weak, nonatomic) id <FigureBoardDelegate> delegateToBoard;

@property (weak, nonatomic) IBOutlet UIButton *imageReview;


@property (strong, nonatomic) UIImagePickerController* picker;
@property (nonatomic) NSInteger tag;
@property (strong, nonatomic) IBOutlet UIButton *backgroundSelected;
@property(nonatomic, strong) GalleryOfImages * Gallery;

@property (weak, nonatomic) IBOutlet UIButton *lineButton;
@property (weak, nonatomic) IBOutlet UIButton *triangleButton;
@property (weak, nonatomic) IBOutlet UIButton *circleButton;
@property (weak, nonatomic) IBOutlet UIButton *squireButton;
@property (weak, nonatomic) IBOutlet UIButton *trapezeButton;
@property (weak, nonatomic) IBOutlet UIButton *polygonButton;
@property (weak, nonatomic) IBOutlet UIButton *pencilButton;


@end







