//
//  BNRReminderViewController.m
//  HypnoNerd
//
//  Created by John Russel Usi on 9/29/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation BNRReminderViewController

- (void)viewDidLoad{
  
  [super viewDidLoad];
  
  NSLog(@"BNRReminderViewController loaded its view.");
}

- (void)viewWillAppear:(BOOL)animated{
  
  [super viewWillAppear:animated];
  
  self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (IBAction)addReminder:(id)sender{
  
  NSDate *date = self.datePicker.date;
  NSLog(@"Setting a reminder for %@",date);
  
  UILocalNotification *note = [[UILocalNotification alloc]init];
  note.alertBody = @"Hypnotize me!";
  note.fireDate = date;
  
  [[UIApplication sharedApplication]scheduleLocalNotification:note];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  if (self) {
    //  Set the tab bar item's title
    self.tabBarItem.title = @"Reminder";
    
    //  Create a UImage from file
    //  This will use Hypno@2x.png on retina display devices
    UIImage *image = [UIImage imageNamed:@"Time"];
    
    //  Put that image on the tab bar item
    self.tabBarItem.image = image;
  }
  
  return self;
}

@end
