//
//  BNRImageViewController.m
//  Homepwner
//
//  Created by John Russel Usi on 10/2/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRImageViewController.h"

@interface BNRImageViewController ()

@end

@implementation BNRImageViewController

- (void)loadView{

  UIImageView *imageView = [[UIImageView alloc]init];
  imageView.contentMode = UIViewContentModeScaleAspectFit;
  self.view = imageView;
}

- (void)viewWillAppear:(BOOL)animated{

  [super viewWillAppear:animated];
  
  //  We must cast the view to UIImageView so the compiler knows it
  //  is okay to send it setImage
  UIImageView *imageView = (UIImageView *)self.view;
  imageView.image = self.image;
}

@end
