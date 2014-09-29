//
//  BNRQuizViewController.m
//  Quiz
//
//  Created by John Russel Usi on 9/26/14.
//  Copyright (c) 2014 Klab Cyscorpions. All rights reserved.
//

#import "BNRQuizViewController.h"

@interface BNRQuizViewController ()

@property (nonatomic) int currentQuestionIndex;

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;

@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@end

@implementation BNRQuizViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil{
  
  // Call the init method implemented by the superclass
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  
  if (self) {
    //  Create two arrays filled with questions and answers
    //  and make the pointers point to them
    
    self.questions = @[@"From what is cognac made?",
                       @"What is 7 + 7?",
                       @"What is the capital of the Vermont?"];
    
    self.answers = @[@"Grapes",
                     @"14",
                     @"Montpelier"];
  }
  
  return self;
}

- (IBAction)showQuestion:(id)sender{
  
  //  Step to the next question
  self.currentQuestionIndex++;
  
  //  Is this the last question?
  if (self.currentQuestionIndex == [self.questions count]) {
    
    //  Go back to the first question
    self.currentQuestionIndex == 0;
  }
  
  //  Get the string at the index in the questions array
  NSString *question = self.questions[self.currentQuestionIndex];
  
  //  Display th string in the question label
  self.questionLabel.text = question;
  
  //  Reset the answer label
  self.answerLabel.text = @"???";
}

- (IBAction)showAnswer:(id)sender{
  
  //  What is the answer to the current question?
  NSString *answer = self.answers[self.currentQuestionIndex];
  
  //  Display it to the answer label
  self.answerLabel.text = answer;
}

@end
