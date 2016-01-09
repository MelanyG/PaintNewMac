//
//  Protocols.h
//  MyPaint
//
//  Created by Melany on 1/5/16.
//  Copyright © 2016 Melany Gulianovych. All rights reserved.
//

#ifndef Protocols_h
#define Protocols_h


#endif /* Protocols_h */

@protocol FigureDelegate <NSObject>

@required

-(void) didSelectFigure:(NSInteger)tag;
-(void) didSelectImage: (UIImage*) image
                      : (NSInteger) tag;


@end

@protocol FigureBoardDelegate <NSObject>

-(void) didBackgroundSelect:(CGFloat)height;

@end

@protocol ColorDelegate <NSObject>

@required


-(void) didSelectColor:(UIColor*)button;
-(void) didSelectWidth:(CGFloat)shapeWidth;
-(void) didSelectMode: (NSInteger) mode;
-(void) didSelectSettings: (id) sender;
-(void) didSelectDelete;

@end

@protocol SaveLoadDelegate <NSObject>

@required

-(void) didSelectSaveButton: (NSString*) fileName;
-(void) didSelectLoadButton: (NSString*) fileName;

@end


@protocol PopoverClassForFileNameDelegate

@required

- (void)finishedEnteringTheFileName:(NSString*) fileName;

@end
@protocol DismissPopoverDelegate <NSObject>

- (void) dismissWithData:(NSString *)data;

@end