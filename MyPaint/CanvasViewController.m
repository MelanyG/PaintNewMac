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
@property(nonatomic, strong) NSMutableArray* smoothlines;
@property(nonatomic, assign) CGPoint lastPoint;
@property(nonatomic, assign) BOOL scrollViewAppeared;
@property(nonatomic, assign) CGFloat angleOfRotation;



@end



@implementation CanvasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.smoothlines = [[NSMutableArray alloc]init];
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

-(void) didDisableGestures
{
    if(self.scrollViewAppeared==NO )
    {
       if(self.mode ==YES)
        {
           [self didSelectMode:NO];
            self.mode = YES;
        }
        
        self.scrollViewAppeared = YES;
    }
    else if(self.scrollViewAppeared==YES )
    {
        [self didSelectMode:self.mode];

        self.scrollViewAppeared = NO;
    }
    
}

-(void) didSelectSaveButton: (NSString*) fileName
{
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


-(void) didSelectImage: (UIImage*) image
                      : (NSInteger) tag
{
    self.image = image;
    self.tag = tag;
}

-(void) didSelectMode: (BOOL) mode
{
    self.mode = mode;
    if(mode == FALSE )
    {
        self.gestureTab.enabled = NO;
        self.pinchGesture.enabled = NO;
        self.panGesture.enabled = NO;
        self.rotationGesture.enabled = NO;
       
    }
    else if(mode == TRUE )
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

-(void) didSelectlastDelete
{
    if(self.myArray.count>0)
    {
    NSMutableSet *tmp = [[NSMutableSet alloc]initWithObjects:self.myArray[self.myArray.count-1], nil];
    [tmp makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.myArray removeLastObject];
    [self.view setNeedsDisplay];
    }

}

-(void) didSelectClearAllDelete
{
    if(self.myArray.count>0)
    {
    [self.myArray removeAllObjects];
    for (UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
    [self.view setNeedsDisplay];
    }
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
                __weak UIView* weakCurrentView = self.currentView;
                [self.arrayToDelete addObject: self.currentView];
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     weakCurrentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                                     weakCurrentView.alpha = 0.5;
                                 }
                                 completion:nil
                 ];
            }
            else if ([self.arrayToDelete containsObject:self.currentView])
            {
                __weak UIView* weakCurrentView = self.currentView;
                [UIView animateWithDuration:0.3
                                 animations:^{
                                     weakCurrentView.transform=CGAffineTransformIdentity;
                                     weakCurrentView.alpha = 1.f;
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
    if([self.currentView isKindOfClass:[Drawer class]])
    {
    
    if(pinchGesture.state == UIGestureRecognizerStateBegan)
    {
        self.tmpScale = 1.f;
    }
    
    CGFloat newScale = 1.0f+pinchGesture.scale-self.tmpScale;
    
    CGAffineTransform currentTransform = self.currentView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.currentView.transform = newTransform;
        [self.currentView setNeedsDisplay];
    self.tmpScale = pinchGesture.scale;
        
    pinchGesture.delegate=self;
    }
}

-(void)handleRotation:(UIRotationGestureRecognizer*) rotationGesture
{
    NSLog(@"rotationGesture" );
    
    if([self.currentView isKindOfClass:[Drawer class]])
    {
        if(rotationGesture.state == UIGestureRecognizerStateBegan)
        {
            self.tmpScale = 0;
        }
        
        CGFloat newRotation=self.tmpRotate-rotationGesture.rotation;
        CGAffineTransform currentTransform = self.currentView.transform;
        CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
        self.currentView.transform = newTransform;
        self.angleOfRotation = [(NSNumber *)[ self.currentView valueForKeyPath:@"layer.transform.rotation.z"] floatValue];
       self.currentView.contentMode = UIViewContentModeScaleAspectFill;
       //self.currentView.layer.anchorPoint = CGPointMake(self.angleOfRotation, self.angleOfRotation);
        //self.currentView.transform = CGAffineTransformMakeRotation(30*M_PI/180);
        [self.currentView setNeedsDisplay];
        self.tmpRotate = rotationGesture.rotation;
        
        rotationGesture.delegate=self;
    }
}




-(void)handlePan: (UIPanGestureRecognizer*) panGesture
{
    NSLog(@"panGesture" );
    CGPoint location = [panGesture locationInView:self.view];
    self.currentView = [self.view hitTest:location withEvent:nil];
    
    if ([panGesture state] == UIGestureRecognizerStateBegan || [panGesture state] == UIGestureRecognizerStateChanged)
    {
        if([self.currentView isKindOfClass:[Drawer class]])
        {
            
            NSMutableSet *tmp = [[NSMutableSet alloc]initWithObjects:self.currentView, nil];
            [tmp makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            [self.view addSubview:self.currentView];
            
            [self.view setNeedsDisplay];
            
            CGPoint translation = [panGesture translationInView:self.view];
            NSLog(@"translation,%@", NSStringFromCGPoint(translation));
            
            self.currentView.center = CGPointMake(self.currentView.center.x+translation.x,
                                                  self.currentView.center.y+translation.y);
            
            [panGesture setTranslation:CGPointZero inView:self.view];
            //[self.currentView setNeedsDisplay];
             panGesture.delegate = self;
        }
        else
            return;
    }
    
    else if(panGesture.state == UIGestureRecognizerStateEnded)
    {
        //[self.currentView setNeedsDisplay];
        [self.currentView bringSubviewToFront:self.view];
        return;
    }
    
    
    
    //                [UIView animateWithDuration:2*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    //                   panGesture.view.center = finalPoint;
    //               }
    //                                completion:nil];
    //        }
    
    
    
    
   
}



#pragma mark-Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.scrollViewAppeared ==0)
    {
        if(self.mode == FALSE)
        {
            UITouch* touch = [[event allTouches] anyObject];
            self.start = [touch locationInView:self.view];
            
            CGRect frame = CGRectMake(self.start.x,
                                      self.start.y,
                                      0,
                                      0);
            if(self.tag == 7)
            {
                self.lastPoint= self.start;
                self.smoothlines = [[NSMutableArray alloc]init];
                Line* one = [[Line alloc] init];
                one.start = self.lastPoint;
                one.end = self.lastPoint;
                
                [self.smoothlines addObject:one];
                frame = self.view.frame;
                
            }
            
            self.rect = [[Drawer alloc] initWithFrame: frame
                                                shape: self.tag
                                                color: self.button
                                                width: self.width
                                        startLocation: self.start
                                          endLocation: self.stop
                                        selectedImage: self.image
                                         arrayOfLines: self.smoothlines];
            
            self.rect.translatesAutoresizingMaskIntoConstraints = NO;
            self.rect.backgroundColor = [UIColor clearColor];
            
            [self.view addSubview:self.rect];
            [self.myArray addObject:self.rect];
            
            
            
            NSLog(@"touchesBegan,%@", NSStringFromCGRect(frame));
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.mode == FALSE)
    {
        if(self.tag==7)
        {
            UITouch* touch = [[event allTouches] anyObject];
            CGPoint newPoint= [touch locationInView:self.view];
            self.start = self.lastPoint;
            self.stop = newPoint;
            Line* one = [[Line alloc] init];
            one.start = self.lastPoint;
            one.end = newPoint;
            self.lastPoint = newPoint;
            [self.smoothlines addObject:one];
            
        }
        else
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
            
            
             NSLog(@"touchesMoved,%@", NSStringFromCGRect(frame));
        }
       [self.rect setNeedsDisplay];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.mode==FALSE)
    {
        
        [super touchesEnded:touches withEvent:event];
               NSLog(@"touchesEnded ");
        
        if(self.tag == 7)
            [self.view sendSubviewToBack: self.rect];
        self.rect = nil;
        
        NSLog(@"q-ty of elements in array: %lu", (unsigned long)[self.myArray count]);
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(self.scrollViewAppeared == 0)
    {
        if(self.mode == FALSE)
        {
            self.rect = nil;
            NSLog(@"touchesCancelled");
        }
    }
}




@end
