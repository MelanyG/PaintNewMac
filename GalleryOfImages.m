//
//  GalleryOfImages.m
//  MyPaint
//
//  Created by Melany on 1/6/16.
//  Copyright © 2016 Melany Gulianovych. All rights reserved.
//

#import "GalleryOfImages.h"

@interface GalleryOfImages ()
@property(nonatomic, strong) UIPanGestureRecognizer* panGesture;

@end

@implementation GalleryOfImages

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.panGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self
                                                           action:@selector(handlePan:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    
    //self.scrollView.backgroundColor = [UIColor blackColor];
    
    NSArray *frameArray = [[NSArray alloc] initWithObjects:
                           [UIImage imageNamed:@"campus.jpg"],
                           [UIImage imageNamed:@"Dog.png"],
                           [UIImage imageNamed:@"Snowflakes.png"],
                           [UIImage imageNamed:@"Christmas.png"],
                           [UIImage imageNamed:@"Bears.png"],
                           [UIImage imageNamed:@"halloween.png"],
                           [UIImage imageNamed:@"Mickey.png"],
                           [UIImage imageNamed:@"t.jpg"],
                           [UIImage imageNamed:@"ch.jpg"],
                           nil];
    
    CGFloat imageWidth = 300.f;
    CGFloat imageHeight = 280.f;
    CGFloat xPosition = 5.f;
    CGFloat scrollViewControllerSize = 0;
    
    for(int i = 0; i<frameArray.count; i++)
    {
        UIImageView* myImageView = [[UIImageView alloc]initWithImage:frameArray[i]];
        myImageView.contentMode = UIViewContentModeScaleAspectFit;
        myImageView.userInteractionEnabled = YES;
        myImageView.frame = CGRectMake(xPosition, 5, imageWidth, imageHeight);
        
        [self.scrollView addSubview:myImageView];
        
        CGFloat space = 5.f;
        xPosition+=imageWidth+space;
        scrollViewControllerSize=imageHeight+space*2;
        
        
        self.scrollView.contentSize = CGSizeMake(imageWidth* [frameArray count]*2,scrollViewControllerSize);
        
        
        
    }
}
-(void)handleDoubleTap:(UITapGestureRecognizer*) gestureTab
{
   if (gestureTab.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"Tab,%@", NSStringFromCGPoint([gestureTab locationInView:self.scrollView]));
        CGPoint location = [gestureTab locationInView:self.scrollView];
        UIView* currentView = [self.scrollView hitTest:location withEvent:nil];
        if([currentView isKindOfClass:[UIImageView class]])
        {
                            [UIView animateWithDuration:0.3
                                 animations:^{
                                    currentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                                    currentView.alpha = 0.5;
                                 }
                                 completion:nil
                 ];
  
                       self.scrollView.delegate = self;
        }
    }
}


-(void) handlePan: (UIPanGestureRecognizer*) panGesture
{
    NSLog(@"panGesture" );
    
    CGPoint location = [panGesture locationInView:self.scrollView];
    UIView* currentView = [self.view hitTest:location withEvent:nil];
    if([currentView isKindOfClass:[UIImageView class]])
    {
        CGPoint translation = [panGesture translationInView:self.scrollView];
        NSLog(@"translation,%@", NSStringFromCGPoint(translation));
        currentView.center = CGPointMake(currentView.center.x+translation.x,
                                              currentView.center.y+translation.y);
        
        [panGesture setTranslation:CGPointZero inView:self.view];
        
           // [self.delegate didSelectImage:sender.tag];
 
        
        self.scrollView.delegate = self;
    }
    else
        return;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
