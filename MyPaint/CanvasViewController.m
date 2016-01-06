//
//  CanvasViewController.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "CanvasViewController.h"




@interface CanvasViewController ()

@property(nonatomic, strong) Drawer* rect;
@property(nonatomic, assign) NSInteger tag; //for protocol
@property(nonatomic, strong) UIColor* button; //for protocol
@property(nonatomic, assign) CGPoint start;
@property(nonatomic, assign) CGPoint stop;
@property(nonatomic, strong) NSMutableArray* myArray;
@property(nonatomic, assign) CGFloat width; //for protocol
@property(nonatomic, weak) UIView* currentView;
@property(nonatomic, assign) CGFloat tmpScale;
@property(nonatomic, assign) CGFloat tmpRotate;
@property(nonatomic, assign) BOOL mode;
@property(nonatomic, strong) UITapGestureRecognizer*  gestureTab;
@property(nonatomic, strong) UIPinchGestureRecognizer* pinchGesture;
@property(nonatomic, strong) UIRotationGestureRecognizer* rotationGesture;
@property(nonatomic, strong) UIPanGestureRecognizer* panGesture;
@property(nonatomic, strong) NSMutableSet* arrayToDelete;
@property(nonatomic, strong) UIImage* image;
@property(nonatomic, strong) NSString* fileName;


@end



@implementation CanvasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.myArray = [[NSMutableArray alloc] init];
    self.arrayToDelete = [[NSMutableSet alloc] init];
    self.button = [UIColor blackColor];
    self.width = 10;
    self.gestureTab = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                             action:@selector(handleDoubleTap:) ];
    [self.view addGestureRecognizer: self.gestureTab];
    self.gestureTab.numberOfTapsRequired=2;
    
    
    self.pinchGesture=[[UIPinchGestureRecognizer alloc]initWithTarget:self
                                                               action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:self.pinchGesture];
    
    self.rotationGesture=[[UIRotationGestureRecognizer alloc]initWithTarget:self
                                                                     action:@selector(handleRotation:)];
    [self.view addGestureRecognizer:self.rotationGesture];
    
    self.panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self
                                                           action:@selector(handlePan:)];
    [self.view addGestureRecognizer:self.panGesture];
    self.mode=0;
    
    self.gestureTab.enabled = NO;
    self.pinchGesture.enabled=NO;
    self.panGesture.enabled=NO;
    self.rotationGesture.enabled=NO;
    

}

#pragma mark-protocols

-(void) didSelectFigure:(NSInteger) tag
{
    self.tag=tag;
}

-(void) didSelectSaveButton: (NSString*) fileName
{
    //NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* directory = paths[0];
    self.fileName = fileName;
    NSString* dataFile = [directory stringByAppendingPathComponent:self.fileName];
    
    
    NSLog(@"%@", self.myArray);
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject: self.myArray];
    NSLog(@"%@", data);
  
    [data writeToFile:dataFile atomically:YES];
     
}

-(void) didSelectLoadButton: (NSString*) fileName
{
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* directory = paths[0];
    self.fileName = fileName;
    NSString* dataFile = [directory stringByAppendingPathComponent: self.fileName];
     
    if([fileManager fileExistsAtPath:dataFile])
    {
        NSData* dataFromFile = [[NSData alloc] initWithContentsOfFile:dataFile];
        [self.myArray removeAllObjects];
        
        self.myArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataFromFile];
        NSLog(@"%@", self.myArray);
        for(int i=0; i<[self.myArray count]; i++)
        {
            
            [self.view addSubview:self.myArray[i]];

            [self.myArray[i] setNeedsDisplay];
        };
        
    }
    
}

-(void) didSelectColor:(UIColor*) colorSelected
{
    self.button=colorSelected;
}

-(void) didSelectWidth:(CGFloat)shapeWidth
{
    self.width = shapeWidth;
}

-(void) didSelectImage: (UIImage*) image
                      : (NSInteger) tag
{
    self.image = image;
    self.tag = tag;
}

