//
//  FigureViewController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "FigureViewController.h"

@interface FigureViewController ()


@property (assign, nonatomic) BOOL scrollViewPressed;


@end


@implementation FigureViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)backgroundButtonSellected:(UIButton *)sender
{
    if(self.scrollViewPressed == 0)
    {
        self.lineButton.enabled = NO;
        self.triangleButton.enabled = NO;
        self.circleButton.enabled = NO;
        self.squireButton.enabled = NO;
        self.trapezeButton.enabled = NO;
        self.polygonButton.enabled = NO;
        self.pencilButton.enabled = NO;
        self.imageReview.enabled = NO;
        self.scrollViewPressed = 1;
    }
    else
    {
        self.lineButton.enabled = YES;
        self.triangleButton.enabled = YES;
        self.circleButton.enabled = YES;
        self.squireButton.enabled = YES;
        self.trapezeButton.enabled = YES;
        self.polygonButton.enabled = YES;
        self.imageReview.enabled = YES;
        self.pencilButton.enabled = YES;
        self.scrollViewPressed = 0;
    }
    
    [self didBackgroundSelect:300.f];
    [self.delegate didDisableGestures];
}

- (IBAction)selectFigurePressed:(UIButton *)sender
{

    [self.delegate didSelectFigure:sender.tag];

}


- (IBAction)imageButtonPressed:(UIButton *)sender
{
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.delegate = self;
    
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    [self presentViewController:self.picker animated:NO completion:nil];
    self.tag = sender.tag;
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.delegate didSelectImage:image :self.tag];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) didBackgroundSelect:(CGFloat)height
{
    [self.delegateToBoard didBackgroundSelect: height];
    
}










@end
