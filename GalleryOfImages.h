//
//  GalleryOfImages.h
//  MyPaint
//
//  Created by Melany on 1/6/16.
//  Copyright © 2016 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface GalleryOfImages : UIViewController <UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property(weak, nonatomic) id <BoardDelegate> delegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;


@end
