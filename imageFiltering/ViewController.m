//
//  ViewController.m
//  imageFiltering
//
//  Created by Sergey Maslov on 25.08.14.
//  Copyright (c) 2014 Sergey Maslov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(id)sender {
}

- (IBAction)loadImage:(id)sender {
}

- (IBAction)saveImage:(id)sender {
    NSString *message = [NSString stringWithFormat:
                         @"The value of the slider is: %d", lroundf( self.slider.value) ];
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Hello, World!"
                              message:message
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    
    [alertView show];
}
@end