-(void) didSelectMode: (NSInteger) mode
{
    self.mode = mode;
    if(mode == 0)
    {
        self.gestureTab.enabled = NO;
        self.pinchGesture.enabled = NO;
        self.panGesture.enabled = NO;
        self.rotationGesture.enabled = NO;
    }
    else if(mode == 1)
    {
        self.gestureTab.enabled = YES;
        self.pinchGesture.enabled = YES;
        self.panGesture.enabled = YES;
        self.rotationGesture.enabled = YES;
    }
}

-(void) didSelectDelete
{
    for(int i=0; i<[self.myArray count]; i++)
    {
        NSLog(@"Quantity of elements in NSSET: %lu",(unsigned long)[self.arrayToDelete count]);
        for(int j=0; j<[self.myArray count]; j++)
        {
            if([self.arrayToDelete containsObject: self.myArray[j]])
            {
                [self.arrayToDelete makeObjectsPerformSelector:@selector(removeFromSuperview)];
                [self.myArray removeObjectAtIndex:j];
                        NSLog(@"Subview removed");
                [self.view setNeedsDisplay];
                NSLog(@"Object removed");
            }
        }
    }
    [self.arrayToDelete removeAllObjects];
}

-(void)didSelectSettings: (id) sender
{
    self.button= ((ColorPanelController*)sender).color;
    self.width = ((ColorPanelController*)sender).brush;
    
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}





#pragma mark-Gestures

-(void)handleDoubleTap:(UITapGestureRecognizer*) gestureTab
{
    if (gestureTab.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Tab,%@", NSStringFromCGPoint([gestureTab locationInView:self.view]));
        CGPoint location = [gestureTab locationInView:self.view];
        self.currentView = [self.view hitTest:location withEvent:nil];
        if([self.currentView isKindOfClass:[Drawer class]])
        {
            if( ![self.arrayToDelete containsObject:self.currentView])
            {
                [self.arrayToDelete addObject: self.currentView];
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     self.currentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                                     self.currentView.alpha = 0.5;
                                 }
                                 completion:nil
                 ];
            }
            else if ([self.arrayToDelete containsObject:self.currentView])
            {
                
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     self.currentView.transform=CGAffineTransformIdentity;
                                     self.currentView.alpha = 1.f;
                                 }];
                [self.arrayToDelete removeObject:self.currentView];
            }
            gestureTab.delegate = self;
        }
    }
}

-(void)handlePinch:(UIPinchGestureRecognizer*) pinchGesture
{
    NSLog(@"pinchGesture" );
    
    
    if(pinchGesture.state == UIGestureRecognizerStateBegan)
    {
        self.tmpScale = 1.f;
    }
    
    CGFloat newScale = 1.f+pinchGesture.scale-self.tmpScale;
    
    CGAffineTransform currentTransform = self.currentView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.currentView.transform = newTransform;
    self.tmpScale = pinchGesture.scale;
    pinchGesture.delegate=self;
    
}

-(void)handleRotation:(UIRotationGestureRecognizer*) rotationGesture
{
    NSLog(@"rotationGesture" );
    
    
    if(rotationGesture.state == UIGestureRecognizerStateBegan)
    {
        self.tmpScale = 0;
    }
    
    CGFloat newRotation=self.tmpRotate-rotationGesture.rotation;
    CGAffineTransform currentTransform = self.currentView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    self.currentView.transform = newTransform;
    self.tmpRotate = rotationGesture.rotation;
    
    rotationGesture.delegate=self;
    
}

