//
//  BNRHypnosisViewController.m
//  HypnoNerd
//
//  Created by John Russel Usi on 9/29/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@property (nonatomic, weak) UITextField *textField;

@end

@implementation BNRHypnosisViewController

- (void)viewDidLoad{
  
  //  Always call the super implementation of the viewDidLoad
  [super viewDidLoad];
  
  NSLog(@"BNRHypnosisViewController loaded its view.");
}

- (void)loadView{
  
  //  Create a view
  CGRect frame = [UIScreen mainScreen].bounds;
  BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc]initWithFrame:frame];
  
  CGRect textFieldRect = CGRectMake(40, -30, 240, 30);
  UITextField *textField = [[UITextField alloc]initWithFrame:textFieldRect];
  
  //  Setting the border style on the textField will allow us to see it more easily
  textField.borderStyle = UITextBorderStyleRoundedRect;
  textField.placeholder = @"Hypnotize me";
  textField.returnKeyType = UIReturnKeyDone;
  
  textField.delegate = self;
  
  [backgroundView addSubview:textField];
  
  self.textField = textField;
  //  Set it as *the* view of this controller
  self.view = backgroundView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
  
  [self drawHypnoticMessage:textField.text];
  
  textField.text = @"";
  [textField resignFirstResponder];
  
  return YES;
}

- (void)drawHypnoticMessage:(NSString *)message{
  
  for (int i = 0; i < 20; i++) {
    
    UILabel *messageLabel = [[UILabel alloc]init];
    
    //  Configure the label's color and text
    messageLabel.backgroundColor = [UIColor clearColor];
    messageLabel.textColor = [UIColor whiteColor];
    messageLabel.text = message;
    
    //  This method resizes the label which will be relative
    //  to the text that it is displaying
    [messageLabel sizeToFit];
    
    //  Get random x value that fits within the hypnosis view's width
    int width = self.view.bounds.size.width - messageLabel.bounds.size.width;
    int y = arc4random() % width;
    
    //  Get random y value that fits within the hypnosis views'height
    int height = self.view.bounds.size.height - messageLabel.bounds.size.height;
    int x = arc4random() % height;
    
    //  Update the label's frame
    CGRect frame = messageLabel.frame;
    frame.origin = CGPointMake(x, y);
    messageLabel.frame = frame;
    
    //  Add the label to the hierarchy
    [self.view addSubview:messageLabel];
    
    //  Set the label's initial alpha
    messageLabel.alpha = 0.0;
    
    //  Animate the alpha to 1.0
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                       messageLabel.alpha = 1.0;
                     }
                     completion:NULL];
    
    [UIView animateKeyframesWithDuration:1.0 delay:0.0 options:0 animations:^{
      [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.8 animations:^{
        messageLabel.center = self.view.center;
      }];
      [UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
        int x = arc4random() % width;
        int y = arc4random() % height;
        messageLabel.center = CGPointMake(x, y);
      }];
    } completion:^(BOOL finished) {
      NSLog(@"Animation finished");
    }];
    
    UIInterpolatingMotionEffect *motionEffect;
    motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.x"
                        type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
    motionEffect.maximumRelativeValue = @-25;
    motionEffect.minimumRelativeValue = @25;
    [messageLabel addMotionEffect:motionEffect];
    
    motionEffect = [[UIInterpolatingMotionEffect alloc]initWithKeyPath:@"center.y"
                        type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
    motionEffect.maximumRelativeValue = @-25;
    motionEffect.minimumRelativeValue = @25;
    [messageLabel addMotionEffect:motionEffect];
  }
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil{
  
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  if (self) {
    //  Set the tab bar item's title
    self.tabBarItem.title = @"Hypnotize";
    
    //  Create a UImage from file
    //  This will use Hypno@2x.png on retina display devices
    UIImage *image = [UIImage imageNamed:@"Hypno.png"];
    
    //  Put that image on the tab bar item
    self.tabBarItem.image = image;
  }
  
  return self;
}

- (void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [UIView animateWithDuration:2.0
                        delay:0.0
       usingSpringWithDamping:0.25
        initialSpringVelocity:0.0
                      options:0
                   animations:^{
                     CGRect frame = CGRectMake(40, 70, 240, 30);
                     self.textField.frame = frame;
                   }
                   completion:NULL];
}
@end
