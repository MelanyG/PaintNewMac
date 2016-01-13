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


@interface Board ()<FigureBoardDelegate, GalleryDelegate, UIGestureRecognizerDelegate>




@property(nonatomic, strong) FigureViewController* Figure;
@property(nonatomic, strong) ColorPanelController* Colors;
@property(nonatomic, strong) CanvasViewController* Canvas;
@property(nonatomic, strong) SaveLoadPanelViewController* SaveLoad;
@property(nonatomic, strong) PopoverClassForFileName* Pop;
@property(nonatomic, strong) GalleryOfImages* Gallery;
@property(weak, nonatomic) IBOutlet NSLayoutConstraint *galleryHight;
@property(nonatomic, assign) BOOL scrollOnScreen;
@property (strong, nonatomic) UIWindow *window;
//@property(nonatomic, strong) UIPanGestureRecognizer* panGesture;

@end

//Note: The error “this class is not key value coding-compliant for the key XXX” usually occurs when loading a nib that refers to a property that doesn’t actually exist. This usually happens when you remove an outlet property from your code but not from the connections in the nib.

@implementation Board

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//        self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self
//                                                               action:@selector(handlePan:)];
//        [self.view addGestureRecognizer:self.panGesture];
//    

    
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
    else if ([segue.identifier isEqualToString:@"GallerySegue"])
    {
        self.Gallery = (GalleryOfImages *)[segue destinationViewController];
          self.Gallery.delegate = self;
    }

  
    self.Figure.delegate = self.Canvas;
    self.Figure.delegateToBoard = self;
    self.Colors.delegate = self.Canvas;

    
 
    
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

- (void) didSelectImage: (UIImage*) frame
{
    UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(50, 100, 320, 320)];
    UIColor *background = [[UIColor alloc] initWithPatternImage:frame];
    window.backgroundColor = background;
    window.windowLevel = UIWindowLevelAlert;
    self.window = window;
    [self.window makeKeyAndVisible];
    
}

//-(void) handlePan: (UIPanGestureRecognizer*) panGesture
//{
//    NSLog(@"BoardpanGesture" );
//
//    CGPoint location = [panGesture locationInView:self.view];
//    UIView* currentView = [self.view hitTest:location withEvent:nil];
//    if([currentView isKindOfClass:[UIWindow class]])
//    {
//        CGPoint translation = [panGesture translationInView:self.view];
//        NSLog(@"translation,%@", NSStringFromCGPoint(translation));
//        currentView.center = CGPointMake(currentView.center.x+translation.x,
//                                              currentView.center.y+translation.y);
//
//        [panGesture setTranslation:CGPointZero inView:self.view];
//
//
//
//
//        panGesture.delegate = self;
//    }
//    else
//        return;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
