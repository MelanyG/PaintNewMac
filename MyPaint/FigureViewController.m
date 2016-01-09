//
//  FigureViewController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "FigureViewController.h"

@interface FigureViewController ()



@end


@implementation FigureViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)backgroundButtonSellected:(UIButton *)sender
{
    [self didBackgroundSelect:300.f];
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
