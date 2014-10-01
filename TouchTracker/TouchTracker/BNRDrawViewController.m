//
//  BNRDrawViewController.m
//  TouchTracker
//
//  Created by John Russel Usi on 10/1/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "BNRDrawViewController.h"
#import "BNRDrawView.h"

@implementation BNRDrawViewController

- (void)loadView{

  self.view = [[BNRDrawView alloc]initWithFrame:CGRectZero];
}

@end
