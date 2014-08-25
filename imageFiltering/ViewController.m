//
//  ViewController.m
//  imageFiltering
//
//  Created by Sergey Maslov on 25.08.14.
//  Copyright (c) 2014 Sergey Maslov. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController {
    CIContext *context;
    CIFilter *filter;
    CIImage *beginImage;
    UIImageOrientation orientation;
}

-(void)logAllFilters {
    NSArray *properties = [CIFilter filterNamesInCategory:
                           kCICategoryBuiltIn];
    NSLog(@"%@", properties);
    for (NSString *filterName in properties) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"%@", [fltr attributes]);
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *filePath =  [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    beginImage = [CIImage imageWithContentsOfURL:fileNameAndPath];
    context = [CIContext contextWithOptions:nil];

    [self updateImage];
    [self logAllFilters];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)updateImage {
    // Place My Filters here!
    CIFilter *colorControls = [CIFilter filterWithName:@"CIColorControls"];
    [colorControls setValue:beginImage forKey:kCIInputImageKey];
    [colorControls setValue:@(0.5f) forKey:@"inputBrightness"];
    [colorControls setValue:@(0.5f) forKey:@"inputContrast"];
    
    CIImage *outputImage = colorControls.outputImage;
    CGImageRef cgimg = [context createCGImage:outputImage
                                     fromRect:[outputImage extent]];
    
    UIImage *newImage = [UIImage imageWithCGImage:cgimg scale:1.0 orientation:orientation];
    self.imageView.image = newImage;
    
    CGImageRelease(cgimg);
}

- (IBAction)loadImage:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    pickerController.delegate = self;
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (IBAction)saveImage:(id)sender {
    CIImage *saveToSave = [filter outputImage];
    CIContext *softwareContext = [CIContext
                                  contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
    CGImageRef cgImg = [softwareContext createCGImage:saveToSave
                                             fromRect:[saveToSave extent]];
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg
                                 metadata:[saveToSave properties]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              
                              CGImageRelease(cgImg);
                          }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage *gotImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    beginImage = [CIImage imageWithCGImage:gotImage.CGImage];
    orientation = gotImage.imageOrientation;
    [filter setValue:beginImage forKey:kCIInputImageKey];
    [self updateImage];
}

- (void)imagePickerControllerDidCancel: (UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
