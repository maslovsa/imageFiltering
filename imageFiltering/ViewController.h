//
//  ViewController.h
//  imageFiltering
//
//  Created by Sergey Maslov on 25.08.14.
//  Copyright (c) 2014 Sergey Maslov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)loadImage:(id)sender;
- (IBAction)saveImage:(id)sender;
@end
