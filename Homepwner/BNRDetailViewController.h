//
//  BNRDetailViewController.h
//  Homepwner
//
//  Created by John Russel Usi on 9/30/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BNRItem;

@interface BNRDetailViewController : UIViewController <UIViewControllerRestoration>

- (instancetype)initForNewItem:(BOOL)isNew;

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

@end
