//
//  ViewController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/17/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "Board.h"

#import "FigureViewController.h"
#import "ColorPanelController.h"
#import "SaveLoadPanelViewController.h"
#import "PopoverClassForFileName.h"
#import "CanvasViewController.h"
#import "GalleryOfImages.h"
#import "Protocols.h"


@interface Board () <BoardDelegate, FigureBoardDelegate, UIGestureRecognizerDelegate>




@property(nonatomic, strong) FigureViewController* Figure;
@property(nonatomic, strong) ColorPanelController* Colors;
@property(nonatomic, strong) CanvasViewController* Canvas;
@property(nonatomic, strong) SaveLoadPanelViewController* SaveLoad;
@property(nonatomic, strong) PopoverClassForFileName* Pop;
@property(nonatomic, strong) GalleryOfImages* Gallery;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *galleryHight;
@property(nonatomic, assign) BOOL scrollOnScreen;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) UIPanGestureRecognizer* panGesture;

@end

//Note: The error “this class is not key value coding-compliant for the key XXX” usually occurs when loading a nib that refers to a property that doesn’t actually exist. This usually happens when you remove an outlet property from your code but not from the connections in the nib.

@implementation Board

- (void)viewDidLoad
{
    [super viewDidLoad];
    
        self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                               action:@selector(handlePan:)];
        [self.view addGestureRecognizer:self.panGesture];
    self.panGesture.enabled = NO;

    
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
            self.SaveLoad.delegate = self.Canvas;
    }

  
    self.Figure.delegate = self.Canvas;
    self.Figure.delegateToBoard = self;
    self.Colors.delegate = self.Canvas;
    self.Colors.delegateBoard = self;
}


-(void) didBlockButtonsOnFigurePanel: (BOOL) mode
{
    if (mode == NO)
    {
        self.Figure.lineButton.enabled = NO;
        self.Figure.triangleButton.enabled = NO;
        self.Figure.circleButton.enabled = NO;
        self.Figure.squireButton.enabled = NO;
        self.Figure.trapezeButton.enabled = NO;
        self.Figure.polygonButton.enabled = NO;
        self.Figure.pencilButton.enabled = NO;
        self.Figure.imageReview.enabled = NO;
   
    }
    if (mode == YES)
    {
        self.Figure.lineButton.enabled = YES;
        self.Figure.triangleButton.enabled = YES;
        self.Figure.circleButton.enabled = YES;
        self.Figure.squireButton.enabled = YES;
        self.Figure.trapezeButton.enabled = YES;
        self.Figure.polygonButton.enabled = YES;
        self.Figure.pencilButton.enabled = YES;
        self.Figure.imageReview.enabled = YES;

    }
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
            self.panGesture.enabled = YES;
        }];
    }
    else
    {
        self.scrollOnScreen = 0;
        self.galleryHight.constant = 0;
        self.panGesture.enabled = NO;
        [UIView animateWithDuration:0.5f animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void) didSelectImage: (UIPanGestureRecognizer*) panGesture
{
    
//    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(sender.frame.origin.x, sender.frame.origin.y, sender.frame.size.width, sender.frame.size.height)];
//    //UIWindowContentModeScaleToFill
//    CGSize newsize = CGSizeMake(sender.frame.size.width, sender.frame.size.height);
//    UIGraphicsBeginImageContextWithOptions(newsize, NO, 0.0);
//    [sender.currentBackgroundImage drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIColor *background = [[UIColor alloc] initWithPatternImage:newImage];
//    window.backgroundColor = background;
//    window.windowLevel = UIWindowLevelAlert;
//    self.window = window;
//    self.window.hidden = NO;
//    
//    NSLog(@"ButtonCoordinates %@", NSStringFromCGRect(sender.frame));
    
    
}

-(void) handlePan: (UIPanGestureRecognizer*) panGesture
{
    NSLog(@"BoardpanGesture" );
    
    if(self.scrollOnScreen == 1)
    {
       //CGPoint location = [panGesture locationInView:self.view];
        CGPoint location1 = [panGesture locationInView:self.Gallery.scrollView];
        UIView* currentView = [self.Gallery.scrollView hitTest:location1 withEvent:nil];
        if([currentView isKindOfClass:[UIImageView class]])
        { [self didSelectImage:panGesture];
            CGPoint translation = [panGesture translationInView:self.view];
            NSLog(@"translation,%@", NSStringFromCGPoint(translation));
            currentView.center = CGPointMake(currentView.center.x+translation.x,
                                             currentView.center.y+translation.y);
            
            [panGesture setTranslation:CGPointZero inView:self.view];
            
            panGesture.delegate = self;
        }
    }
    else
        return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
