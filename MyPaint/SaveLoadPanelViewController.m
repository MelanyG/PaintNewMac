//
//  SaveLoadPanelViewController.m
//  MyPaint
//
//  Created by Melany on 12/31/15.
//  Copyright © 2015 Melany Gulianovych. All rights reserved.
//

#import "SaveLoadPanelViewController.h"

@interface SaveLoadPanelViewController ()

@end

@implementation SaveLoadPanelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(UIButton *)sender
{
    [self.delegate didSelectSaveButton:sender.tag];
}

- (IBAction)loadButton:(UIButton *)sender
{
    [self.delegate didSelectLoadButton:sender.tag];
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
