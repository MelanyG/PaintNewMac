//
//  Drawer.m
//  MyPaint
//
//  Created by Melany Gulianovych on 12/17/15.
//  Copyright (c) 2015 Melany Gulianovych. All rights reserved.
//

#import "Drawer.h"

typedef enum shapeTypes
{
    StrictLine,
    triangle,
    ellipse,
    rectangle,
    trapeze,
    polygon,
    image,
    smoothLine,
}SelectedFigure;

@interface Drawer()

@property(nonatomic, assign) CGPoint startPoint;
@property(nonatomic, assign) CGPoint endPoint;
@property(nonatomic, assign) NSInteger shape;
@property(nonatomic, strong) UIColor* color;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, strong) UIImage* image;
@property(nonatomic, strong) NSMutableArray* smoothlines;




@end

@implementation Drawer



- (instancetype)initWithFrame: (CGRect) frame
                        shape: (NSInteger) shape
                        color: (UIColor*) color
                        width: (CGFloat) width
                startLocation: (CGPoint) startTap
                  endLocation:( CGPoint) stopTap
                selectedImage: (UIImage*) image
                 arrayOfLines: (NSMutableArray*)smoothlines
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.shape = shape;
        self.color=color;
        self.width = width;
        self.startPoint = startTap;
        self.endPoint = stopTap;
        self.image = image;
        self.smoothlines = smoothlines;
    }
    return self;
}

- (void)drawRect:(CGRect)rect;
{
    [super drawRect:rect];

    switch (self.shape) {
        case StrictLine:
            [self drawLines:rect];
              break;
        case triangle:
            [self drawTriangle:rect];
            break;
        case ellipse:
            [self drawEllipse:rect];
            break;
        case rectangle:
            [self drawRectangle:rect];
            break;
        case trapeze:
            [self drawTrapeze:rect];
            break;
        case polygon:
            [self drawPolygon:rect];
            break;
        case image:
            [self drawImage: rect
                           : self.image];
            break;
        case smoothLine:
            [self drawSmoothLine:rect
                                :self.smoothlines];
            break;
        default:
            break;
    }
}

- (void)drawLines:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.width);
    CGContextSetStrokeColorWithColor(context, [self.color CGColor] );
    CGPoint p = CGPointMake(rect.size.width, rect.size.height);
    
    
    if (self.crossLine)
    {
        CGContextMoveToPoint(context, 0, p.y);
        CGContextAddLineToPoint(context, p.x, 0);
    }
    else
    {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, p.x, p.y);
    }
    
    CGContextStrokePath(context);
}

-(void)drawTriangle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    rect.origin.x += 5;
    rect.origin.y += 5;
    rect.size.height -= 10;
    rect.size.width -= 10;
    
    
    int sides = 3;
    
    double radius = (rect.size.width<rect.size.height?rect.size.width:rect.size.height) / 2.0;
    CGPoint center = CGPointMake(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height/2);
    
    
    double theta = 2.0 * M_PI / sides;
    
    CGContextMoveToPoint(context, center.x, center.y-radius);
    for (NSUInteger k=1; k<sides; k++) {
        float x = radius * sin(k * theta);
        float y = radius * cos(k * theta);
        CGContextAddLineToPoint(context, center.x+x, center.y-y);
    }
    CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
    CGContextClosePath(context);
    CGContextSetLineWidth(context, self.width);

    CGContextStrokePath(context);
}

-(void)drawEllipse:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
    CGContextSetLineWidth(context, self.width);
    
    CGContextStrokeEllipseInRect(context,CGRectInset
                     (CGRectMake(0, 0, rect.size.width, rect.size.height),
                      self.width, self.width)) ;
    
    
}

-(void)drawRectangle:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.width);
    
    CGContextSetStrokeColorWithColor(context, [self.color CGColor]);
   
    CGContextAddRect(context, CGRectInset
                     (CGRectMake(0, 0, rect.size.width, rect.size.height),
                      self.width, self.width));
    CGContextStrokePath(context);
    
}

