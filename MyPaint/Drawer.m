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
    Line,
    triangle,
    ellipse,
    rectangle,
    trapeze,
    polygon,
    image,
    
}SelectedFigure;

@interface Drawer()

@property(nonatomic, assign) CGPoint startPoint;
@property(nonatomic, assign) CGPoint endPoint;
@property(nonatomic, assign) NSInteger shape;
@property(nonatomic, strong) UIColor* color;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, weak) UIImage* image;

@end

@implementation Drawer



- (instancetype)initWithFrame: (CGRect) frame
                        shape: (NSInteger) shape
                        color: (UIColor*) color
                        width: (CGFloat) width
                startLocation: (CGPoint) startTap
                  endLocation:( CGPoint) stopTap
                selectedImage: (UIImage*) image
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
    }
    return self;
}

- (void)drawRect:(CGRect)rect;
{
    [super drawRect:rect];

    switch (self.shape) {
        case Line:
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
    //double size = 2*radius*sin(60/2);
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


    //CGContextFillPath(context);           // Choose for a filled triangle
    //CGContextSetLineWidth(context, 2); // Choose for a unfilled triangle
    CGContextStrokePath(context);      // Choose for a unfilled triangle
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
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(rect.size.width/3, CGRectGetMinY(rect))];
    
    // Draw some lines.
    [aPath addLineToPoint:CGPointMake((rect.size.width/3)*2, CGRectGetMinY(rect))];
    
    [aPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
    [aPath addLineToPoint:CGPointMake(5, rect.size.height)];
    [aPath closePath];
    
    //set the line width
    aPath.lineWidth = self.width;
    
    //set the stoke color
    [self.color setStroke];
    
    //draw the path
    [aPath stroke];

}

-(void) drawPolygon:(CGRect)rect
{
    rect.size.width-=self.width;
    rect.size.height-=self.width;
    rect.origin.x+=self.width;
    rect.origin.y+=self.width;
    UIBezierPath * aPath = [UIBezierPath bezierPath];
    
    // Set the starting point of the shape.
    [aPath moveToPoint:CGPointMake(rect.size.width/3, CGRectGetMinY(rect))];
    
    // Draw some lines.
    [aPath addLineToPoint:CGPointMake((rect.size.width/3)*2, CGRectGetMinY(rect))];
    
    [aPath addLineToPoint:CGPointMake(rect.size.width, rect.size.height/3)];
    [aPath addLineToPoint:CGPointMake(rect.size.width, (rect.size.height/3)*2)];
    [aPath addLineToPoint:CGPointMake((rect.size.width/3)*2, rect.size.height)];
    [aPath addLineToPoint:CGPointMake((rect.size.width/3), rect.size.height)];
    [aPath addLineToPoint:CGPointMake((self.width), (rect.size.height/3)*2)];
    [aPath addLineToPoint:CGPointMake((self.width), (rect.size.height/3))];
    
    
    //changes start here !
    
    //the point look to be at 80% down
    //[aPath addLineToPoint:CGPointMake(CGRectGetMaxX(rect), CGRectGetMaxY(rect) * .8)];
    
    
    //1st arc
    //The end point look to be at 1/4 at left, bottom
    //CGPoint p = CGPointMake(CGRectGetMaxX(rect) / 4, CGRectGetMaxY(rect));
    //CGPoint cp = CGPointMake( (CGRectGetMaxX(rect) / 4) + ((CGRectGetMaxX(rect) - (CGRectGetMaxX(rect) / 4)) / 2) , CGRectGetMaxY(rect) * .8);
    
    //[aPath addQuadCurveToPoint:p controlPoint:cp];
    
    
    //2nd arc
    //The end point look to be at 80% downt at left,
    //CGPoint p2 = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect) * .8);
    //CGPoint cp2 = CGPointMake( (CGRectGetMaxX(rect) / 4) / 2 , CGRectGetMaxY(rect) * .8);
    
    //[aPath addQuadCurveToPoint:p2 controlPoint:cp2];
    
    
    //close the path
    [aPath closePath];
    
    //set the line width
    aPath.lineWidth = self.width;
    
    //set the stoke color
    [self.color setStroke];
    
    //draw the path
    [aPath stroke];
    
    //UIBezierPath *poly = [[UIBezierPath alloc] init];
    
    ////set the line width
    //poly.lineWidth = 5;
    
    //set the stoke color
    //[[UIColor greenColor] setStroke];
    
   
    //[poly strokeWithBlendMode:normal alpha:0.8];
    //[poly moveToPoint:CGPointMake(0.0, 0.0)];
    //[poly addLineToPoint:CGPointMake(200.0, 0.0)];
    //[poly addLineToPoint:CGPointMake(200.0, 200.0)];
    //[poly closePath];
    //[poly stroke]; // draw stroke
    
  }

-(void) drawImage: (CGRect)rect
                 : (UIImage*) image;
{

    [image drawInRect:rect];
    NSLog(@"draw image%@", NSStringFromCGRect(self.frame));
}

#pragma mark - NSCoding

#define kStartPointKey           @"StartPoint"
#define kEndPointKey             @"EndPoint"
#define kShapeKey                @"Shape"
#define kColorKey                @"Color"
#define kWidthKey                @"Width"
#define kImageKey                @"Image"
#define kFrameKey                @"Frame"
#define kBackgroundColorKey                @"BackgroundColor"

- (void) encodeWithCoder:(NSCoder *)encoder
{
    NSValue *StartPoint = [NSValue valueWithCGPoint:self.startPoint];
    NSValue *EndPoint = [NSValue valueWithCGPoint:self.endPoint];
    NSValue *Frame = [NSValue valueWithCGRect:self.frame];
    
    
    [encoder encodeObject:StartPoint forKey:kStartPointKey];
    [encoder encodeObject:EndPoint forKey:kEndPointKey];
    [encoder encodeInt:self.shape forKey:kShapeKey];
    [encoder encodeObject:self.color forKey:kColorKey];
    [encoder encodeFloat:self.width forKey:kWidthKey];
    [encoder encodeObject:self.image forKey:kImageKey];
    [encoder encodeObject:Frame forKey:kFrameKey];
    [encoder encodeObject:self.backgroundColor forKey:kBackgroundColorKey];
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self)
    {
        self.shape = [decoder decodeIntForKey:kShapeKey];
        self.width = [decoder decodeFloatForKey:kWidthKey];
        self.image = [decoder decodeObjectForKey:kImageKey];
        self.color = [decoder decodeObjectForKey:kColorKey];
        NSValue *StartPoint = [decoder decodeObjectForKey:kStartPointKey];
        NSValue *EndPoint = [decoder decodeObjectForKey:kEndPointKey];
        NSValue *Frame = [decoder decodeObjectForKey:kFrameKey];
        UIColor* backgroundColor = [decoder decodeObjectForKey:kBackgroundColorKey];
        
        self.startPoint = StartPoint.CGPointValue;
        self.endPoint = EndPoint.CGPointValue;
        self.frame = Frame.CGRectValue;
       self.backgroundColor = backgroundColor;
        
    }
    return self;
}


@end
