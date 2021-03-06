//
//  ColorPanelController.h
//  MyPaint
//
//  Created by Melany Gulianovych on 12/18/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Board.h"
#import "SettingsForColor.h"
#import "Protocols.h"




@interface ColorPanelController : UIViewController <SettingsForColorDelegate>




@property (nonatomic, weak) id <ColorDelegate> delegate;
@property (nonatomic, weak) id <BoardDelegate> delegateBoard;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, assign) CGFloat brush;
@property (nonatomic, assign) CGFloat opacity;

@end