-(void) drawTrapeze:(CGRect)rect
{
    rect.size.width-=5;
    rect.size.height-=5;
    rect.origin.x+=5;
    rect.origin.y+=5;
    
    UIBezierPath * aPath = [UIBezierPath bezierPath];
    
    [aPath moveToPoint:CGPointMake(rect.size.width/3, CGRectGetMinY(rect))];
    
    [aPath addLineToPoint:CGPointMake((rect.size.width/3)*2, CGRectGetMinY(rect))];
    [aPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [aPath addLineToPoint:CGPointMake(5, rect.size.height)];
    [aPath closePath];
    
    aPath.lineWidth = self.width;
    
    [self.color setStroke];
  
    [aPath stroke];
}

-(void) drawPolygon:(CGRect)rect
{
    rect.size.width-=self.width;
    rect.size.height-=self.width;
    rect.origin.x+=self.width;
    rect.origin.y+=self.width;
    UIBezierPath * aPath = [UIBezierPath bezierPath];
    
    [aPath moveToPoint:CGPointMake(rect.size.width/3, CGRectGetMinY(rect))];
    
    [aPath addLineToPoint:CGPointMake((rect.size.width/3)*2, CGRectGetMinY(rect))];
    [aPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height/3)];
    [aPath addLineToPoint:CGPointMake(rect.size.width, (rect.size.height/3)*2)];
    [aPath addLineToPoint:CGPointMake((rect.size.width/3)*2, rect.size.height)];
    [aPath addLineToPoint:CGPointMake((rect.size.width/3), rect.size.height)];
    [aPath addLineToPoint:CGPointMake((self.width), (rect.size.height/3)*2)];
    [aPath addLineToPoint:CGPointMake((self.width), (rect.size.height/3))];
  
    
    [aPath closePath];
    aPath.lineWidth = self.width;
    [self.color setStroke];
    [aPath stroke];
   
  }

-(void) drawImage: (CGRect)rect
                 : (UIImage*) image
{

    [image drawInRect:rect];
    NSLog(@"draw image%@", NSStringFromCGRect(self.frame));
}

-(void) drawSmoothLine:(CGRect)rect
                      :(NSMutableArray*)smoothlines
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    for(int i=0; i<[self.smoothlines count]; i++)
    {
        Line* one = [self.smoothlines objectAtIndex: i];
        
        CGContextMoveToPoint(context, one.start.x, one.start.y);
        CGContextAddLineToPoint(context, one.end.x, one.end.y);
    }
    CGContextSetLineCap(context, kCGLineCapRound);
    [self.color setStroke];
    CGContextSetLineWidth(context, self.width);
   
    CGContextStrokePath(context);
    NSLog(@"draw line%@", NSStringFromCGRect(self.frame));
}


#pragma mark - NSCoding

#define kStartPointKey           @"StartPoint"
#define kEndPointKey             @"EndPoint"
#define kShapeKey                @"Shape"
#define kColorKey                @"Color"
#define kWidthKey                @"Width"
#define kImageKey                @"Image"
#define kFrameKey                @"Frame"
#define kBackgroundColorKey      @"BackgroundColor"
#define kCrossLines              @"crossLines"
#define ksmoothLines             @"smoothLines"

- (void) encodeWithCoder:(NSCoder *)encoder
{
    
    NSValue *StartPoint = [NSValue valueWithCGPoint:self.startPoint];
    NSValue *EndPoint = [NSValue valueWithCGPoint:self.endPoint];
    NSValue *Frame = [NSValue valueWithCGRect:self.frame];
    NSData *imageData = UIImagePNGRepresentation(self.image);
    //self.smoothlines[0].
    
    
    [encoder encodeBool:self.crossLine forKey:kCrossLines];
    [encoder encodeObject:StartPoint forKey:kStartPointKey];
    [encoder encodeObject:EndPoint forKey:kEndPointKey];
    [encoder encodeInt:self.shape forKey:kShapeKey];
    [encoder encodeObject:self.color forKey:kColorKey];
    [encoder encodeFloat:self.width forKey:kWidthKey];
    [encoder encodeObject:imageData forKey:kImageKey];
    [encoder encodeObject:Frame forKey:kFrameKey];
    [encoder encodeObject:self.backgroundColor forKey:kBackgroundColorKey];
    [encoder encodeObject:self.smoothlines forKey:ksmoothLines];
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self)
    {
        self.shape = [decoder decodeIntForKey:kShapeKey];
        self.width = [decoder decodeFloatForKey:kWidthKey];
        self.smoothlines = [[decoder decodeObjectForKey:ksmoothLines]mutableCopy];
        NSData *imageData = [decoder decodeObjectForKey:kImageKey];
        self.color = [decoder decodeObjectForKey:kColorKey];
        NSValue *StartPoint = [decoder decodeObjectForKey:kStartPointKey];
        NSValue *EndPoint = [decoder decodeObjectForKey:kEndPointKey];
        NSValue *Frame = [decoder decodeObjectForKey:kFrameKey];
        UIColor* backgroundColor = [decoder decodeObjectForKey:kBackgroundColorKey];
        
        self.crossLine = [decoder decodeBoolForKey:kCrossLines];
        
        self.startPoint = StartPoint.CGPointValue;
        self.endPoint = EndPoint.CGPointValue;
        self.frame = Frame.CGRectValue;
        self.image = [[UIImage alloc] initWithData:imageData];
        self.backgroundColor = backgroundColor;
        
    }
    return self;
}


@end
