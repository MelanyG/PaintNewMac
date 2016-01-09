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
    self.scrollView.backgroundColor = [UIColor redColor];
    
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
        
        myImageView.frame = CGRectMake(xPosition, 5, imageWidth, imageHeight);
        [self.scrollView addSubview:myImageView];
        
        CGFloat space = 5.f;
        xPosition+=imageWidth+space;
        scrollViewControllerSize+=imageHeight+space;
        
        
        self.scrollView.contentSize = CGSizeMake(imageWidth,scrollViewControllerSize);
        
        
        
        
    }
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
