//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by John Russel Usi on 9/26/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRHypnosisView.h"

@interface BNRHypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation BNRHypnosisView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {

    self.backgroundColor = [UIColor clearColor];
    self.circleColor = [UIColor grayColor];
  }
  return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
  //  Drawing code
  CGRect bounds = self.bounds;
  
  //  Figure out the center of the bounds rectangle
  CGPoint center;
  center.x = bounds.origin.x + bounds.size.width / 2.0;
  center.y = bounds.origin.y + bounds.size.height /2.0;
  
  //  The largest circle will circumscribe the view
  float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
  
  UIBezierPath *path = [[UIBezierPath alloc]init];
  
  for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
    
    [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
    
    [path addArcWithCenter:center
                    radius:currentRadius
                startAngle:0.0 endAngle:M_PI * 2
                 clockwise:YES];
  }
  
  //  Configure line width to 10 points
  path.lineWidth = 10;
  
  [self.circleColor setStroke];
  
  [path stroke];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
  NSLog(@"%@ was touched", self);
  
  //  Get 3 random numbers between 0 and 1
  float red = (arc4random() % 100 / 100.0);
  float green = (arc4random() % 100 / 100.0);
  float blue = (arc4random() % 100 / 100.0);
  
  UIColor *randomColor = [UIColor colorWithRed:red
                                         green:green
                                          blue:blue
                                         alpha:1.0];
  
  self.circleColor = randomColor;
}

- (void)setCircleColor:(UIColor *)circleColor{
  
  _circleColor = circleColor;
  [self setNeedsDisplay];
}

@end