-(void)handlePan: (UIPanGestureRecognizer*) panGesture
{
    NSLog(@"panGesture" );
    
    CGPoint location = [panGesture locationInView:self.view];
    self.currentView = [self.view hitTest:location withEvent:nil];
    if([self.currentView isKindOfClass:[Drawer class]])
    {
        CGPoint translation = [panGesture translationInView:self.view];
        NSLog(@"translation,%@", NSStringFromCGPoint(translation));
        
        
        
        self.currentView.center = CGPointMake(self.currentView.center.x+translation.x,
                                              self.currentView.center.y+translation.y);
        
        [panGesture setTranslation:CGPointZero inView:self.view];
        //self.currentView.center=[panGesture locationInView:self.view];
        
        
        
        
        
        //            CGPoint translation = [panGesture translationInView:panGesture.self.view];
        //
        //            panGesture.self.view.center =
        //           //            [panGesture setTranslation:CGPointZero inView:self.currentView];
        //self.currentView.center=[panGesture locationInView:self.view];
        
        
        
        //    self.currentView.center = CGPointMake(panGesture.view.center.x+transition.x, panGesture.view.center.y+transition.y);
        //     [panGesture setTranslation:CGPointZero inView:self.currentView];
        //      self.currentView.center=[panGesture locationInView:self.view];
        
        
        
        
        //        CGPoint translation = [panGesture translationInView:self.currentView];
        //        panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x,
        //                                             panGesture.view.center.y + translation.y);
        //        [panGesture setTranslation:CGPointMake(0, 0) inView:self.currentView];
        //        if (panGesture.state == UIGestureRecognizerStateEnded)
        //        {
        //
        //            CGPoint velocity = [panGesture velocityInView:self.view];
        //            CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        //            CGFloat slideMult = magnitude / 200;
        //            NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        //
        //            float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        //           CGPoint finalPoint = CGPointMake(panGesture.view.center.x + (velocity.x * slideFactor),
        //                                            panGesture.view.center.y + (velocity.y * slideFactor));
        //           finalPoint.x = MIN(MAX(finalPoint.x, 0), self.currentView.bounds.size.width);
        //            finalPoint.y = MIN(MAX(finalPoint.y, 0), self.currentView.bounds.size.height);
        //
        //
        //                [UIView animateWithDuration:2*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        //                   panGesture.view.center = finalPoint;
        //               }
        //                                completion:nil];
        //        }
        
        
        
        
        panGesture.delegate = self;
    }
    else
        return;
}

#pragma mark-Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.mode == FALSE)
    {
        UITouch* touch = [[event allTouches] anyObject];
        self.start = [touch locationInView:self.view];
        
        CGRect frame = CGRectMake(self.start.x,
                                  self.start.y,
                                  0, 0);
        
        self.rect = [[Drawer alloc] initWithFrame: frame
                                            shape: self.tag
                                            color: self.button
                                            width: self.width
                                    startLocation: self.start
                                      endLocation: self.stop
                                     selectedImage: self.image];
        
        self.rect.translatesAutoresizingMaskIntoConstraints = NO;
        self.rect.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.rect];
        [self.myArray addObject:self.rect];
        
//        [UIView animateWithDuration:0.3
//                         animations:^{
//                             self.rect.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
//                             self.rect.alpha = 0.3;
//                         }];
        NSLog(@"touchesBegan,%@", NSStringFromCGRect(frame));
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.mode == FALSE)
    {
        
        
        UITouch* touch = [[event allTouches] anyObject];
        self.stop = [touch locationInView:self.view];
        
        CGFloat width = self.stop.x - self.start.x;
        CGFloat height = self.stop.y - self.start.y;
        
        CGFloat x = width >= 0 ? self.start.x : self.start.x + width;
        CGFloat y = height >= 0 ? self.start.y : self.start.y + height;
        
        CGRect frame = CGRectMake(x, y, fabs(width), fabs(height));
        
        self.rect.crossLine = (width > 0 && height < 0) || (width < 0 && height > 0);
        self.rect.frame = frame;
        
        [self.rect setNeedsDisplay];
        NSLog(@"touchesMoved,%@", NSStringFromCGRect(frame));
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.mode==FALSE)
    {
        
        [super touchesEnded:touches withEvent:event];
        //CGRect lframe = [firstView convertRect:buttons.frame fromView:secondView];
        NSLog(@"touchesEnded ");
        
//        [UIView animateWithDuration:0.3
//                         animations:^{
//                             self.rect.transform = CGAffineTransformIdentity;
//                             self.rect.alpha = 1.f;
//                         }];
        
        self.rect = nil;
        NSLog(@"q-ty of elements in array: %lu", (unsigned long)[self.myArray count]);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.mode == FALSE)
    {
        self.rect = nil;
        NSLog(@"touchesCancelled");
    }
}




@end
