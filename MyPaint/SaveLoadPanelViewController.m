//
//  SaveLoadPanelViewController.m
//  MyPaint
//
//  Created by Melany on 12/31/15.
//  Copyright © 2015 Melany Gulianovych. All rights reserved.
//

#import "SaveLoadPanelViewController.h"
#import "PopoverClassForFileName.h"

@interface SaveLoadPanelViewController () 
@property (weak, nonatomic) IBOutlet UIButton *savebuttonPressed;
@property (strong, nonatomic) UIPopoverController* popoverFileName;
@property (strong, nonatomic) NSString* nameFile;
@property (assign, nonatomic) BOOL saveButtonActive;


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

- (void)finishedEnteringTheFileName:(NSString*) fileName
{
    
    
    self.nameFile = fileName;
    [self.popoverFileName dismissPopoverAnimated:YES];
    if(self.saveButtonActive)
    {
        self.saveButtonActive=FALSE;
        [self.delegate didSelectSaveButton:self.nameFile];
      
    }
    else
        [self.delegate didSelectLoadButton:self.nameFile];
}

-(void) creationOfPopover
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopoverClassForFileName* viewcontroller = [storyboard instantiateViewControllerWithIdentifier:@"Popover"];
    viewcontroller.delegate = self;
    self.popoverFileName = [[UIPopoverController alloc]initWithContentViewController:viewcontroller];
   
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.savebuttonPressed];
    [self.popoverFileName presentPopoverFromBarButtonItem: backBarButtonItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [self.popoverFileName setPopoverContentSize:CGSizeMake(300, 250)  animated:YES];
   }

- (IBAction)saveButton:(UIButton *)sender
{
    self.saveButtonActive=TRUE;
    [self creationOfPopover];
    
}

- (IBAction)loadButton:(UIButton *)sender
{
    [self creationOfPopover];
   }


#pragma mark - Dismiss popover delegate

- (void) dismissWithData:(NSString *)nameFile
{
    NSLog(@"%@", nameFile);
    
    
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
