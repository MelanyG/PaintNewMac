//
//  Line.m
//  MyPaint
//
//  Created by Melany on 1/10/16.
//  Copyright © 2016 Melany Gulianovych. All rights reserved.
//

#import "Line.h"

@interface Line ()

@end

@implementation Line

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#define kStartKey           @"Start"
#define kEndKey             @"End"

- (void) encodeWithCoder:(NSCoder *)encoder
{
    
    NSValue *start = [NSValue valueWithCGPoint:self.start];
    NSValue *End = [NSValue valueWithCGPoint:self.end];
    
    [encoder encodeObject:start forKey:kStartKey];
    [encoder encodeObject:End forKey:kEndKey];
    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if(self)
    {
       
        NSValue *StartPoint = [decoder decodeObjectForKey:kStartKey];
        NSValue *EndPoint = [decoder decodeObjectForKey:kEndKey];
        
        self.start = StartPoint.CGPointValue;
        self.end = EndPoint.CGPointValue;
        
    }
    return self;
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
