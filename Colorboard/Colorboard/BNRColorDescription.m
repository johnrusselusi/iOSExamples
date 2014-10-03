//
//  BNRColorDescription.m
//  Colorboard
//
//  Created by John Russel Usi on 10/3/14.
//  Copyright (c) 2014 Klab Cyscorpions Training Center. All rights reserved.
//

#import "BNRColorDescription.h"

@implementation BNRColorDescription

- (instancetype)init{

  self = [super init];
  if (self) {
    
    _color = [UIColor colorWithRed:0
                             green:0
                              blue:1
                             alpha:1];
    
    _name = @"Blue";
  }
  
  return self;
}

@end
