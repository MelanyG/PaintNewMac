//
//  ViewController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/17/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "Board.h"
//#import "Drawer.h"
#import "FigureViewController.h"
#import "ColorPanelController.h"
#import "SaveLoadPanelViewController.h"
#import "PopoverClassForFileName.h"
#import "CanvasViewController.h"
#import "GalleryOfImages.h"
#import "Protocols.h"


@interface Board ()<FigureBoardDelegate>




@property(nonatomic, strong) FigureViewController* Figure;
@property(nonatomic, strong) ColorPanelController* Colors;
@property(nonatomic, strong) CanvasViewController* Canvas;
@property(nonatomic, strong) SaveLoadPanelViewController* SaveLoad;
@property(nonatomic, strong) PopoverClassForFileName* Pop;
@property(nonatomic, strong) GalleryOfImages* Gallery;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *galleryHight;
@property(nonatomic, assign) BOOL scrollOnScreen;



@end

//Note: The error “this class is not key value coding-compliant for the key XXX” usually occurs when loading a nib that refers to a property that doesn’t actually exist. This usually happens when you remove an outlet property from your code but not from the connections in the nib.

@implementation Board

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CanvasStory"])
    {
        self.Canvas = (CanvasViewController *)[segue destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"FigureSegue"])
    {
        self.Figure = (FigureViewController *)[segue destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"ColorSegue"])
    {
        self.Colors = (ColorPanelController *)[segue destinationViewController];
    }
    else if ([segue.identifier isEqualToString:@"SaveLoadSegue"])
    {
    self.SaveLoad = (SaveLoadPanelViewController *)[segue destinationViewController];
    }
//    else if ([segue.identifier isEqualToString:@"GallerySegue"])
//    {
//        self.Gallery = (GalleryOfImages *)[segue destinationViewController];
//    }

    
    self.Figure.delegate = self.Canvas;
    self.Figure.delegateToBoard = self;
    self.Colors.delegate = self.Canvas;
    self.SaveLoad.delegate = self.Canvas;
   // self.Gallery.delegate = self.Canvas;
 
    
}

-(void) didBackgroundSelect:(CGFloat)height
{
    if(self.scrollOnScreen == 0)
    {
        self.scrollOnScreen = 1;
        self.galleryHight.constant = height;
        
        [UIView animateWithDuration:0.5f animations:^{
            [self.view layoutIfNeeded];
            [self.view bringSubviewToFront:self.Gallery.scrollView];
        }];
    }
    else
    {
        self.scrollOnScreen = 0;
        self.galleryHight.constant = 0;
        [UIView animateWithDuration:0.5f animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
