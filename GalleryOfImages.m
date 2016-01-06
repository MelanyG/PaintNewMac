//
//  GalleryOfImages.m
//  MyPaint
//
//  Created by Melany on 1/6/16.
//  Copyright © 2016 Melany Gulianovych. All rights reserved.
//

#import "GalleryOfImages.h"

@interface GalleryOfImages ()

@end

@implementation GalleryOfImages

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.scrollView.backgroundColor = [UIColor clearColor];
    
    NSArray *frameArray = [[NSArray alloc] initWithObjects:
                            [UIImage imageNamed:@"Dog.png"],
                            [UIImage imageNamed:@"Snowflakes.png"],
                            [UIImage imageNamed:@"Christmas.png"],
                            [UIImage imageNamed:@"Bears.png"], nil];
    
    CGFloat imageWidth = 100.f;
    CGFloat imageHeight = 180.f;
    CGFloat yPosition = 0.f;
    CGFloat scrollViewControllerSize = 0;
    
    for(int i = 0; i<frameArray.count; i++)
    {
        UIImageView* imageView = [[UIImageView alloc]initWithImage:frameArray[i]];
        UIImageView* myImageView;
        myImageView.image = imageView.image;
        myImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        myImageView.frame = CGRectMake(10, yPosition, imageWidth, imageHeight);
        myImageView.center = self.view.center;
        
        [self.scrollView addSubview:myImageView];
        
        CGFloat space = 20.f;
        yPosition+=imageHeight+space;
        scrollViewControllerSize+=imageWidth+space;
        
        self.scrollView.contentSize = CGSizeMake(imageWidth,scrollViewControllerSize);

        
                                   
        
    
    }
    
    
//    int pageCount = 1;
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 960, 200) ];
//   
//    self.scrollView.pagingEnabled = YES;
//       
//    CGRect viewImage = self.scrollView.bounds;
//    
//    UIImageView* imageView = [[UIImageView alloc] initWithFrame:viewImage];
//    [self.scrollView addSubview:imageView];
    
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
